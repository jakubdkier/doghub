import 'package:dog_app/features/events/domain/dog_event.dart';
import 'package:dog_app/features/events/domain/event_query.dart';
import 'package:dog_app/features/events/domain/event_timeline.dart';
import 'package:flutter_test/flutter_test.dart';

DogEvent ev(
  EventType type,
  DateTime at, {
  String id = 'x',
  int? grams,
  String? foodId,
  bool deleted = false,
}) => DogEvent(
  id: id,
  type: type,
  at: at,
  by: 'u1',
  grams: grams,
  foodId: foodId,
  deleted: deleted,
);

void main() {
  final t = DateTime(2026, 11, 18, 12);

  group('isValid', () {
    DogEvent base(EventType type) => DogEvent(type: type, at: t, by: 'u1');

    test('meal needs grams within bounds', () {
      expect(base(EventType.meal).isValid, isFalse);
      expect(base(EventType.meal).copyWith(grams: 0).isValid, isFalse);
      expect(base(EventType.meal).copyWith(grams: 120).isValid, isTrue);
      expect(base(EventType.meal).copyWith(grams: 5001).isValid, isFalse);
    });

    test('poop needs a Bristol score 1-7', () {
      expect(base(EventType.poop).isValid, isFalse);
      expect(base(EventType.poop).copyWith(poopScore: 8).isValid, isFalse);
      expect(base(EventType.poop).copyWith(poopScore: 4).isValid, isTrue);
    });

    test('walk needs a duration', () {
      expect(base(EventType.walk).isValid, isFalse);
      expect(base(EventType.walk).copyWith(durationMin: 30).isValid, isTrue);
    });

    test('note needs non-blank text; notes are length-limited', () {
      expect(base(EventType.note).copyWith(note: '  ').isValid, isFalse);
      expect(base(EventType.note).copyWith(note: 'Kichał').isValid, isTrue);
      expect(base(EventType.pee).isValid, isTrue);
      expect(base(EventType.pee).copyWith(note: 'x' * 501).isValid, isFalse);
    });
  });

  test('groupByDay groups by calendar day, newest first', () {
    final groups = groupByDay([
      ev(EventType.pee, DateTime(2026, 11, 17, 23, 59), id: 'a'),
      ev(EventType.pee, DateTime(2026, 11, 18, 0, 1), id: 'b'),
      ev(EventType.walk, DateTime(2026, 11, 18, 9), id: 'c'),
    ]);
    expect(groups.map((g) => g.day), [
      DateTime(2026, 11, 18),
      DateTime(2026, 11, 17),
    ]);
    expect(groups.first.events.map((e) => e.id), ['c', 'b']);
  });

  test('latestOfType skips deleted entries and other types', () {
    final events = [
      ev(EventType.meal, t, id: 'deleted', deleted: true),
      ev(EventType.walk, t, id: 'walk'),
      ev(EventType.meal, t.subtract(const Duration(hours: 3)), id: 'old'),
      ev(EventType.meal, t.subtract(const Duration(hours: 1)), id: 'new'),
    ];
    expect(latestOfType(events, EventType.meal)?.id, 'new');
    expect(latestOfType(events, EventType.poop), isNull);
  });

  test('eventsOnDay returns only that day and drops deleted', () {
    final events = [
      ev(EventType.pee, DateTime(2026, 11, 17, 22), id: 'yesterday'),
      ev(EventType.pee, DateTime(2026, 11, 18, 8), id: 'morning'),
      ev(EventType.pee, DateTime(2026, 11, 18, 10), id: 'gone', deleted: true),
      ev(EventType.pee, DateTime(2026, 11, 18, 11), id: 'late'),
    ];
    expect(eventsOnDay(events, t).map((e) => e.id), ['late', 'morning']);
  });

  test('mealDefaults take the last meal', () {
    expect(mealDefaults(const []), (foodId: null, grams: null));
    final events = [
      ev(EventType.meal, t.subtract(const Duration(hours: 5)), grams: 100),
      ev(EventType.meal, t, grams: 150, foodId: 'f1'),
    ];
    expect(mealDefaults(events), (foodId: 'f1', grams: 150));
  });

  test('EventQuery toggles types and resets paging', () {
    const q = EventQuery();
    final paged = q.nextPage();
    expect(paged.limit, EventQuery.pageSize * 2);

    final meals = paged.toggle(EventType.meal);
    expect(meals.types, {EventType.meal});
    expect(meals.limit, EventQuery.pageSize);
    expect(meals.toggle(EventType.meal).types, isEmpty);
    expect(meals.toggle(EventType.meal), const EventQuery());
  });
}
