import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/converters.dart';
import '../../../core/firebase/firestore_paths.dart';
import '../../../core/utils/fire_and_forget.dart';
import '../domain/weight_entry.dart';
import 'weight_converter.dart';

/// Weight measurements of one dog. Writes work offline.
class WeightRepository {
  WeightRepository(this._db);

  final FirebaseFirestore _db;

  /// Non-deleted measurements, newest first.
  Stream<List<WeightEntry>> watchAll(String householdId, String dogId) =>
      weightsRef(_db, householdId, dogId).snapshots().map(
        (s) => [
          for (final d in s.docs)
            if (!d.data().deleted) d.data(),
        ]..sort(WeightEntry.newestFirst),
      );

  String add(String householdId, String dogId, WeightEntry entry) {
    final ref = weightsRef(_db, householdId, dogId).doc();
    fireAndForget(ref.set(entry.copyWith(id: ref.id)), 'add weight');
    return ref.id;
  }

  /// Changes kg and day; author and creation time stay.
  void update(String householdId, String dogId, WeightEntry entry) =>
      fireAndForget(
        _doc(
          householdId,
          dogId,
          entry.id!,
        ).update({'kg': entry.kg, 'at': dateToFirestore(weighDay(entry.at))}),
        'update weight',
      );

  void setDeleted(
    String householdId,
    String dogId,
    String id, {
    required bool deleted,
  }) => fireAndForget(
    _doc(householdId, dogId, id).update({'deleted': deleted}),
    deleted ? 'delete weight' : 'restore weight',
  );

  DocumentReference<Map<String, dynamic>> _doc(
    String householdId,
    String dogId,
    String id,
  ) => _db.doc('${FirestorePaths.weights(householdId, dogId)}/$id');
}
