import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/app_localizations.dart';
import '../../events/domain/event_timeline.dart';
import '../domain/health_entry.dart';
import '../domain/health_schedule.dart';

extension HealthTypeUi on HealthType {
  String label(AppLocalizations l10n) => switch (this) {
    HealthType.vaccination => l10n.healthVaccination,
    HealthType.deworming => l10n.healthDeworming,
    HealthType.ticks => l10n.healthTicks,
    HealthType.vet => l10n.healthVet,
  };

  IconData get icon => switch (this) {
    HealthType.vaccination => Icons.vaccines_outlined,
    HealthType.deworming => Icons.medication_outlined,
    HealthType.ticks => Icons.bug_report_outlined,
    HealthType.vet => Icons.local_hospital_outlined,
  };
}

extension HealthStatusUi on HealthStatus {
  String? label(AppLocalizations l10n) => switch (this) {
    HealthStatus.ok => l10n.healthStatusOk,
    HealthStatus.soon => l10n.healthStatusSoon,
    HealthStatus.overdue => l10n.healthStatusOverdue,
    HealthStatus.none => null,
  };

  /// (background, foreground) for the status chip.
  (Color, Color) colors(ColorScheme scheme) => switch (this) {
    HealthStatus.overdue => (scheme.errorContainer, scheme.onErrorContainer),
    HealthStatus.soon => (scheme.tertiaryContainer, scheme.onTertiaryContainer),
    _ => (scheme.secondaryContainer, scheme.onSecondaryContainer),
  };
}

/// "termin 12 mar 2027 · za 5 dni" / "termin 1 lis 2026 · 20 dni temu".
String dueText(AppLocalizations l10n, DateTime? due, DateTime now) {
  if (due == null) return l10n.healthNoNextDue;
  final days = startOfDay(due).difference(startOfDay(now)).inDays;
  final relative = days >= 0
      ? l10n.healthDueIn(days)
      : l10n.healthOverdueBy(-days);
  return '${l10n.healthNextDue(DateFormat.yMMMd().format(due))} · $relative';
}

class HealthStatusChip extends StatelessWidget {
  const HealthStatusChip({super.key, required this.status});

  final HealthStatus status;

  @override
  Widget build(BuildContext context) {
    final label = status.label(AppLocalizations.of(context));
    if (label == null) return const SizedBox.shrink();
    final (bg, fg) = status.colors(Theme.of(context).colorScheme);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fg),
      ),
    );
  }
}

/// Banner listing series that are overdue or due soon; tap opens Health.
class HealthAttentionBanner extends StatelessWidget {
  const HealthAttentionBanner({
    super.key,
    required this.series,
    required this.now,
    this.onTap,
  });

  final List<HealthSeries> series;
  final DateTime now;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final overdue = series.any((s) => s.status == HealthStatus.overdue);
    return Card(
      key: const Key('healthAttention'),
      color: overdue ? scheme.errorContainer : scheme.tertiaryContainer,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(overdue ? Icons.error_outline : Icons.event_note),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.healthAttentionBanner(series.length),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    for (final s in series.take(3))
                      Text(
                        '${s.latest.name} · ${dueText(l10n, s.nextDue, now)}',
                      ),
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
