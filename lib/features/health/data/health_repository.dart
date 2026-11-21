import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/converters.dart';
import '../../../core/firebase/firestore_paths.dart';
import '../../../core/utils/dates.dart';
import '../../../core/utils/fire_and_forget.dart';
import '../domain/health_entry.dart';

/// Health entries of one dog. Writes work offline.
class HealthRepository {
  HealthRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<HealthEntry> _entries(String householdId, String dogId) =>
      _db
          .collection(FirestorePaths.health(householdId, dogId))
          .withConverter(
            fromFirestore: (snap, _) => healthFromFirestore(snap),
            toFirestore: (e, _) => healthToFirestoreCreate(e),
          );

  /// Non-deleted entries, newest first.
  Stream<List<HealthEntry>> watchAll(String householdId, String dogId) =>
      _entries(householdId, dogId).snapshots().map(
        (s) => [
          for (final d in s.docs)
            if (!d.data().deleted) d.data(),
        ]..sort(HealthEntry.newestFirst),
      );

  String add(String householdId, String dogId, HealthEntry entry) {
    final ref = _entries(householdId, dogId).doc();
    fireAndForget(ref.set(entry.copyWith(id: ref.id)), 'add health entry');
    return ref.id;
  }

  /// Saves editable fields; type, template, author and createdAt stay.
  void update(String householdId, String dogId, HealthEntry entry) {
    final note = entry.note?.trim();
    fireAndForget(
      _doc(householdId, dogId, entry.id!).update({
        'name': entry.name.trim(),
        'date': dateToFirestore(noonOf(entry.date)),
        'nextDue': entry.nextDue == null
            ? FieldValue.delete()
            : dateToFirestore(dueNoonOf(entry.nextDue!)),
        'note': (note == null || note.isEmpty) ? FieldValue.delete() : note,
      }),
      'update health entry',
    );
  }

  void setDeleted(
    String householdId,
    String dogId,
    String id, {
    required bool deleted,
  }) => fireAndForget(
    _doc(householdId, dogId, id).update({'deleted': deleted}),
    deleted ? 'delete health entry' : 'restore health entry',
  );

  DocumentReference<Map<String, dynamic>> _doc(
    String householdId,
    String dogId,
    String id,
  ) => _db.doc('${FirestorePaths.health(householdId, dogId)}/$id');
}

HealthEntry healthFromFirestore(DocumentSnapshot<Map<String, dynamic>> snap) {
  final data = snap.data()!;
  return HealthEntry(
    id: snap.id,
    type: HealthType.values.asNameMap()[data['type']] ?? HealthType.vet,
    templateId: data['templateId'] as String?,
    name: data['name'] as String? ?? '',
    date: dateFromFirestore(data['date']) ?? DateTime.now(),
    nextDue: dateFromFirestore(data['nextDue']),
    note: data['note'] as String?,
    by: data['by'] as String? ?? '',
    createdAt: dateFromFirestore(data['createdAt']),
    deleted: data['deleted'] as bool? ?? false,
  );
}

/// Must match `validHealth()` in firestore.rules.
Map<String, Object?> healthToFirestoreCreate(HealthEntry e) {
  final note = e.note?.trim();
  return {
    'type': e.type.name,
    'templateId': ?e.templateId,
    'name': e.name.trim(),
    'date': dateToFirestore(noonOf(e.date)),
    'nextDue': ?(e.nextDue == null
        ? null
        : dateToFirestore(dueNoonOf(e.nextDue!))),
    'note': ?((note == null || note.isEmpty) ? null : note),
    'by': e.by,
    'createdAt': FieldValue.serverTimestamp(),
    'deleted': false,
  };
}
