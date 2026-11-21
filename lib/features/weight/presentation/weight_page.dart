import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/clock.dart';
import '../../../core/utils/formatting.dart';
import '../../../l10n/app_localizations.dart';
import '../../household/application/household_providers.dart';
import '../application/weight_providers.dart';
import '../domain/weight_entry.dart';
import '../domain/weight_stats.dart';
import 'weight_chart.dart';
import 'weight_dialog.dart';
import 'weight_labels.dart';

/// `/health/weight`: latest weight, chart by range, all measurements.
class WeightPage extends ConsumerStatefulWidget {
  const WeightPage({super.key});

  @override
  ConsumerState<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends ConsumerState<WeightPage> {
  WeightRange _range = WeightRange.sixMonths;

  Future<void> _add() async {
    final draft = await showWeightDialog(
      context,
      now: ref.read(clockProvider)(),
    );
    if (draft == null) return;
    ref
        .read(weightControllerProvider.notifier)
        .add(kg: draft.kg, day: draft.day);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final weights = ref.watch(weightsProvider).value ?? const <WeightEntry>[];
    final now = ref.watch(clockProvider)();
    final summary = summarizeWeights(weights);
    final points = weightsInRange(weights, _range, now);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.weightTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _add,
        icon: const Icon(Icons.add),
        label: Text(l10n.weightAdd),
      ),
      body: summary == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.weightEmpty, textAlign: TextAlign.center),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
              children: [
                Card(
                  key: const Key('weightSummary'),
                  child: ListTile(
                    leading: const Icon(Icons.monitor_weight_outlined),
                    title: Text(
                      l10n.kgValue(formatKg(summary.latest.kg)),
                      style: textTheme.headlineSmall,
                    ),
                    subtitle: Text(
                      [
                        DateFormat.yMMMMd().format(summary.latest.at),
                        ?weightChangeText(l10n, summary),
                      ].join(' · '),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SegmentedButton<WeightRange>(
                  showSelectedIcon: false,
                  segments: [
                    for (final r in WeightRange.values)
                      ButtonSegment(
                        value: r,
                        label: Text(weightRangeLabel(l10n, r)),
                      ),
                  ],
                  selected: {_range},
                  onSelectionChanged: (s) => setState(() => _range = s.single),
                ),
                const SizedBox(height: 16),
                if (points.length < 2)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      l10n.weightChartTooFew,
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  WeightChart(key: const Key('weightChart'), entries: points),
                const SizedBox(height: 24),
                Text(l10n.weightHistoryHeader, style: textTheme.titleSmall),
                for (final w in weights) _WeightTile(entry: w),
              ],
            ),
    );
  }
}

class _WeightTile extends ConsumerWidget {
  const _WeightTile({required this.entry});

  final WeightEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final author =
        ref.watch(currentHouseholdProvider).value?.nameOf(entry.by) ?? '';
    final id = entry.id!;
    final controller = ref.read(weightControllerProvider.notifier);

    void delete() {
      controller.delete(id);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(l10n.weightDeleted),
            persist: false,
            action: SnackBarAction(
              label: l10n.undo,
              onPressed: () => controller.restore(id),
            ),
          ),
        );
    }

    Future<void> edit() async {
      final draft = await showWeightDialog(
        context,
        initial: entry,
        now: ref.read(clockProvider)(),
      );
      if (draft == null) return;
      controller.update(entry.copyWith(kg: draft.kg, at: draft.day));
    }

    return Dismissible(
      key: ValueKey('weight-$id'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: scheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Icon(Icons.delete_outline, color: scheme.onErrorContainer),
      ),
      // The list updates from the soft delete; don't remove the row twice.
      confirmDismiss: (_) async {
        delete();
        return false;
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(l10n.kgValue(formatKg(entry.kg))),
        subtitle: Text('${DateFormat.yMMMMd().format(entry.at)} · $author'),
        trailing: const Icon(Icons.edit_outlined),
        onTap: edit,
      ),
    );
  }
}
