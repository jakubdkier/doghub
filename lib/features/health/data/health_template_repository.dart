import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/firebase/firestore_paths.dart';
import '../../../core/utils/fire_and_forget.dart';
import '../domain/health_entry.dart';
import '../domain/health_template.dart';

/// Household health templates: overrides of the built-ins and custom ones.
class HealthTemplateRepository {
  HealthTemplateRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _col(String householdId) =>
      _db.collection(FirestorePaths.healthTemplates(householdId));

  /// Stored templates only; merge with defaults via [mergeTemplates].
  Stream<List<HealthTemplate>> watchStored(String householdId) =>
      _col(householdId).snapshots().map(
        (s) => [for (final d in s.docs) templateFromFirestore(d.id, d.data())],
      );

  /// New custom template id (written on [save]).
  String newId(String householdId) => _col(householdId).doc().id;

  /// Creates or overrides by id (merge, so both partners can write).
  void save(String householdId, HealthTemplate t) => fireAndForget(
    _col(householdId).doc(t.id).set({
      'name': t.name.trim(),
      'type': t.type.name,
      'intervalMonths': t.intervalMonths ?? FieldValue.delete(),
      'mandatory': t.mandatory,
      'active': t.active,
    }, SetOptions(merge: true)),
    'save health template',
  );
}

HealthTemplate templateFromFirestore(String id, Map<String, dynamic> data) =>
    HealthTemplate(
      id: id,
      name: data['name'] as String? ?? '',
      type: HealthType.values.asNameMap()[data['type']] ?? HealthType.vet,
      intervalMonths: (data['intervalMonths'] as num?)?.toInt(),
      mandatory: data['mandatory'] as bool? ?? false,
      active: data['active'] as bool? ?? true,
    );
