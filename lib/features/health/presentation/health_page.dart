import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../core/utils/clock.dart';
import '../../../core/utils/formatting.dart';
import '../../../l10n/app_localizations.dart';
import '../../weight/application/weight_providers.dart';
import '../../weight/domain/weight_entry.dart';
import '../../weight/domain/weight_stats.dart';
import '../../weight/presentation/weight_chart.dart';
import '../../weight/presentation/weight_labels.dart';
import '../../meds/application/med_providers.dart';
import '../../meds/domain/med.dart';
import '../../meds/domain/med_dose.dart';
import '../../meds/domain/med_schedule.dart';
import '../../meds/presentation/med_labels.dart';
import '../application/health_providers.dart';
import '../domain/health_entry.dart';
import '../domain/health_schedule.dart';
import 'health_labels.dart';

/// Health tab: attention banner, weight, and a section per health type.
class HealthPage extends ConsumerWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final weights = ref.watch(weightsProvider).value ?? const <WeightEntry>[];
    final now = ref.watch(clockProvider)();
    final summary = summarizeWeights(weights);
    final points = weightsInRange(weights, WeightRange.sixMonths, now);
    final series =
        ref.watch(healthSeriesListProvider) ?? const <HealthSeries>[];
    final attention = attentionNeeded(series);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navHealth),
        actions: [
          IconButton(
            tooltip: l10n.settingsTitle,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(Routes.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.healthNew),
        icon: const Icon(Icons.add),
        label: Text(l10n.healthAdd),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
        children: [
          if (attention.isNotEmpty) ...[
            HealthAttentionBanner(series: attention, now: now),
            const SizedBox(height: 8),
          ],
          for (final type in HealthType.values)
            _SectionCard(
              type: type,
              series: [
                for (final s in series)
                  if (s.type == type) s,
              ],
              now: now,
            ),
          _MedsCard(now: now),
          const SizedBox(height: 8),
          Card(
            key: const Key('weightCard'),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => context.go(Routes.healthWeight),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.monitor_weight_outlined),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.weightTitle,
                            style: textTheme.titleMedium,
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (summary == null)
                      Text(l10n.weightEmpty)
                    else ...[
                      Text(
                        l10n.kgValue(formatKg(summary.latest.kg)),
                        style: textTheme.headlineSmall,
                      ),
                      Text(
                        [
                          DateFormat.yMMMMd().format(summary.latest.at),
                          ?weightChangeText(l10n, summary),
                        ].join(' · '),
                      ),
                      if (points.length >= 2) ...[
                        const SizedBox(height: 12),
                        WeightChart(entries: points, height: 80, compact: true),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.type,
    required this.series,
    required this.now,
  });

  final HealthType type;
  final List<HealthSeries> series;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Card(
      key: Key('healthSection-${type.name}'),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(Routes.healthType(type.name)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(type.icon),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(type.label(l10n), style: textTheme.titleMedium),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 8),
              if (series.isEmpty)
                Text(l10n.healthNoEntries, style: textTheme.bodySmall)
              else
                for (final s in series.take(3))
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(s.latest.name),
                              Text(
                                dueText(l10n, s.nextDue, now),
                                style: textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        HealthStatusChip(status: s.status),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MedsCard extends ConsumerWidget {
  const _MedsCard({required this.now});

  final DateTime now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final meds = (ref.watch(medsProvider).value ?? const <Med>[])
        .where((m) => m.active)
        .toList();
    final doses = ref.watch(medDosesProvider).value ?? const <MedDose>[];
    return Card(
      key: const Key('medsCard'),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(Routes.meds),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.medication_outlined),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(l10n.medsTitle, style: textTheme.titleMedium),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 8),
              if (meds.isEmpty)
                Text(l10n.medsEmpty, style: textTheme.bodySmall)
              else
                for (final m in meds)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(medTitle(m)),
                        Text(switch (adherence(m, doses, now)) {
                          (given: final g, expected: final e) when e > 0 =>
                            l10n.medAdherence(g, e),
                          _ => scheduleText(l10n, m),
                        }, style: textTheme.bodySmall),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
