import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/firebase_providers.dart';
import '../../../core/utils/clock.dart';
import '../../dogs/application/dog_providers.dart';
import '../../events/application/event_providers.dart';
import '../../events/domain/dog_event.dart';
import '../../household/application/household_providers.dart';
import '../data/purchase_repository.dart';
import '../domain/purchase.dart';
import '../domain/stock_forecast.dart';
import 'food_providers.dart';

part 'purchase_providers.g.dart';

@Riverpod(keepAlive: true)
PurchaseRepository purchaseRepository(Ref ref) =>
    PurchaseRepository(ref.watch(firestoreProvider));

/// Non-deleted purchases of the current dog, newest first.
@Riverpod(keepAlive: true)
Stream<List<Purchase>> purchases(Ref ref) {
  final scope = ref.watch(dogScopeProvider);
  if (scope == null) return Stream.value(const []);
  return ref
      .watch(purchaseRepositoryProvider)
      .watchAll(scope.householdId, scope.dogId);
}

/// All non-deleted meals of the current dog (stock needs full history).
@Riverpod(keepAlive: true)
Stream<List<DogEvent>> meals(Ref ref) {
  final scope = ref.watch(dogScopeProvider);
  if (scope == null) return Stream.value(const []);
  return ref
      .watch(eventRepositoryProvider)
      .watchMeals(scope.householdId, scope.dogId);
}

/// Stock forecast per food id; null until foods, purchases and meals load.
@Riverpod(keepAlive: true)
Map<String, StockForecast>? stock(Ref ref) {
  final foods = ref.watch(foodsProvider).value;
  final purchases = ref.watch(purchasesProvider).value;
  final meals = ref.watch(mealsProvider).value;
  if (foods == null || purchases == null || meals == null) return null;
  final now = ref.read(clockProvider)();
  return {
    for (final f in foods)
      f.id: computeStock(
        foodId: f.id,
        purchases: purchases,
        meals: meals,
        now: now,
      ),
  };
}

@Riverpod(keepAlive: true)
class PurchaseController extends _$PurchaseController {
  @override
  void build() {}

  DogScope get _scope {
    final scope = ref.read(dogScopeProvider);
    if (scope == null) throw StateError('No household or dog');
    return scope;
  }

  String add({
    required String foodId,
    required double kg,
    double? price,
    required DateTime at,
  }) {
    final user = ref.read(currentUserProvider);
    if (user == null) throw StateError('Not signed in');
    final scope = _scope;
    return ref
        .read(purchaseRepositoryProvider)
        .add(
          scope.householdId,
          scope.dogId,
          Purchase(foodId: foodId, kg: kg, price: price, at: at, by: user.uid),
        );
  }

  void delete(String id) => _setDeleted(id, deleted: true);

  void restore(String id) => _setDeleted(id, deleted: false);

  void _setDeleted(String id, {required bool deleted}) {
    final scope = _scope;
    ref
        .read(purchaseRepositoryProvider)
        .setDeleted(scope.householdId, scope.dogId, id, deleted: deleted);
  }
}
