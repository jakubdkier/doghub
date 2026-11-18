import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/features/events/data/event_repository.dart';
import 'package:dog_app/features/events/domain/dog_event.dart';
import 'package:dog_app/features/events/domain/event_query.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const path = 'households/h1/dogs/d1/events';
  final now = DateTime(2026, 11, 18, 12);
  late FakeFirebaseFirestore db;
  late EventRepository repo;

  setUp(() {
    db = FakeFirebaseFirestore();
    repo = EventRepository(db);
  });

  Future<String> add(DogEvent e) async {
    final id = repo.add('h1', 'd1', e);
    await pumpEventQueue();
    return id;
  }

  test('add writes only the fields allowed by the rules', () async {
    final id = await add(
      DogEvent(
        type: EventType.poop,
        at: now,
        by: 'u1',
        poopScore: 4,
        poopColor: PoopColor.brown,
        note: '  ',
      ),
    );
    final raw = (await db.doc('$path/$id').get()).data()!;
    expect(raw.keys.toSet(), {
      'type',
      'at',
      'by',
      'createdAt',
      'deleted',
      'poopScore',
      'poopColor',
    });
    expect(raw['type'], 'poop');
    expect(raw['poopColor'], 'brown');
    expect(raw['deleted'], false);
    expect((raw['at'] as Timestamp).toDate(), now);
  });

  test(
    'update changes values, removes cleared ones, keeps the author',
    () async {
      final id = await add(
        DogEvent(
          type: EventType.meal,
          at: now,
          by: 'u1',
          grams: 100,
          foodId: 'f1',
          note: 'rano',
        ),
      );
      final original = await repo.watchOne('h1', 'd1', id).first;
      repo.update(
        'h1',
        'd1',
        original!.copyWith(grams: 150, foodId: null, note: null, by: 'u2'),
      );
      await pumpEventQueue();

      final raw = (await db.doc('$path/$id').get()).data()!;
      expect(raw['grams'], 150);
      expect(raw['by'], 'u1');
      expect(raw.containsKey('foodId'), isFalse);
      expect(raw.containsKey('note'), isFalse);
    },
  );

  test('watchSince returns recent non-deleted events, newest first', () async {
    await add(
      DogEvent(
        type: EventType.pee,
        at: now.subtract(const Duration(days: 9)),
        by: 'u1',
      ),
    );
    final a = await add(
      DogEvent(
        type: EventType.pee,
        at: now.subtract(const Duration(hours: 2)),
        by: 'u1',
      ),
    );
    final b = await add(
      DogEvent(type: EventType.walk, at: now, by: 'u1', durationMin: 30),
    );
    final gone = await add(DogEvent(type: EventType.pee, at: now, by: 'u1'));
    repo.setDeleted('h1', 'd1', gone, deleted: true);
    await pumpEventQueue();

    final events = await repo
        .watchSince('h1', 'd1', now.subtract(const Duration(days: 7)))
        .first;
    expect(events.map((e) => e.id), [b, a]);

    repo.setDeleted('h1', 'd1', gone, deleted: false);
    await pumpEventQueue();
    final restored = await repo
        .watchSince('h1', 'd1', now.subtract(const Duration(days: 7)))
        .first;
    expect(restored.map((e) => e.id), containsAll([gone, a, b]));
  });

  test('watchHistory pages and filters by type', () async {
    for (var i = 0; i < 3; i++) {
      await add(
        DogEvent(
          type: EventType.pee,
          at: now.subtract(Duration(hours: i)),
          by: 'u1',
        ),
      );
    }
    await add(DogEvent(type: EventType.meal, at: now, by: 'u1', grams: 80));

    final firstPage = await repo
        .watchHistory('h1', 'd1', const EventQuery(limit: 2))
        .first;
    expect(firstPage.events, hasLength(2));
    expect(firstPage.hasMore, isTrue);

    final all = await repo.watchHistory('h1', 'd1', const EventQuery()).first;
    expect(all.events, hasLength(4));
    expect(all.hasMore, isFalse);

    final meals = await repo
        .watchHistory('h1', 'd1', const EventQuery(types: {EventType.meal}))
        .first;
    expect(meals.events.map((e) => e.type), [EventType.meal]);
  });
}
