import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/features/weight/data/weight_repository.dart';
import 'package:dog_app/features/weight/domain/weight_entry.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const path = 'households/h1/dogs/d1/weights';
  late FakeFirebaseFirestore db;
  late WeightRepository repo;

  setUp(() {
    db = FakeFirebaseFirestore();
    repo = WeightRepository(db);
  });

  test('add stores the day at noon with rule-compliant keys', () async {
    final id = repo.add(
      'h1',
      'd1',
      WeightEntry(kg: 12.5, at: DateTime(2026, 11, 21, 8, 15), by: 'u1'),
    );
    await pumpEventQueue();
    final raw = (await db.doc('$path/$id').get()).data()!;
    expect(raw.keys.toSet(), {'kg', 'at', 'by', 'createdAt', 'deleted'});
    expect((raw['at'] as Timestamp).toDate(), DateTime(2026, 11, 21, 12));
  });

  test(
    'update keeps the author; soft delete hides; old entries load',
    () async {
      await db.doc('$path/old').set({
        'kg': 11,
        'at': Timestamp.fromDate(DateTime(2026, 1, 1)),
        'by': 'alice',
      });
      final id = repo.add(
        'h1',
        'd1',
        WeightEntry(kg: 12.5, at: DateTime(2026, 11, 21), by: 'alice'),
      );
      await pumpEventQueue();

      var all = await repo.watchAll('h1', 'd1').first;
      expect(all.map((e) => e.kg), [12.5, 11]);

      repo.update(
        'h1',
        'd1',
        all.first.copyWith(kg: 12.8, at: DateTime(2026, 11, 20), by: 'u1'),
      );
      repo.setDeleted('h1', 'd1', 'old', deleted: true);
      await pumpEventQueue();

      all = await repo.watchAll('h1', 'd1').first;
      expect(all.single.kg, 12.8);
      expect(all.single.at, DateTime(2026, 11, 20, 12));
      expect((await db.doc('$path/$id').get())['by'], 'alice');
    },
  );
}
