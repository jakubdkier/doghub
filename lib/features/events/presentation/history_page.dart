import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../application/event_providers.dart';
import '../application/hidden_events.dart';
import '../domain/dog_event.dart';
import '../domain/event_timeline.dart';
import 'event_labels.dart';
import 'event_tile.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final query = ref.watch(historyQueryProvider);
    final async = ref.watch(historyProvider);
    final page = async.value;
    final hidden = ref.watch(hiddenEventsProvider);
    final now = ref.watch(clockProvider)();
    final groups = groupByDay(
      (page?.events ?? const <DogEvent>[]).where((e) => !hidden.contains(e.id)),
    );
    final hasMore = page?.hasMore ?? false;

    final items = <Widget>[
      for (final g in groups) ...[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            formatDay(l10n, g.day, now),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        for (final e in g.events) EventTile(event: e),
      ],
      if (hasMore)
        const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navHistory)),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _chip(
                  label: l10n.historyFilterAll,
                  selected: query.types.isEmpty,
                  onSelected: () =>
                      ref.read(historyQueryProvider.notifier).clearTypes(),
                ),
                for (final type in EventType.values)
                  _chip(
                    key: Key('filter-${type.name}'),
                    label: type.label(l10n),
                    selected: query.types.contains(type),
                    onSelected: () =>
                        ref.read(historyQueryProvider.notifier).toggle(type),
                  ),
              ],
            ),
          ),
          Expanded(
            child: switch (async) {
              AsyncValue(hasValue: false, isLoading: true) => const Center(
                child: CircularProgressIndicator(),
              ),
              AsyncError() when page == null => Center(
                child: Text(l10n.genericError),
              ),
              _ when groups.isEmpty && !hasMore => Center(
                child: Text(l10n.historyEmpty),
              ),
              _ => NotificationListener<ScrollNotification>(
                onNotification: (n) {
                  if (hasMore &&
                      !async.isLoading &&
                      n.metrics.extentAfter < 400) {
                    ref.read(historyQueryProvider.notifier).loadMore();
                  }
                  return false;
                },
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 24),
                  children: items,
                ),
              ),
            },
          ),
        ],
      ),
    );
  }

  Widget _chip({
    Key? key,
    required String label,
    required bool selected,
    required VoidCallback onSelected,
  }) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: FilterChip(
      key: key,
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
    ),
  );
}
