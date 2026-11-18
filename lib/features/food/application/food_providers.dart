import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/firebase_providers.dart';
import '../../dogs/application/dog_providers.dart';
import '../data/food_repository.dart';
import '../domain/food.dart';

part 'food_providers.g.dart';

@Riverpod(keepAlive: true)
FoodRepository foodRepository(Ref ref) =>
    FoodRepository(ref.watch(firestoreProvider));

/// All foods of the current dog (active and archived), sorted by label.
@Riverpod(keepAlive: true)
Stream<List<Food>> foods(Ref ref) {
  final scope = ref.watch(dogScopeProvider);
  if (scope == null) return Stream.value(const []);
  return ref
      .watch(foodRepositoryProvider)
      .watchAll(scope.householdId, scope.dogId);
}

/// Kept alive: callbacks such as snackbar undo outlive the widgets that
/// read it.
@Riverpod(keepAlive: true)
class FoodController extends _$FoodController {
  @override
  void build() {}

  DogScope get _scope {
    final scope = ref.read(dogScopeProvider);
    if (scope == null) throw StateError('No household or dog');
    return scope;
  }

  /// Returns the new food's id.
  String add({required String name, String? brand}) {
    final scope = _scope;
    return ref
        .read(foodRepositoryProvider)
        .add(scope.householdId, scope.dogId, name: name, brand: brand);
  }

  void update(Food food) {
    final scope = _scope;
    ref
        .read(foodRepositoryProvider)
        .update(scope.householdId, scope.dogId, food);
  }
}
