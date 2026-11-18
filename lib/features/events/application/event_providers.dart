import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/firebase_providers.dart';
import '../../../core/utils/clock.dart';
import '../../dogs/application/dog_providers.dart';
import '../../household/application/household_providers.dart';
import '../data/event_repository.dart';
import '../domain/dog_event.dart';
import '../domain/event_query.dart';
import '../domain/event_timeline.dart';

part 'event_providers.g.dart';

/// How far back the Today screen looks for "last meal/poop/walk".
const recentWindowDays = 7;

@Riverpod(keepAlive: true)
EventRepository eventRepository(Ref ref) =>
    EventRepository(ref.watch(firestoreProvider));

/// Non-deleted events of the current dog from the last [recentWindowDays]
/// days, newest first. Feeds the Today screen and quick-add defaults.
@Riverpod(keepAlive: true)
Stream<List<DogEvent>> recentEvents(Ref ref) {
  final scope = ref.watch(dogScopeProvider);
  if (scope == null) return Stream.value(const []);
  final now = ref.read(clockProvider)();
  final since = startOfDay(now)
      .subtract(const Duration(days: recentWindowDays - 1));
  return ref
      .watch(eventRepositoryProvider)
      .watchSince(scope.householdId, scope.dogId, since);
}

/// History filter and page size.
@riverpod
class HistoryQuery extends _$HistoryQuery {
  @override
  EventQuery build() => const EventQuery();

  void toggle(EventType type) => state = state.toggle(type);

  void clearTypes() => state = const EventQuery();

  void loadMore() => state = state.nextPage();
}

@riverpod
Stream<EventPage> history(Ref ref) {
  final scope = ref.watch(dogScopeProvider);
  if (scope == null) {
    return Stream.value(const EventPage(events: [], hasMore: false));
  }
  return ref
      .watch(eventRepositoryProvider)
      .watchHistory(
        scope.householdId,
        scope.dogId,
        ref.watch(historyQueryProvider),
      );
}

@riverpod
Stream<DogEvent?> event(Ref ref, String id) {
  final scope = ref.watch(dogScopeProvider);
  if (scope == null) return Stream.value(null);
  return ref
      .watch(eventRepositoryProvider)
      .watchOne(scope.householdId, scope.dogId, id);
}

/// Writes for the current dog. All work offline.
@riverpod
class EventController extends _$EventController {
  @override
  void build() {}

  DogScope get _scope {
    final scope = ref.read(dogScopeProvider);
    if (scope == null) throw StateError('No household or dog');
    return scope;
  }

  EventRepository get _repo => ref.read(eventRepositoryProvider);

  /// Creates [draft] authored by the signed-in user; returns the new id.
  String add(DogEvent draft) {
    final user = ref.read(currentUserProvider);
    if (user == null) throw StateError('Not signed in');
    final scope = _scope;
    return _repo.add(
      scope.householdId,
      scope.dogId,
      draft.copyWith(by: user.uid),
    );
  }

  void update(DogEvent event) {
    final scope = _scope;
    _repo.update(scope.householdId, scope.dogId, event);
  }

  void delete(String id) => _setDeleted(id, deleted: true);

  void restore(String id) => _setDeleted(id, deleted: false);

  void _setDeleted(String id, {required bool deleted}) {
    final scope = _scope;
    _repo.setDeleted(scope.householdId, scope.dogId, id, deleted: deleted);
  }
}
