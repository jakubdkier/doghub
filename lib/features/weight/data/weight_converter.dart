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
      fromFirestore: (snap, _) {
        final data = snap.data()!;
        return WeightEntry(
          id: snap.id,
          kg: (data['kg'] as num).toDouble(),
          at: dateFromFirestore(data['at']) ?? DateTime.now(),
          by: data['by'] as String,
        );
      },
      toFirestore: (w, _) => {
        'kg': w.kg,
        'at': dateToFirestore(w.at),
        'by': w.by,
      },
    );
