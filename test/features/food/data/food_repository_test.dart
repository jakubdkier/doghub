import 'package:dog_app/features/food/data/food_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore db;
  late FoodRepository repo;

  setUp(() {
    db = FakeFirebaseFirestore();
    repo = FoodRepository(db);
  });

  test('add writes allowed keys and watchAll sorts by label', () async {
    final id = repo.add('h1', 'd1', name: 'Puppy', brand: '  ');
    repo.add('h1', 'd1', name: 'Adult', brand: 'Acana');
    await pumpEventQueue();

    final raw = (await db.doc('households/h1/dogs/d1/foods/$id').get()).data()!;
    expect(raw.keys.toSet(), {'name', 'active', 'createdAt'});

    final foods = await repo.watchAll('h1', 'd1').first;
    expect(foods.map((f) => f.label), ['Acana Adult', 'Puppy']);
  });

  test('update archives and clears the brand', () async {
    final id = repo.add('h1', 'd1', name: 'Adult', brand: 'Acana');
    await pumpEventQueue();
    final food = (await repo.watchAll('h1', 'd1').first).single;

    repo.update('h1', 'd1', food.copyWith(brand: null, active: false));
    await pumpEventQueue();

    final raw = (await db.doc('households/h1/dogs/d1/foods/$id').get()).data()!;
    expect(raw.containsKey('brand'), isFalse);
    expect(raw['active'], false);
  });
}
