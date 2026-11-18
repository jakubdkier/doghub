import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/features/household/data/household_repository.dart';
import 'package:dog_app/features/household/data/invite_repository.dart';
import 'package:dog_app/features/household/domain/household_exceptions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 11, 18, 12);
  late FakeFirebaseFirestore db;
  late HouseholdRepository households;
  late InviteRepository invites;

  setUp(() {
    db = FakeFirebaseFirestore();
    households = HouseholdRepository(db, clock: () => now);
    invites = InviteRepository(
      db,
      clock: () => now,
      codeGenerator: () => 'ABC234',
    );
  });

  Future<void> seedInvite(String code, {required DateTime expiresAt}) =>
      db.doc('invites/$code').set({
        'householdId': 'h1',
        'createdBy': 'alice',
        'expiresAt': Timestamp.fromDate(expiresAt),
        'createdAt': Timestamp.fromDate(now),
      });

  Future<void> seedHousehold() => db.doc('households/h1').set({
    'name': 'Dom',
    'members': ['alice'],
    'memberNames': {'alice': 'Alice'},
  });

  test('create writes a household with the creator as only member', () async {
    final id = households.create(
      name: 'Dom',
      uid: 'alice',
      memberName: 'Alice',
    );

    final household = await households.watchForMember('alice').first;
    expect(household?.id, id);
    expect(household?.members, ['alice']);
    expect(household?.memberNames, {'alice': 'Alice'});

    final raw = (await db.doc('households/$id').get()).data()!;
    expect(
      raw.keys,
      containsAll(['name', 'members', 'memberNames', 'createdAt']),
    );
    expect(raw.containsKey('inviteCode'), isFalse);
  });

  test('watchForMember emits null for a user without household', () async {
    await seedHousehold();
    expect(await households.watchForMember('bob').first, isNull);
  });

  group('join', () {
    setUp(seedHousehold);

    test('valid code adds the user and their name', () async {
      await seedInvite('ABC234', expiresAt: now.add(const Duration(hours: 1)));

      final id = await households.join(
        code: ' abc-234 ',
        uid: 'bob',
        memberName: 'Bob',
      );

      expect(id, 'h1');
      final raw = (await db.doc('households/h1').get()).data()!;
      expect(raw['members'], ['alice', 'bob']);
      expect(raw['memberNames'], {'alice': 'Alice', 'bob': 'Bob'});
      expect(raw['joinCode'], 'ABC234');
    });

    Future<JoinFailure> failureOf(String code) async {
      try {
        await households.join(code: code, uid: 'bob', memberName: 'Bob');
      } on JoinHouseholdException catch (e) {
        return e.reason;
      }
      fail('expected JoinHouseholdException');
    }

    test('malformed code', () async {
      expect(await failureOf('12'), JoinFailure.invalidCode);
    });

    test('unknown code', () async {
      expect(await failureOf('ZZZ999'), JoinFailure.notFound);
    });

    test('expired code', () async {
      await seedInvite(
        'EXP234',
        expiresAt: now.subtract(const Duration(minutes: 1)),
      );
      expect(await failureOf('EXP234'), JoinFailure.expired);
      final raw = (await db.doc('households/h1').get()).data()!;
      expect(raw['members'], ['alice']);
    });
  });

  group('invites', () {
    setUp(seedHousehold);

    test('create stores a 24h invite and the active code', () async {
      final invite = await invites.create(householdId: 'h1', uid: 'alice');

      expect(invite.code, 'ABC234');
      expect(invite.expiresAt, now.add(const Duration(hours: 24)));
      final raw = (await db.doc('invites/ABC234').get()).data()!;
      expect(raw['householdId'], 'h1');
      expect(raw['createdBy'], 'alice');
      expect(
        (await db.doc('households/h1').get()).data()!['inviteCode'],
        'ABC234',
      );
      expect((await invites.watch('ABC234').first)?.householdId, 'h1');
    });

    test('create skips codes that are already taken', () async {
      await seedInvite('ABC234', expiresAt: now);
      final codes = ['ABC234', 'XYZ789'].iterator;
      final repo = InviteRepository(
        db,
        clock: () => now,
        codeGenerator: () => (codes..moveNext()).current,
      );

      expect(
        (await repo.create(householdId: 'h1', uid: 'alice')).code,
        'XYZ789',
      );
    });

    test('revoke deletes the invite and clears the active code', () async {
      await invites.create(householdId: 'h1', uid: 'alice');

      invites.revoke(householdId: 'h1', code: 'ABC234');
      await pumpEventQueue();

      expect((await db.doc('invites/ABC234').get()).exists, isFalse);
      expect(
        (await db.doc('households/h1').get()).data()!.containsKey('inviteCode'),
        isFalse,
      );
    });
  });
}
