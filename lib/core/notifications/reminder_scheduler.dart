import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart' show Locale;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ProviderListenableSelect;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/routes.dart';
import '../../features/dogs/application/dog_providers.dart';
import '../../features/food/application/food_providers.dart';
import '../../features/food/application/purchase_providers.dart';
import '../../features/food/domain/food.dart';
import '../../features/food/domain/food_reminder.dart';
import '../../features/health/application/health_providers.dart';
import '../../features/health/domain/health_reminder.dart';
import '../../features/meds/application/med_providers.dart';
import '../../features/meds/domain/med_schedule.dart';
import '../../features/settings/application/reminder_settings_provider.dart';
import '../../features/weight/application/weight_providers.dart';
import '../../features/weight/domain/weigh_reminder.dart';
import '../../features/weight/domain/weight_stats.dart';
import '../../l10n/app_localizations.dart';
import '../utils/clock.dart';
import '../utils/formatting.dart';
import 'local_notifications.dart';

part 'reminder_scheduler.g.dart';

/// A notification to schedule; [id]s are stable per kind.
class PlannedReminder {
  const PlannedReminder({
    required this.id,
    required this.title,
    required this.body,
    required this.at,
    required this.route,
  });

  final int id;
  final String title;
  final String body;
  final DateTime at;
  final String route;

  @override
  bool operator ==(Object other) =>
      other is PlannedReminder &&
      other.id == id &&
      other.title == title &&
      other.body == body &&
      other.at == at &&
      other.route == route;

  @override
  int get hashCode => Object.hash(id, title, body, at, route);
}

/// Replaces all scheduled notifications with the given plan.
/// Always recomputes from scratch (see CLAUDE.md).
class ReminderScheduler {
  ReminderScheduler(this._notifications);

  final LocalNotifications _notifications;
  Future<void> _queue = Future.value();

  /// Serialized so overlapping resyncs can't interleave cancel/schedule.
  Future<void> resync(List<PlannedReminder> plan) =>
      _queue = _queue.then((_) async {
        try {
          await _notifications.cancelAll();
          for (final r in plan) {
            await _notifications.schedule(
              id: r.id,
              title: r.title,
              body: r.body,
              at: r.at,
              route: r.route,
            );
          }
        } catch (e, st) {
          debugPrint('Reminder resync failed: $e\n$st');
        }
      });
}

@Riverpod(keepAlive: true)
ReminderScheduler reminderScheduler(Ref ref) =>
    ReminderScheduler(ref.watch(localNotificationsProvider));

final _l10n = lookupAppLocalizations(const Locale('pl'));

const _foodIdBase = 1000;
const _weighId = 2000;
const _healthIdBase = 3000;
const _medIdBase = 4000;

/// Planned food reminders for the current dog (empty when signed out).
@Riverpod(keepAlive: true)
List<FoodReminder> foodReminderPlan(Ref ref) {
  final foods = ref.watch(foodsProvider).value ?? const <Food>[];
  final stock = ref.watch(stockProvider);
  final settings = ref.watch(reminderSettingsControllerProvider);
  if (stock == null) return const [];
  final now = ref.read(clockProvider)();
  return [
    for (final f in foods)
      if (stock[f.id] case final s?)
        ?planFoodReminder(food: f, stock: s, settings: settings, now: now),
  ];
}

/// Everything to schedule, or null while data is still loading.
@Riverpod(keepAlive: true)
List<PlannedReminder>? reminderPlan(Ref ref) {
  final food = ref.watch(foodReminderPlanProvider);
  final stockLoaded = ref.watch(stockProvider) != null;
  final weights = ref.watch(weightsProvider).value;
  final health = ref.watch(healthSeriesListProvider);
  final meds = ref.watch(medsProvider).value;
  final doses = ref.watch(medDosesProvider).value;
  if (!stockLoaded ||
      weights == null ||
      health == null ||
      meds == null ||
      doses == null) {
    return null;
  }
  final foods = {
    for (final f in ref.watch(foodsProvider).value ?? const <Food>[]) f.id: f,
  };
  final dogName = ref.watch(currentDogProvider.select((d) => d?.name)) ?? '';
  final settings = ref.watch(reminderSettingsControllerProvider);
  final now = ref.read(clockProvider)();
  final latest = summarizeWeights(weights)?.latest;
  final weighAt = planWeighReminder(
    latest: latest,
    settings: settings,
    now: now,
  );
  final medReminders = planMedReminders(
    meds: meds,
    doses: doses,
    settings: settings,
    now: now,
  );
  final healthReminders = planHealthReminders(
    series: health,
    settings: settings,
    now: now,
  );

  return [
    for (final (i, r) in food.indexed)
      PlannedReminder(
        id: _foodIdBase + i,
        title: _l10n.reminderFoodTitle,
        body: r.daysLeft == null
            ? _l10n.reminderFoodBody(
                foods[r.foodId]?.label ?? '',
                formatKg(r.remainingKg),
              )
            : _l10n.reminderFoodBodyDays(
                foods[r.foodId]?.label ?? '',
                formatKg(r.remainingKg),
                r.daysLeft!.floor(),
              ),
        at: r.at,
        route: Routes.foodDetail(r.foodId),
      ),
    if (weighAt != null && latest != null)
      PlannedReminder(
        id: _weighId,
        title: _l10n.reminderWeighTitle(dogName),
        body: _l10n.reminderWeighBody(
          formatKg(latest.kg),
          DateFormat.MMMMd().format(latest.at),
        ),
        at: weighAt,
        route: Routes.healthWeight,
      ),
    for (final (i, r) in healthReminders.indexed)
      PlannedReminder(
        id: _healthIdBase + i,
        title: switch (r.kind) {
          HealthReminderKind.before => _l10n.reminderHealthSoonTitle(
            r.entry.name,
          ),
          HealthReminderKind.due => _l10n.reminderHealthDueTitle(r.entry.name),
          HealthReminderKind.overdue => _l10n.reminderHealthOverdueTitle(
            r.entry.name,
          ),
        },
        body: _l10n.reminderHealthBody(
          dogName,
          DateFormat.yMMMMd().format(r.entry.nextDue!),
        ),
        at: r.at,
        route: Routes.health,
      ),
    for (final (i, m) in medReminders.indexed)
      PlannedReminder(
        id: _medIdBase + i,
        title: _l10n.reminderMedTitle(m.med.name),
        body: _l10n.reminderMedBody(
          dogName,
          [
            DateFormat.Hm().format(m.slot),
            if (m.med.dose case final dose? when dose.isNotEmpty) dose,
          ].join(' · '),
        ),
        at: m.slot,
        route: Routes.today,
      ),
  ];
}

/// Keeps scheduled notifications in sync with the data. Watched by the
/// app root, so it runs on start and after every relevant change.
@Riverpod(keepAlive: true)
void reminderSync(Ref ref) {
  final plan = ref.watch(reminderPlanProvider);
  // Until data has loaded, keep what is scheduled instead of wiping it.
  if (plan == null) return;
  unawaited(ref.read(reminderSchedulerProvider).resync(plan));
}
