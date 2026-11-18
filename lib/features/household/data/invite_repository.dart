import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/firestore_paths.dart';
import '../../../core/utils/fire_and_forget.dart';
import '../domain/household_exceptions.dart';
import '../domain/invite.dart';
import 'invite_converter.dart';

class InviteRepository {
  InviteRepository(
    this._db, {
    DateTime Function()? clock,
    String Function()? codeGenerator,
  }) : _now = clock ?? DateTime.now,
       _generate = codeGenerator ?? InviteCode.generate;

  final FirebaseFirestore _db;
  final DateTime Function() _now;
  final String Function() _generate;

  static const _serverTimeout = Duration(seconds: 15);
  static const _maxAttempts = 5;

  Stream<Invite?> watch(String code) =>
      inviteRef(_db, code).snapshots().map((s) => s.data());

  /// Creates a 24h invite and stores it as the household's active code.
  /// Needs a connection to make sure the code is not taken.
  Future<Invite> create({
    required String householdId,
    required String uid,
  }) async {
    for (var attempt = 0; attempt < _maxAttempts; attempt++) {
      final code = _generate();
      final ref = inviteRef(_db, code);
      final DocumentSnapshot<Invite> existing;
      try {
        existing = await ref
            .get(const GetOptions(source: Source.server))
            .timeout(_serverTimeout);
      } on TimeoutException {
        throw const InviteOfflineException();
      } on FirebaseException catch (e) {
        if (e.code == 'unavailable') throw const InviteOfflineException();
        rethrow;
      }
      if (existing.exists) continue;

      final invite = Invite(
        code: code,
        householdId: householdId,
        createdBy: uid,
        expiresAt: _now().add(Invite.validity),
      );
      final batch = _db.batch()
        ..set(ref, invite)
        ..update(_db.doc(FirestorePaths.household(householdId)), {
          'inviteCode': code,
        });
      await batch.commit().timeout(_serverTimeout);
      return invite;
    }
    throw StateError('Could not find a free invite code');
  }

  /// Deletes the invite and clears it from the household. Works offline.
  void revoke({required String householdId, required String code}) {
    final batch = _db.batch()
      ..delete(_db.doc(FirestorePaths.invite(code)))
      ..update(_db.doc(FirestorePaths.household(householdId)), {
        'inviteCode': FieldValue.delete(),
      });
    fireAndForget(batch.commit(), 'revoke invite');
  }
}
