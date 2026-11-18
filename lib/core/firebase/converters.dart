import 'package:cloud_firestore/cloud_firestore.dart';

/// Timestamp (or pending server timestamp = null) to DateTime.
DateTime? dateFromFirestore(Object? value) => switch (value) {
  Timestamp t => t.toDate(),
  DateTime d => d,
  _ => null,
};

Timestamp? dateToFirestore(DateTime? value) =>
    value == null ? null : Timestamp.fromDate(value);

extension QuerySnapshotX<T> on Stream<QuerySnapshot<T>> {
  /// Drops empty results that come only from the local cache, so a fresh
  /// install doesn't briefly look like "no household / no dog" before the
  /// server answers. Requires `includeMetadataChanges: true`.
  Stream<QuerySnapshot<T>> skipUnconfirmedEmpty() =>
      where((s) => s.docs.isNotEmpty || !s.metadata.isFromCache);
}
