// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dogRepository)
final dogRepositoryProvider = DogRepositoryProvider._();

final class DogRepositoryProvider
    extends $FunctionalProvider<DogRepository, DogRepository, DogRepository>
    with $Provider<DogRepository> {
  DogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dogRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dogRepositoryHash();

  @$internal
  @override
  $ProviderElement<DogRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DogRepository create(Ref ref) {
    return dogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DogRepository>(value),
    );
  }
}

String _$dogRepositoryHash() => r'2f736b382a71edb3002d3b5eff72432498e931b8';

@ProviderFor(dogs)
final dogsProvider = DogsProvider._();

final class DogsProvider
    extends
        $FunctionalProvider<AsyncValue<List<Dog>>, List<Dog>, Stream<List<Dog>>>
    with $FutureModifier<List<Dog>>, $StreamProvider<List<Dog>> {
  DogsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dogsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dogsHash();

  @$internal
  @override
  $StreamProviderElement<List<Dog>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Dog>> create(Ref ref) {
    return dogs(ref);
  }
}

String _$dogsHash() => r'a44303eaa6817a9a257ea14469fce948bedd98c8';

/// Dog shown in the app. The dog switcher (stage 3) will make this selectable.

@ProviderFor(currentDog)
final currentDogProvider = CurrentDogProvider._();

/// Dog shown in the app. The dog switcher (stage 3) will make this selectable.

final class CurrentDogProvider extends $FunctionalProvider<Dog?, Dog?, Dog?>
    with $Provider<Dog?> {
  /// Dog shown in the app. The dog switcher (stage 3) will make this selectable.
  CurrentDogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentDogProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentDogHash();

  @$internal
  @override
  $ProviderElement<Dog?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dog? create(Ref ref) {
    return currentDog(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dog? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dog?>(value),
    );
  }
}

String _$currentDogHash() => r'41243214d40e4c837d46a84de118ac1f41f4de3f';

@ProviderFor(DogController)
final dogControllerProvider = DogControllerProvider._();

final class DogControllerProvider
    extends $AsyncNotifierProvider<DogController, void> {
  DogControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dogControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dogControllerHash();

  @$internal
  @override
  DogController create() => DogController();
}

String _$dogControllerHash() => r'bb46bc18c232346cd9276d1afbc22c8a049e8263';

abstract class _$DogController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
