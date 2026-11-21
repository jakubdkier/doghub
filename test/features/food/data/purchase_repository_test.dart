import 'package:dog_app/features/events/data/event_repository.dart';
import 'package:dog_app/features/events/domain/dog_event.dart';
import 'package:dog_app/features/food/data/purchase_repository.dart';
import 'package:dog_app/features/food/domain/purchase.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 11, 21, 12);
  late FakeFirebaseFirestore db;
  late PurchaseRepository repo;

  setUp(() {
    db = FakeFirebaseFirestore();
    repo = PurchaseRepository(db);
  });

  test('add writes allowed keys; soft delete hides it', () async {
    final id = repo.add(
      'h1',
      'd1',
      Purchase(foodId: 'f1', kg: 1.5, at: now, by: 'u1'),
    );
    repo.add(
      'h1',
      'd1',
      Purchase(
        foodId: 'f1',
        kg: 12,
        price: 249.99,
        at: now.add(const Duration(hours: 1)),
        by: 'u1',
      ),
    );
    await pumpEventQueue();

    final raw = (await db.doc('households/h1/dogs/d1/purchases/$id').get())
        .data()!;
    expect(raw.keys.toSet(), {
      'foodId',
      'kg',
      'at',
      'by',
      'createdAt',
      'deleted',
    });

    var all = await repo.watchAll('h1', 'd1').first;
    expect(all.map((p) => p.kg), [12, 1.5]);
    expect(all.first.price, 249.99);

    repo.setDeleted('h1', 'd1', id, deleted: true);
    await pumpEventQueue();
    all = await repo.watchAll('h1', 'd1').first;
    expect(all.map((p) => p.kg), [12]);
  });

  test('watchMeals returns only non-deleted meals', () async {
    final events = EventRepository(db);
    events.add(
      'h1',
      'd1',
      DogEvent(type: EventType.meal, at: now, by: 'u1', grams: 100),
    );
    events.add('h1', 'd1', DogEvent(type: EventType.pee, at: now, by: 'u1'));
    final gone = events.add(
      'h1',
      'd1',
      DogEvent(type: EventType.meal, at: now, by: 'u1', grams: 50),
    );
    events.setDeleted('h1', 'd1', gone, deleted: true);
    await pumpEventQueue();

    final meals = await events.watchMeals('h1', 'd1').first;
    expect(meals.map((m) => m.grams), [100]);
  });
}
