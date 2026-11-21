// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(purchaseRepository)
final purchaseRepositoryProvider = PurchaseRepositoryProvider._();

final class PurchaseRepositoryProvider
    extends
        $FunctionalProvider<
          PurchaseRepository,
          PurchaseRepository,
          PurchaseRepository
        >
    with $Provider<PurchaseRepository> {
  PurchaseRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseRepositoryHash();

  @$internal
  @override
  $ProviderElement<PurchaseRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PurchaseRepository create(Ref ref) {
    return purchaseRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PurchaseRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PurchaseRepository>(value),
    );
  }
}

String _$purchaseRepositoryHash() =>
    r'a474fdb46e2cb4170539301d1b039aa6b48cdfe6';

/// Non-deleted purchases of the current dog, newest first.

@ProviderFor(purchases)
final purchasesProvider = PurchasesProvider._();

/// Non-deleted purchases of the current dog, newest first.

final class PurchasesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Purchase>>,
          List<Purchase>,
          Stream<List<Purchase>>
        >
    with $FutureModifier<List<Purchase>>, $StreamProvider<List<Purchase>> {
  /// Non-deleted purchases of the current dog, newest first.
  PurchasesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchasesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchasesHash();

  @$internal
  @override
  $StreamProviderElement<List<Purchase>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Purchase>> create(Ref ref) {
    return purchases(ref);
  }
}

String _$purchasesHash() => r'87fd740305986a8acdeed9f8285a49c8c767d343';

/// All non-deleted meals of the current dog (stock needs full history).

@ProviderFor(meals)
final mealsProvider = MealsProvider._();

/// All non-deleted meals of the current dog (stock needs full history).

final class MealsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DogEvent>>,
          List<DogEvent>,
          Stream<List<DogEvent>>
        >
    with $FutureModifier<List<DogEvent>>, $StreamProvider<List<DogEvent>> {
  /// All non-deleted meals of the current dog (stock needs full history).
  MealsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealsHash();

  @$internal
  @override
  $StreamProviderElement<List<DogEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DogEvent>> create(Ref ref) {
    return meals(ref);
  }
}

String _$mealsHash() => r'd400e952e3b042bb88beae48121e8a5c753b3bbe';

/// Stock forecast per food id; null until foods, purchases and meals load.

@ProviderFor(stock)
final stockProvider = StockProvider._();

/// Stock forecast per food id; null until foods, purchases and meals load.

final class StockProvider
    extends
        $FunctionalProvider<
          Map<String, StockForecast>?,
          Map<String, StockForecast>?,
          Map<String, StockForecast>?
        >
    with $Provider<Map<String, StockForecast>?> {
  /// Stock forecast per food id; null until foods, purchases and meals load.
  StockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stockHash();

  @$internal
  @override
  $ProviderElement<Map<String, StockForecast>?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, StockForecast>? create(Ref ref) {
    return stock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, StockForecast>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, StockForecast>?>(value),
    );
  }
}

String _$stockHash() => r'aec5cf8111b5e2b9f7c9759706a3d2936ead9b50';

@ProviderFor(PurchaseController)
final purchaseControllerProvider = PurchaseControllerProvider._();

final class PurchaseControllerProvider
    extends $NotifierProvider<PurchaseController, void> {
  PurchaseControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'purchaseControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$purchaseControllerHash();

  @$internal
  @override
  PurchaseController create() => PurchaseController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$purchaseControllerHash() =>
    r'ca5707c5d4a2425b617a151f1116f4c5a714b372';

abstract class _$PurchaseController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
