import '../../events/domain/event_timeline.dart';
import '../../settings/domain/reminder_settings.dart';
import 'health_entry.dart';
import 'health_schedule.dart';

enum HealthReminderKind { before, due, overdue }

class HealthReminder {
  const HealthReminder({
    required this.entry,
    required this.at,
    required this.kind,
  });

  /// Latest entry of the series.
  final HealthEntry entry;
  final DateTime at;
  final HealthReminderKind kind;

  @override
  bool operator ==(Object other) =>
      other is HealthReminder &&
      other.entry == entry &&
      other.at == at &&
      other.kind == kind;

  @override
  int get hashCode => Object.hash(entry, at, kind);
}

/// Per series with a due date: N days before (1 for vet visits) and on the
/// day, at the settings' hour. Once overdue: one reminder at the next such
/// hour (repeats daily as the plan is recomputed).
List<HealthReminder> planHealthReminders({
  required List<HealthSeries> series,
  required ReminderSettings settings,
  required DateTime now,
}) {
  if (!settings.healthEnabled) return const [];
  DateTime atHour(DateTime d) =>
      DateTime(d.year, d.month, d.day, settings.hour, settings.minute);

  final result = <HealthReminder>[];
  for (final s in series) {
    final due = s.nextDue;
    if (due == null) continue;
    final dueDay = startOfDay(due);
    final daysBefore = s.type == HealthType.vet ? 1 : settings.healthDaysBefore;
    final before = atHour(
      DateTime(dueDay.year, dueDay.month, dueDay.day - daysBefore),
    );
    final dueAt = atHour(dueDay);
    if (before.isAfter(now)) {
      result.add(
        HealthReminder(
          entry: s.latest,
          at: before,
          kind: HealthReminderKind.before,
        ),
      );
    }
    if (dueAt.isAfter(now)) {
      result.add(
        HealthReminder(
          entry: s.latest,
          at: dueAt,
          kind: HealthReminderKind.due,
        ),
      );
    } else {
      var at = atHour(now);
      if (!at.isAfter(now)) {
        at = atHour(DateTime(now.year, now.month, now.day + 1));
      }
      result.add(
        HealthReminder(
          entry: s.latest,
          at: at,
          kind: HealthReminderKind.overdue,
        ),
      );
    }
  }
  return result;
}
