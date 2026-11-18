// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(foodRepository)
final foodRepositoryProvider = FoodRepositoryProvider._();

final class FoodRepositoryProvider
    extends $FunctionalProvider<FoodRepository, FoodRepository, FoodRepository>
    with $Provider<FoodRepository> {
  FoodRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodRepositoryHash();

  @$internal
  @override
  $ProviderElement<FoodRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FoodRepository create(Ref ref) {
    return foodRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FoodRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodRepository>(value),
    );
  }
}

String _$foodRepositoryHash() => r'f5af0b7b9be11facebeaf9f1d34df6e90b6c25e9';

/// All foods of the current dog (active and archived), sorted by label.

@ProviderFor(foods)
final foodsProvider = FoodsProvider._();

/// All foods of the current dog (active and archived), sorted by label.

final class FoodsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Food>>,
          List<Food>,
          Stream<List<Food>>
        >
    with $FutureModifier<List<Food>>, $StreamProvider<List<Food>> {
  /// All foods of the current dog (active and archived), sorted by label.
  FoodsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodsHash();

  @$internal
  @override
  $StreamProviderElement<List<Food>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Food>> create(Ref ref) {
    return foods(ref);
  }
}

String _$foodsHash() => r'487629254087f04a7ea4c899336f61d49ff9d210';

/// Kept alive: callbacks such as snackbar undo outlive the widgets that
/// read it.

@ProviderFor(FoodController)
final foodControllerProvider = FoodControllerProvider._();

/// Kept alive: callbacks such as snackbar undo outlive the widgets that
/// read it.
final class FoodControllerProvider
    extends $NotifierProvider<FoodController, void> {
  /// Kept alive: callbacks such as snackbar undo outlive the widgets that
  /// read it.
  FoodControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodControllerHash();

  @$internal
  @override
  FoodController create() => FoodController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$foodControllerHash() => r'597880ddef41978efd20660bd3c070a53838a2aa';

/// Kept alive: callbacks such as snackbar undo outlive the widgets that
/// read it.

abstract class _$FoodController extends $Notifier<void> {
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
