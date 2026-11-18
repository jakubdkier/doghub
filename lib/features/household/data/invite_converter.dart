import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/converters.dart';
import '../../../core/firebase/firestore_paths.dart';
import '../domain/invite.dart';

DocumentReference<Invite> inviteRef(FirebaseFirestore db, String code) => db
    .doc(FirestorePaths.invite(code))
    .withConverter(
      fromFirestore: (snap, _) {
        final data = snap.data()!;
        return Invite(
          code: snap.id,
          householdId: data['householdId'] as String,
          createdBy: data['createdBy'] as String,
          expiresAt: dateFromFirestore(data['expiresAt'])!,
        );
      },
      toFirestore: (invite, _) => {
        'householdId': invite.householdId,
        'createdBy': invite.createdBy,
        'expiresAt': dateToFirestore(invite.expiresAt),
        'createdAt': FieldValue.serverTimestamp(),
      },
    );
