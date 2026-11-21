import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/converters.dart';
import '../../../core/firebase/firestore_paths.dart';
import '../../../core/utils/fire_and_forget.dart';
import '../domain/food.dart';

/// Foods of one dog. Writes work offline (fire-and-forget).
class FoodRepository {
  FoodRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Food> _foods(String householdId, String dogId) => _db
      .collection(FirestorePaths.foods(householdId, dogId))
      .withConverter(
        fromFirestore: (snap, _) => foodFromFirestore(snap),
        toFirestore: (food, _) => foodToFirestoreCreate(food),
      );

  /// All foods (active and archived), sorted by label.
  Stream<List<Food>> watchAll(String householdId, String dogId) =>
      _foods(householdId, dogId).snapshots().map(
        (s) => s.docs.map((d) => d.data()).toList()..sort(Food.byLabel),
      );

  String add(
    String householdId,
    String dogId, {
    required String name,
    String? brand,
  }) {
    final ref = _foods(householdId, dogId).doc();
    fireAndForget(
      ref.set(Food(id: ref.id, name: name, brand: brand)),
      'add food',
    );
    return ref.id;
  }

  void update(String householdId, String dogId, Food food) => fireAndForget(
    _db.doc('${FirestorePaths.foods(householdId, dogId)}/${food.id}').update({
      'name': food.name,
      'brand': _blankToNull(food.brand) ?? FieldValue.delete(),
      'rating': food.rating?.name ?? FieldValue.delete(),
      'active': food.active,
    }),
    'update food',
  );
}

String? _blankToNull(String? s) =>
    (s == null || s.trim().isEmpty) ? null : s.trim();

Food foodFromFirestore(DocumentSnapshot<Map<String, dynamic>> snap) {
  final data = snap.data()!;
  return Food(
    id: snap.id,
    name: data['name'] as String? ?? '',
    brand: data['brand'] as String?,
    rating: FoodRating.values.asNameMap()[data['rating']],
    active: data['active'] as bool? ?? true,
    createdAt: dateFromFirestore(data['createdAt']),
  );
}

/// Must match `validFood()` in firestore.rules.
Map<String, Object?> foodToFirestoreCreate(Food food) => {
  'name': food.name.trim(),
  'brand': ?_blankToNull(food.brand),
  'rating': ?food.rating?.name,
  'active': food.active,
  'createdAt': FieldValue.serverTimestamp(),
};
