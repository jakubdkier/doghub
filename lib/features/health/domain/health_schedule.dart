import '../../../core/utils/dates.dart';
import '../../events/domain/event_timeline.dart';
import 'health_entry.dart';

enum HealthStatus { ok, soon, overdue, none }

/// Days before the due date when a series counts as "wkrótce".
const healthSoonDays = 14;

/// Next due date for something done on [date] with [intervalMonths].
DateTime? nextDueFor(DateTime date, int? intervalMonths) =>
    intervalMonths == null ? null : dueNoonOf(addMonths(date, intervalMonths));

HealthStatus statusOf(DateTime? nextDue, DateTime now) {
  if (nextDue == null) return HealthStatus.none;
  final days = startOfDay(nextDue).difference(startOfDay(now)).inDays;
  if (days < 0) return HealthStatus.overdue;
  if (days <= healthSoonDays) return HealthStatus.soon;
  return HealthStatus.ok;
}

/// All entries of one series; [latest] decides the status.
class HealthSeries {
  const HealthSeries({required this.latest, required this.status});

  final HealthEntry latest;
  final HealthStatus status;

  String get key => latest.seriesKey;
  HealthType get type => latest.type;
  DateTime? get nextDue => latest.nextDue;

  /// Most urgent first: overdue, then by due date; undated last.
  static int byUrgency(HealthSeries a, HealthSeries b) {
    final da = a.nextDue, db = b.nextDue;
    if (da == null && db == null) return a.latest.name.compareTo(b.latest.name);
    if (da == null) return 1;
    if (db == null) return -1;
    return da.compareTo(db);
  }
}

/// One series per [HealthEntry.seriesKey], most urgent first.
List<HealthSeries> healthSeries(Iterable<HealthEntry> entries, DateTime now) {
  final latest = <String, HealthEntry>{};
  for (final e in entries.where((e) => !e.deleted)) {
    final current = latest[e.seriesKey];
    if (current == null || HealthEntry.newestFirst(e, current) < 0) {
      latest[e.seriesKey] = e;
    }
  }
  return [
    for (final e in latest.values)
      HealthSeries(latest: e, status: statusOf(e.nextDue, now)),
  ]..sort(HealthSeries.byUrgency);
}

/// Series that need attention (overdue or soon), most urgent first.
List<HealthSeries> attentionNeeded(List<HealthSeries> series) => [
  for (final s in series)
    if (s.status == HealthStatus.overdue || s.status == HealthStatus.soon) s,
];
