import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/converters.dart';
import '../../../core/firebase/firestore_paths.dart';
import '../../../core/utils/dates.dart';
import '../../../core/utils/fire_and_forget.dart';
import '../domain/med.dart';
import '../domain/med_dose.dart';

/// Meds and dose check-offs of one dog. Writes work offline.
class MedRepository {
  MedRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _meds(String h, String d) =>
      _db.collection(FirestorePaths.meds(h, d));

  CollectionReference<Map<String, dynamic>> _doses(String h, String d) =>
      _db.collection(FirestorePaths.medDoses(h, d));

  /// All meds (active and ended), by name.
  Stream<List<Med>> watchMeds(String h, String d) =>
      _meds(h, d).snapshots().map(
        (s) => [
          for (final doc in s.docs) medFromFirestore(doc.id, doc.data()),
        ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())),
      );

  /// Check-offs (incl. unticked) for slots since [since].
  Stream<List<MedDose>> watchDoses(String h, String d, DateTime since) =>
      _doses(h, d)
          .where('slot', isGreaterThanOrEqualTo: Timestamp.fromDate(since))
          .snapshots()
          .map(
            (s) => [for (final doc in s.docs) doseFromFirestore(doc.data())],
          );

  String newMedId(String h, String d) => _meds(h, d).doc().id;

  /// Creates [med] (when [isNew]) or saves its fields.
  void saveMed(String h, String d, Med med, {required bool isNew}) {
    final ref = _meds(h, d).doc(med.id);
    final data = medToFirestore(med);
    fireAndForget(
      isNew
          ? ref.set({...data, 'createdAt': FieldValue.serverTimestamp()})
          : ref.update({
              ...data,
              for (final k in ['dose', 'intervalDays', 'endDate', 'note'])
                if (!data.containsKey(k)) k: FieldValue.delete(),
            }),
      isNew ? 'add med' : 'update med',
    );
  }

  /// Ticks ([given]) or unticks a dose by [uid].
  void setGiven(
    String h,
    String d, {
    required String medId,
    required DateTime slot,
    required String uid,
    required bool given,
    required DateTime now,
  }) {
    final dose = MedDose(
      medId: medId,
      slot: slot,
      givenAt: now,
      by: uid,
      deleted: !given,
    );
    fireAndForget(
      _doses(h, d).doc(dose.id).set(doseToFirestore(dose)),
      given ? 'tick dose' : 'untick dose',
    );
  }
}

Med medFromFirestore(String id, Map<String, dynamic> data) => Med(
  id: id,
  name: data['name'] as String? ?? '',
  dose: data['dose'] as String?,
  scheduleType:
      MedScheduleType.values.asNameMap()[data['scheduleType']] ??
      MedScheduleType.daily,
  times: [
    for (final t in (data['times'] as List?) ?? const []) ?MedTime.parse('$t'),
  ],
  intervalDays: (data['intervalDays'] as num?)?.toInt(),
  startDate: dateFromFirestore(data['startDate']) ?? DateTime.now(),
  endDate: dateFromFirestore(data['endDate']),
  active: data['active'] as bool? ?? true,
  note: data['note'] as String?,
  createdAt: dateFromFirestore(data['createdAt']),
);

/// Must match `validMed()` in firestore.rules (without createdAt).
Map<String, Object> medToFirestore(Med m) {
  final dose = m.dose?.trim();
  final note = m.note?.trim();
  return {
    'name': m.name.trim(),
    if (dose != null && dose.isNotEmpty) 'dose': dose,
    'scheduleType': m.scheduleType.name,
    'times': [for (final t in m.sortedTimes) t.label],
    if (m.scheduleType == MedScheduleType.interval)
      'intervalDays': m.intervalDays ?? MedLimits.minIntervalDays,
    'startDate': dateToFirestore(dueNoonOf(m.startDate))!,
    if (m.endDate != null) 'endDate': dateToFirestore(dueNoonOf(m.endDate!))!,
    'active': m.active,
    if (note != null && note.isNotEmpty) 'note': note,
  };
}

MedDose doseFromFirestore(Map<String, dynamic> data) => MedDose(
  medId: data['medId'] as String? ?? '',
  slot: dateFromFirestore(data['slot']) ?? DateTime(2000),
  givenAt: dateFromFirestore(data['givenAt']) ?? DateTime(2000),
  by: data['by'] as String? ?? '',
  deleted: data['deleted'] as bool? ?? false,
);

/// Must match `validDose()` in firestore.rules.
Map<String, Object?> doseToFirestore(MedDose d) => {
  'medId': d.medId,
  'slot': dateToFirestore(d.slot),
  'givenAt': dateToFirestore(d.givenAt),
  'by': d.by,
  'deleted': d.deleted,
};
