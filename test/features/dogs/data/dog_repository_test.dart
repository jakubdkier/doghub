import 'package:dog_app/features/dogs/data/dog_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 11, 18, 12);
  late FakeFirebaseFirestore db;
  late DogRepository dogs;

  setUp(() {
    db = FakeFirebaseFirestore();
    dogs = DogRepository(db, clock: () => now);
  });

  test('add writes the dog and its starting weight by the user', () async {
    final id = dogs.add(
      householdId: 'h1',
      uid: 'alice',
      name: 'Burek',
      breed: 'Kundel',
      birthDate: DateTime(2020, 5, 1),
      startWeightKg: 12.5,
    );
    await pumpEventQueue();

    final list = await dogs.watchAll('h1').first;
    expect(list.single.id, id);
    expect(list.single.name, 'Burek');
    expect(list.single.breed, 'Kundel');
    expect(list.single.birthDate, DateTime(2020, 5, 1));

    final weights = await db.collection('households/h1/dogs/$id/weights').get();
    final w = weights.docs.single.data();
    expect(w['kg'], 12.5);
    expect(w['by'], 'alice');
  });

  test('add without optional fields writes only allowed keys', () async {
    final id = dogs.add(householdId: 'h1', uid: 'alice', name: 'Azor');
    await pumpEventQueue();

    final raw = (await db.doc('households/h1/dogs/$id').get()).data()!;
    expect(raw.keys.toSet(), {'name', 'createdAt'});
    final weights = await db.collection('households/h1/dogs/$id/weights').get();
    expect(weights.docs, isEmpty);
  });
}
