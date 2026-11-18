import 'package:freezed_annotation/freezed_annotation.dart';

import 'dog_event.dart';

part 'event_query.freezed.dart';

/// History view: type filter (empty = all) and how many entries to load.
@freezed
abstract class EventQuery with _$EventQuery {
  static const pageSize = 50;

  const factory EventQuery({
    @Default(<EventType>{}) Set<EventType> types,
    @Default(EventQuery.pageSize) int limit,
  }) = _EventQuery;

  const EventQuery._();

  EventQuery toggle(EventType type) => EventQuery(
    types: types.contains(type) ? ({...types}..remove(type)) : {...types, type},
  );

  EventQuery nextPage() => copyWith(limit: limit + pageSize);
}

/// One page of history. [hasMore] means the query hit its limit.
@freezed
abstract class EventPage with _$EventPage {
  const factory EventPage({
    required List<DogEvent> events,
    required bool hasMore,
  }) = _EventPage;
}
