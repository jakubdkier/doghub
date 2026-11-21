import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/converters.dart';
import '../../../core/firebase/firestore_paths.dart';
import '../../../core/utils/fire_and_forget.dart';
import '../domain/purchase.dart';

/// Food purchases of one dog. Writes work offline (fire-and-forget).
class PurchaseRepository {
  PurchaseRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Purchase> _purchases(String householdId, String dogId) =>
      _db
          .collection(FirestorePaths.purchases(householdId, dogId))
          .withConverter(
            fromFirestore: (snap, _) => purchaseFromFirestore(snap),
            toFirestore: (p, _) => purchaseToFirestoreCreate(p),
          );

  /// Non-deleted purchases of all foods, newest first.
  Stream<List<Purchase>> watchAll(String householdId, String dogId) =>
      _purchases(householdId, dogId).snapshots().map(
        (s) => [
          for (final d in s.docs)
            if (!d.data().deleted) d.data(),
        ]..sort(Purchase.newestFirst),
      );

  String add(String householdId, String dogId, Purchase purchase) {
    final ref = _purchases(householdId, dogId).doc();
    fireAndForget(ref.set(purchase.copyWith(id: ref.id)), 'add purchase');
    return ref.id;
  }

  void setDeleted(
    String householdId,
    String dogId,
    String id, {
    required bool deleted,
  }) => fireAndForget(
    _db.doc('${FirestorePaths.purchases(householdId, dogId)}/$id').update({
      'deleted': deleted,
    }),
    deleted ? 'delete purchase' : 'restore purchase',
  );
}

Purchase purchaseFromFirestore(DocumentSnapshot<Map<String, dynamic>> snap) {
  final data = snap.data()!;
  return Purchase(
    id: snap.id,
    foodId: data['foodId'] as String? ?? '',
    kg: (data['kg'] as num?)?.toDouble() ?? 0,
    price: (data['price'] as num?)?.toDouble(),
    at: dateFromFirestore(data['at']) ?? DateTime.now(),
    by: data['by'] as String? ?? '',
    createdAt: dateFromFirestore(data['createdAt']),
    deleted: data['deleted'] as bool? ?? false,
  );
}

/// Must match `validPurchase()` in firestore.rules.
Map<String, Object?> purchaseToFirestoreCreate(Purchase p) => {
  'foodId': p.foodId,
  'kg': p.kg,
  'price': ?p.price,
  'at': dateToFirestore(p.at),
  'by': p.by,
  'createdAt': FieldValue.serverTimestamp(),
  'deleted': false,
};
