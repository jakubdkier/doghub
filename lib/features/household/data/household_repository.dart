import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/converters.dart';
import '../../../core/firebase/firestore_paths.dart';
import '../../../core/utils/fire_and_forget.dart';
import '../domain/household.dart';
import '../domain/household_exceptions.dart';
import '../domain/invite.dart';
import 'invite_converter.dart';

class HouseholdRepository {
  HouseholdRepository(this._db, {DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  final FirebaseFirestore _db;
  final DateTime Function() _now;

  static const _serverTimeout = Duration(seconds: 15);

  CollectionReference<Household> get _households => _db
      .collection(FirestorePaths.households)
      .withConverter(
        fromFirestore: (snap, _) => householdFromFirestore(snap),
        toFirestore: (h, _) => householdToFirestoreCreate(h),
      );

  /// The (single) household the user belongs to, or null.
  Stream<Household?> watchForMember(String uid) => _households
      .where('members', arrayContains: uid)
      .limit(1)
      .snapshots(includeMetadataChanges: true)
      .skipUnconfirmedEmpty()
      .map((s) => s.docs.isEmpty ? null : s.docs.first.data())
      .distinct();

  /// Creates a household with the user as its only member. Works offline.
  String create({
    required String name,
    required String uid,
    required String memberName,
  }) {
    final ref = _households.doc();
    fireAndForget(
      ref.set(
        Household(
          id: ref.id,
          name: name,
          members: [uid],
          memberNames: {uid: memberName},
        ),
      ),
      'create household',
    );
    return ref.id;
  }

  /// Adds the user to the household of a valid invite. Needs a connection.
  Future<String> join({
    required String code,
    required String uid,
    required String memberName,
  }) async {
    final normalized = InviteCode.normalize(code);
    if (!InviteCode.isValid(normalized)) {
      throw const JoinHouseholdException(JoinFailure.invalidCode);
    }

    final Invite? invite;
    try {
      final snap = await inviteRef(
        _db,
        normalized,
      ).get(const GetOptions(source: Source.server)).timeout(_serverTimeout);
      invite = snap.data();
    } on TimeoutException {
      throw const JoinHouseholdException(JoinFailure.offline);
    } on FirebaseException catch (e) {
      throw JoinHouseholdException(_failureFor(e));
    }
    if (invite == null) {
      throw const JoinHouseholdException(JoinFailure.notFound);
    }
    if (!invite.isValidAt(_now())) {
      throw const JoinHouseholdException(JoinFailure.expired);
    }

    try {
      await _db
          .doc(FirestorePaths.household(invite.householdId))
          .update({
            'members': FieldValue.arrayUnion([uid]),
            'memberNames.$uid': memberName,
            'joinCode': normalized,
          })
          .timeout(_serverTimeout);
    } on TimeoutException {
      throw const JoinHouseholdException(JoinFailure.offline);
    } on FirebaseException catch (e) {
      throw JoinHouseholdException(_failureFor(e));
    }
    return invite.householdId;
  }

  static JoinFailure _failureFor(FirebaseException e) => switch (e.code) {
    'unavailable' => JoinFailure.offline,
    'not-found' => JoinFailure.notFound,
    _ => JoinFailure.denied,
  };
}

Household householdFromFirestore(DocumentSnapshot<Map<String, dynamic>> snap) {
  final data = snap.data()!;
  return Household(
    id: snap.id,
    name: data['name'] as String? ?? '',
    members: List<String>.from(data['members'] as List? ?? const []),
    memberNames: Map<String, String>.from(
      data['memberNames'] as Map? ?? const {},
    ),
    inviteCode: data['inviteCode'] as String?,
  );
}

/// Only used for creation; must match the create rule in firestore.rules.
Map<String, Object?> householdToFirestoreCreate(Household h) => {
  'name': h.name,
  'members': h.members,
  'memberNames': h.memberNames,
  'createdAt': FieldValue.serverTimestamp(),
};
