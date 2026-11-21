import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/features/meds/data/med_repository.dart';
import 'package:dog_app/features/meds/domain/med.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore db;
  late MedRepository repo;
  final now = DateTime(2026, 11, 21, 9);

  setUp(() {
    db = FakeFirebaseFirestore();
    repo = MedRepository(db);
  });

  test(
    'save creates with rule-compliant keys and updates clear optionals',
    () async {
      final id = repo.newMedId('h1', 'd1');
      final med = Med(
        id: id,
        name: ' Magnez ',
        dose: '1 tabletka',
        times: const [MedTime(20, 0), MedTime(8, 0)],
        startDate: DateTime(2026, 11, 21, 9),
        endDate: DateTime(2026, 12, 1),
      );
      repo.saveMed('h1', 'd1', med, isNew: true);
      await pumpEventQueue();
      var raw = (await db.doc('households/h1/dogs/d1/meds/$id').get()).data()!;
      expect(raw.keys.toSet(), {
        'name',
        'dose',
        'scheduleType',
        'times',
        'startDate',
        'endDate',
        'active',
        'createdAt',
      });
      expect(raw['name'], 'Magnez');
      expect(raw['times'], ['08:00', '20:00']);
      expect(
        (raw['startDate'] as Timestamp).toDate(),
        DateTime(2026, 11, 21, 12),
      );

      repo.saveMed(
        'h1',
        'd1',
        med.copyWith(
          dose: null,
          endDate: null,
          scheduleType: MedScheduleType.interval,
          intervalDays: 3,
        ),
        isNew: false,
      );
      await pumpEventQueue();
      raw = (await db.doc('households/h1/dogs/d1/meds/$id').get()).data()!;
      expect(raw.containsKey('dose'), isFalse);
      expect(raw.containsKey('endDate'), isFalse);
      expect(raw['intervalDays'], 3);

      final loaded = (await repo.watchMeds('h1', 'd1').first).single;
      expect(loaded.times, const [MedTime(8, 0), MedTime(20, 0)]);
      expect(loaded.scheduleType, MedScheduleType.interval);
    },
  );

  test(
    'ticking twice keeps one dose doc; unticking marks it deleted',
    () async {
      final slot = DateTime(2026, 11, 21, 8);
      void tick(String uid, bool given) => repo.setGiven(
        'h1',
        'd1',
        medId: 'm1',
        slot: slot,
        uid: uid,
        given: given,
        now: now,
      );
      tick('u1', true);
      tick('alice', true);
      await pumpEventQueue();
      var doses = await repo
          .watchDoses('h1', 'd1', DateTime(2026, 11, 1))
          .first;
      expect(doses, hasLength(1));
      expect(doses.single.by, 'alice');

      tick('u1', false);
      await pumpEventQueue();
      doses = await repo.watchDoses('h1', 'd1', DateTime(2026, 11, 1)).first;
      expect(doses.single.deleted, isTrue);
      expect(
        (await db.doc('households/h1/dogs/d1/medDoses/m1_20261121_0800').get())
            .exists,
        isTrue,
      );
    },
  );
}
