import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/firebase_providers.dart';
import '../../dogs/application/dog_providers.dart';
import '../../household/application/household_providers.dart';
import '../data/weight_repository.dart';
import '../domain/weight_entry.dart';

part 'weight_providers.g.dart';

@Riverpod(keepAlive: true)
WeightRepository weightRepository(Ref ref) =>
    WeightRepository(ref.watch(firestoreProvider));

/// Non-deleted measurements of the current dog, newest first.
@Riverpod(keepAlive: true)
Stream<List<WeightEntry>> weights(Ref ref) {
  final scope = ref.watch(dogScopeProvider);
  if (scope == null) return Stream.value(const []);
  return ref
      .watch(weightRepositoryProvider)
      .watchAll(scope.householdId, scope.dogId);
}

@Riverpod(keepAlive: true)
class WeightController extends _$WeightController {
  @override
  void build() {}

  DogScope get _scope {
    final scope = ref.read(dogScopeProvider);
    if (scope == null) throw StateError('No household or dog');
    return scope;
  }

  String add({required double kg, required DateTime day}) {
    final user = ref.read(currentUserProvider);
    if (user == null) throw StateError('Not signed in');
    final scope = _scope;
    return ref
        .read(weightRepositoryProvider)
        .add(
          scope.householdId,
          scope.dogId,
          WeightEntry(kg: kg, at: weighDay(day), by: user.uid),
        );
  }

  void update(WeightEntry entry) {
    final scope = _scope;
    ref
        .read(weightRepositoryProvider)
        .update(scope.householdId, scope.dogId, entry);
  }

  void delete(String id) => _setDeleted(id, deleted: true);

  void restore(String id) => _setDeleted(id, deleted: false);

  void _setDeleted(String id, {required bool deleted}) {
    final scope = _scope;
    ref
        .read(weightRepositoryProvider)
        .setDeleted(scope.householdId, scope.dogId, id, deleted: deleted);
  }
}
