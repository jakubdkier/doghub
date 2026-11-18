import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/converters.dart';
import '../../../core/firebase/firestore_paths.dart';
import '../../../core/utils/fire_and_forget.dart';
import '../../weight/data/weight_converter.dart';
import '../../weight/domain/weight_entry.dart';
import '../domain/dog.dart';

class DogRepository {
  DogRepository(this._db, {DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  final FirebaseFirestore _db;
  final DateTime Function() _now;

  CollectionReference<Dog> _dogs(String householdId) => _db
      .collection(FirestorePaths.dogs(householdId))
      .withConverter(
        fromFirestore: (snap, _) => dogFromFirestore(snap),
        toFirestore: (dog, _) => dogToFirestoreCreate(dog),
      );

  /// All dogs of the household, oldest first.
  Stream<List<Dog>> watchAll(String householdId) => _dogs(householdId)
      .snapshots(includeMetadataChanges: true)
      .skipUnconfirmedEmpty()
      .map((s) => s.docs.map((d) => d.data()).toList()..sort(Dog.byCreation));

  /// Adds a dog and, optionally, its starting weight. Works offline.
  String add({
    required String householdId,
    required String uid,
    required String name,
    String? breed,
    DateTime? birthDate,
    double? startWeightKg,
  }) {
    final dogRef = _dogs(householdId).doc();
    final batch = _db.batch()
      ..set(
        dogRef,
        Dog(id: dogRef.id, name: name, breed: breed, birthDate: birthDate),
      );
    if (startWeightKg != null) {
      batch.set(
        weightsRef(_db, householdId, dogRef.id).doc(),
        WeightEntry(kg: startWeightKg, at: _now(), by: uid),
      );
    }
    fireAndForget(batch.commit(), 'add dog');
    return dogRef.id;
  }
}

Dog dogFromFirestore(DocumentSnapshot<Map<String, dynamic>> snap) {
  final data = snap.data()!;
  return Dog(
    id: snap.id,
    name: data['name'] as String? ?? '',
    breed: data['breed'] as String?,
    birthDate: dateFromFirestore(data['birthDate']),
    createdAt: dateFromFirestore(data['createdAt']),
  );
}

/// Only used for creation; must match the dog rule in firestore.rules.
Map<String, Object?> dogToFirestoreCreate(Dog dog) => {
  'name': dog.name,
  if (dog.breed != null && dog.breed!.isNotEmpty) 'breed': dog.breed,
  if (dog.birthDate != null) 'birthDate': dateToFirestore(dog.birthDate),
  'createdAt': FieldValue.serverTimestamp(),
};
