import 'weight_entry.dart';

/// Chart range.
enum WeightRange {
  threeMonths(3),
  sixMonths(6),
  year(12),
  all(null);

  const WeightRange(this.months);

  final int? months;

  /// Start of the range, or null for everything.
  DateTime? since(DateTime now) =>
      months == null ? null : DateTime(now.year, now.month - months!, now.day);
}

/// Non-deleted entries within [range], oldest first (for charts).
List<WeightEntry> weightsInRange(
  Iterable<WeightEntry> entries,
  WeightRange range,
  DateTime now,
) {
  final since = range.since(now);
  return entries
      .where((e) => !e.deleted && (since == null || !e.at.isBefore(since)))
      .toList()
    ..sort((a, b) => WeightEntry.newestFirst(b, a));
}

/// Latest measurement and how it compares with the one before it.
class WeightSummary {
  const WeightSummary({required this.latest, this.previous});

  final WeightEntry latest;
  final WeightEntry? previous;

  double? get change =>
      previous == null ? null : _round1(latest.kg - previous!.kg);

  static double _round1(double v) => (v * 10).round() / 10;
}

WeightSummary? summarizeWeights(Iterable<WeightEntry> entries) {
  final sorted = entries.where((e) => !e.deleted).toList()
    ..sort(WeightEntry.newestFirst);
  if (sorted.isEmpty) return null;
  return WeightSummary(
    latest: sorted.first,
    previous: sorted.length > 1 ? sorted[1] : null,
  );
}
