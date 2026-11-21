import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/converters.dart';
import '../../../core/firebase/firestore_paths.dart';
import '../domain/weight_entry.dart';

CollectionReference<WeightEntry> weightsRef(
  FirebaseFirestore db,
  String householdId,
  String dogId,
) => db
    .collection(FirestorePaths.weights(householdId, dogId))
    .withConverter(
      fromFirestore: (snap, _) => weightFromFirestore(snap),
      toFirestore: (w, _) => weightToFirestoreCreate(w),
    );

WeightEntry weightFromFirestore(DocumentSnapshot<Map<String, dynamic>> snap) {
  final data = snap.data()!;
  return WeightEntry(
    id: snap.id,
    kg: (data['kg'] as num).toDouble(),
    at: dateFromFirestore(data['at']) ?? DateTime.now(),
    by: data['by'] as String? ?? '',
    createdAt: dateFromFirestore(data['createdAt']),
    deleted: data['deleted'] as bool? ?? false,
  );
}

/// Must match `validWeight()` in firestore.rules.
Map<String, Object?> weightToFirestoreCreate(WeightEntry w) => {
  'kg': w.kg,
  'at': dateToFirestore(weighDay(w.at)),
  'by': w.by,
  'createdAt': FieldValue.serverTimestamp(),
  'deleted': false,
};
