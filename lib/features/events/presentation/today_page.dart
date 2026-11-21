import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../dogs/application/dog_providers.dart';
import '../../food/application/food_providers.dart';
import '../../food/application/purchase_providers.dart';
import '../../food/domain/food.dart';
import '../../food/presentation/stock_labels.dart';
import '../../health/application/health_providers.dart';
import '../../health/domain/health_schedule.dart';
import '../../health/presentation/health_labels.dart';
import '../../meds/presentation/today_meds_section.dart';
import '../../settings/application/reminder_settings_provider.dart';
import '../application/event_providers.dart';
import '../application/hidden_events.dart';
import '../domain/dog_event.dart';
import '../domain/event_timeline.dart';
import 'event_labels.dart';
import 'event_tile.dart';
import 'quick_add.dart';

class TodayPage extends ConsumerStatefulWidget {
  const TodayPage({super.key});

  @override
  ConsumerState<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends ConsumerState<TodayPage> {
  Timer? _ticker;
  late DateTime _day;

  @override
  void initState() {
    super.initState();
    _day = startOfDay(ref.read(clockProvider)());
    // Keeps "x min temu" fresh and rolls the window over at midnight.
    _ticker = Timer.periodic(const Duration(minutes: 1), (_) {
      final today = startOfDay(ref.read(clockProvider)());
      if (today != _day) {
        _day = today;
        ref.invalidate(recentEventsProvider);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dog = ref.watch(currentDogProvider);
    final now = ref.watch(clockProvider)();
    final hidden = ref.watch(hiddenEventsProvider);
    final recent = (ref.watch(recentEventsProvider).value ?? const <DogEvent>[])
        .where((e) => !hidden.contains(e.id))
        .toList();
    final today = eventsOnDay(recent, now);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          dog == null ? l10n.navToday : '${dog.name} · ${l10n.navToday}',
        ),
        actions: [
          IconButton(
            tooltip: l10n.settingsTitle,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(Routes.settings),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          if (attentionNeeded(
                ref.watch(healthSeriesListProvider) ?? const <HealthSeries>[],
              )
              case final attention when attention.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: HealthAttentionBanner(
                series: attention,
                now: now,
                onTap: () => context.go(Routes.health),
              ),
            ),
          const _QuickActions(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(l10n.recentHeader, style: textTheme.titleMedium),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final type in const [
                  EventType.meal,
                  EventType.poop,
                  EventType.walk,
                ])
                  Expanded(
                    child: _LastTile(
                      type: type,
                      last: latestOfType(recent, type),
                      now: now,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _FoodStockTile(recent: recent),
          ),
          const TodayMedsSection(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(l10n.todayTimelineHeader, style: textTheme.titleMedium),
          ),
          if (today.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(l10n.todayEmpty, style: textTheme.bodyMedium),
            )
          else
            for (final e in today) EventTile(event: e),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        children: [
          for (final type in EventType.values)
            Expanded(
              child: Column(
                children: [
                  IconButton.filledTonal(
                    key: Key('quickAdd-${type.name}'),
                    iconSize: 28,
                    tooltip: type.label(l10n),
                    icon: Icon(type.icon),
                    onPressed: () => showQuickAddSheet(context, type),
                  ),
                  Text(
                    type.label(l10n),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _LastTile extends StatelessWidget {
  const _LastTile({required this.type, required this.last, required this.now});

  final EventType type;
  final DogEvent? last;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final last = this.last;
    return Card(
      key: Key('last-${type.name}'),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: last == null
            ? () => showQuickAddSheet(context, type)
            : () => context.push(Routes.event(last.id!)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(type.icon),
              const SizedBox(height: 8),
              Text(type.label(l10n), style: textTheme.labelLarge),
              Text(
                last == null ? l10n.recentNone : formatAgo(l10n, last.at, now),
                style: last == null
                    ? textTheme.bodySmall
                    : textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Stock of the food from the last meal (or the only food in use).
class _FoodStockTile extends ConsumerWidget {
  const _FoodStockTile({required this.recent});

  final List<DogEvent> recent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final foods = ref.watch(foodsProvider).value ?? const <Food>[];
    final food = currentFood(
      foods,
      latestOfType(recent, EventType.meal)?.foodId,
    );
    final stock = food == null ? null : ref.watch(stockProvider)?[food.id];
    final threshold = ref.watch(
      reminderSettingsControllerProvider.select((s) => s.foodThresholdKg),
    );
    final low =
        stock != null && stock.hasPurchases && stock.remainingKg <= threshold;

    return Card(
      key: const Key('foodStockTile'),
      color: low ? scheme.errorContainer : null,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: Icon(low ? Icons.warning_amber : Icons.set_meal_outlined),
        title: Text(food?.label ?? l10n.navFood),
        subtitle: Text(
          food == null ? l10n.stockUnknownFood : stockSummary(l10n, stock),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => food == null
            ? context.go(Routes.food)
            : context.push(Routes.foodDetail(food.id)),
      ),
    );
  }
}
