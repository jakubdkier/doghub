import 'dog_event.dart';

DateTime startOfDay(DateTime t) => DateTime(t.year, t.month, t.day);

/// Events grouped by calendar day, newest day and newest event first.
List<({DateTime day, List<DogEvent> events})> groupByDay(
  Iterable<DogEvent> events,
) {
  final byDay = <DateTime, List<DogEvent>>{};
  for (final e in events) {
    byDay.putIfAbsent(startOfDay(e.at), () => []).add(e);
  }
  final days = byDay.keys.toList()..sort((a, b) => b.compareTo(a));
  return [
    for (final d in days)
      (day: d, events: byDay[d]!..sort(DogEvent.newestFirst)),
  ];
}

/// Most recent non-deleted event of [type], or null.
DogEvent? latestOfType(Iterable<DogEvent> events, EventType type) {
  DogEvent? latest;
  for (final e in events) {
    if (e.deleted || e.type != type) continue;
    if (latest == null || e.at.isAfter(latest.at)) latest = e;
  }
  return latest;
}

/// Non-deleted events on the same calendar day as [now], newest first.
List<DogEvent> eventsOnDay(Iterable<DogEvent> events, DateTime now) {
  final day = startOfDay(now);
  return events.where((e) => !e.deleted && startOfDay(e.at) == day).toList()
    ..sort(DogEvent.newestFirst);
}

/// Defaults for a new meal: the last meal's food and portion.
({String? foodId, int? grams}) mealDefaults(Iterable<DogEvent> events) {
  final last = latestOfType(events, EventType.meal);
  return (foodId: last?.foodId, grams: last?.grams);
}
