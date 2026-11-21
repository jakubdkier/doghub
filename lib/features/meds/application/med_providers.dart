import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/firebase_providers.dart';
import '../../../core/utils/clock.dart';
import '../../dogs/application/dog_providers.dart';
import '../../events/domain/event_timeline.dart';
import '../../household/application/household_providers.dart';
import '../data/med_repository.dart';
import '../domain/med.dart';
import '../domain/med_dose.dart';

part 'med_providers.g.dart';

/// How far back check-offs are loaded (history shows 30 days).
const doseHistoryDays = 31;

@Riverpod(keepAlive: true)
MedRepository medRepository(Ref ref) =>
    MedRepository(ref.watch(firestoreProvider));

@Riverpod(keepAlive: true)
Stream<List<Med>> meds(Ref ref) {
  final scope = ref.watch(dogScopeProvider);
  if (scope == null) return Stream.value(const []);
  return ref
      .watch(medRepositoryProvider)
      .watchMeds(scope.householdId, scope.dogId);
}

@Riverpod(keepAlive: true)
Stream<List<MedDose>> medDoses(Ref ref) {
  final scope = ref.watch(dogScopeProvider);
  if (scope == null) return Stream.value(const []);
  final today = startOfDay(ref.read(clockProvider)());
  return ref
      .watch(medRepositoryProvider)
      .watchDoses(
        scope.householdId,
        scope.dogId,
        DateTime(today.year, today.month, today.day - doseHistoryDays),
      );
}

@Riverpod(keepAlive: true)
class MedController extends _$MedController {
  @override
  void build() {}

  DogScope get _scope {
    final scope = ref.read(dogScopeProvider);
    if (scope == null) throw StateError('No household or dog');
    return scope;
  }

  MedRepository get _repo => ref.read(medRepositoryProvider);

  /// Saves [med]; an empty id creates a new one. Returns the id.
  String save(Med med) {
    final scope = _scope;
    final isNew = med.id.isEmpty;
    final saved = isNew
        ? med.copyWith(id: _repo.newMedId(scope.householdId, scope.dogId))
        : med;
    _repo.saveMed(scope.householdId, scope.dogId, saved, isNew: isNew);
    return saved.id;
  }

  void setGiven(String medId, DateTime slot, {required bool given}) {
    final user = ref.read(currentUserProvider);
    if (user == null) throw StateError('Not signed in');
    final scope = _scope;
    _repo.setGiven(
      scope.householdId,
      scope.dogId,
      medId: medId,
      slot: slot,
      uid: user.uid,
      given: given,
      now: ref.read(clockProvider)(),
    );
  }
}
