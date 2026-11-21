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

/// Health tab. Stage 5: weight section; vaccinations etc. in stage 6.
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
          const SizedBox(height: 16),
          Text(
            l10n.healthMoreSoon,
            style: textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
