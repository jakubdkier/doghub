import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ProviderListenableSelect;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/firebase_providers.dart';
import '../../../core/utils/clock.dart';
import '../../dogs/application/dog_providers.dart';
import '../../household/application/household_providers.dart';
import '../data/health_repository.dart';
import '../data/health_template_repository.dart';
import '../domain/health_entry.dart';
import '../domain/health_schedule.dart';
import '../domain/health_template.dart';

part 'health_providers.g.dart';

@Riverpod(keepAlive: true)
HealthRepository healthRepository(Ref ref) =>
    HealthRepository(ref.watch(firestoreProvider));

@Riverpod(keepAlive: true)
HealthTemplateRepository healthTemplateRepository(Ref ref) =>
    HealthTemplateRepository(ref.watch(firestoreProvider));

/// Built-in templates merged with the household's stored ones (incl.
/// archived). Defaults are available even before anything loads.
@Riverpod(keepAlive: true)
Stream<List<HealthTemplate>> healthTemplates(Ref ref) {
  final householdId = ref.watch(
    currentHouseholdProvider.select((h) => h.value?.id),
  );
  if (householdId == null) return Stream.value(defaultHealthTemplates);
  return ref
      .watch(healthTemplateRepositoryProvider)
      .watchStored(householdId)
      .map(mergeTemplates);
}

/// Non-deleted health entries of the current dog, newest first.
@Riverpod(keepAlive: true)
Stream<List<HealthEntry>> healthEntries(Ref ref) {
  final scope = ref.watch(dogScopeProvider);
  if (scope == null) return Stream.value(const []);
  return ref
      .watch(healthRepositoryProvider)
      .watchAll(scope.householdId, scope.dogId);
}

/// Series with status, most urgent first; null until entries load.
@Riverpod(keepAlive: true)
List<HealthSeries>? healthSeriesList(Ref ref) {
  final entries = ref.watch(healthEntriesProvider).value;
  if (entries == null) return null;
  return healthSeries(entries, ref.read(clockProvider)());
}

@Riverpod(keepAlive: true)
class HealthController extends _$HealthController {
  @override
  void build() {}

  DogScope get _scope {
    final scope = ref.read(dogScopeProvider);
    if (scope == null) throw StateError('No household or dog');
    return scope;
  }

  HealthRepository get _repo => ref.read(healthRepositoryProvider);

  String add(HealthEntry draft) {
    final user = ref.read(currentUserProvider);
    if (user == null) throw StateError('Not signed in');
    final scope = _scope;
    return _repo.add(
      scope.householdId,
      scope.dogId,
      draft.copyWith(by: user.uid),
    );
  }

  void update(HealthEntry entry) {
    final scope = _scope;
    _repo.update(scope.householdId, scope.dogId, entry);
  }

  void delete(String id) => _setDeleted(id, deleted: true);

  void restore(String id) => _setDeleted(id, deleted: false);

  void _setDeleted(String id, {required bool deleted}) {
    final scope = _scope;
    _repo.setDeleted(scope.householdId, scope.dogId, id, deleted: deleted);
  }

  /// Saves a template override or a custom template (new if [id] is null).
  void saveTemplate(HealthTemplate template) {
    final householdId = ref.read(currentHouseholdProvider).value?.id;
    if (householdId == null) throw StateError('No household');
    final repo = ref.read(healthTemplateRepositoryProvider);
    final t = template.id.isEmpty
        ? template.copyWith(id: repo.newId(householdId))
        : template;
    repo.save(householdId, t);
  }
}
