import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/converters.dart';
import '../../../core/firebase/firestore_paths.dart';
import '../../../core/utils/fire_and_forget.dart';
import '../domain/dog_event.dart';
import '../domain/event_query.dart';

/// Events of one dog. All writes work offline (fire-and-forget).
class EventRepository {
  EventRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<DogEvent> _events(String householdId, String dogId) => _db
      .collection(FirestorePaths.events(householdId, dogId))
      .withConverter(
        fromFirestore: (snap, _) => eventFromFirestore(snap),
        toFirestore: (e, _) => eventToFirestoreCreate(e),
      );

  /// Non-deleted events since [since], newest first.
  Stream<List<DogEvent>> watchSince(
    String householdId,
    String dogId,
    DateTime since,
  ) => _events(householdId, dogId)
      .where('at', isGreaterThanOrEqualTo: Timestamp.fromDate(since))
      .orderBy('at', descending: true)
      .snapshots()
      .map(
        (s) => [
          for (final d in s.docs)
            if (!d.data().deleted) d.data(),
        ],
      );

  /// History page: newest first, optionally filtered by type. Deleted
  /// entries are dropped after the limit is applied, so [EventPage.hasMore]
  /// reflects the raw query.
  Stream<EventPage> watchHistory(
    String householdId,
    String dogId,
    EventQuery query,
  ) {
    Query<DogEvent> q = _events(householdId, dogId);
    final types = query.types;
    if (types.isNotEmpty && types.length < EventType.values.length) {
      q = q.where('type', whereIn: [for (final t in types) t.name]);
    }
    return q
        .orderBy('at', descending: true)
        .limit(query.limit)
        .snapshots()
        .map(
          (s) => EventPage(
            events: [
              for (final d in s.docs)
                if (!d.data().deleted) d.data(),
            ],
            hasMore: s.docs.length >= query.limit,
          ),
        );
  }

  Stream<DogEvent?> watchOne(String householdId, String dogId, String id) =>
      _events(
        householdId,
        dogId,
      ).doc(id).snapshots().map((s) => s.exists ? s.data() : null);

  /// Creates [event] (its id is ignored) and returns the new id.
  String add(String householdId, String dogId, DogEvent event) {
    assert(event.isValid, 'Invalid event: $event');
    final ref = _events(householdId, dogId).doc();
    fireAndForget(ref.set(event.copyWith(id: ref.id)), 'add event');
    return ref.id;
  }

  /// Saves editable fields; `type`, `by` and `createdAt` stay untouched.
  void update(String householdId, String dogId, DogEvent event) {
    assert(event.isValid, 'Invalid event: $event');
    fireAndForget(
      _rawDoc(
        householdId,
        dogId,
        event.id!,
      ).update(eventToFirestoreUpdate(event)),
      'update event',
    );
  }

  void setDeleted(
    String householdId,
    String dogId,
    String id, {
    required bool deleted,
  }) => fireAndForget(
    _rawDoc(householdId, dogId, id).update({'deleted': deleted}),
    deleted ? 'delete event' : 'restore event',
  );

  DocumentReference<Map<String, dynamic>> _rawDoc(
    String householdId,
    String dogId,
    String id,
  ) => _db.doc('${FirestorePaths.events(householdId, dogId)}/$id');
}

DogEvent eventFromFirestore(DocumentSnapshot<Map<String, dynamic>> snap) {
  final data = snap.data()!;
  return DogEvent(
    id: snap.id,
    type: EventType.values.asNameMap()[data['type']] ?? EventType.note,
    at: dateFromFirestore(data['at']) ?? DateTime.now(),
    by: data['by'] as String? ?? '',
    createdAt: dateFromFirestore(data['createdAt']),
    foodId: data['foodId'] as String?,
    grams: (data['grams'] as num?)?.round(),
    poopScore: (data['poopScore'] as num?)?.toInt(),
    poopColor: PoopColor.values.asNameMap()[data['poopColor']],
    durationMin: (data['durationMin'] as num?)?.toInt(),
    note: data['note'] as String?,
    deleted: data['deleted'] as bool? ?? false,
  );
}

/// Values the user can change; nulls are written as deletions on update.
Map<String, Object?> _editableFields(DogEvent e) => {
  'at': dateToFirestore(e.at),
  'foodId': e.foodId,
  'grams': e.grams,
  'poopScore': e.poopScore,
  'poopColor': e.poopColor?.name,
  'durationMin': e.durationMin,
  'note': (e.note == null || e.note!.trim().isEmpty) ? null : e.note!.trim(),
};

/// Must match `validEvent()` in firestore.rules.
Map<String, Object?> eventToFirestoreCreate(DogEvent e) => {
  'type': e.type.name,
  'by': e.by,
  'createdAt': FieldValue.serverTimestamp(),
  'deleted': false,
  for (final MapEntry(:key, :value) in _editableFields(e).entries) key: ?value,
};

Map<String, Object?> eventToFirestoreUpdate(DogEvent e) => {
  for (final MapEntry(:key, :value) in _editableFields(e).entries)
    key: value ?? FieldValue.delete(),
};
