// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weightRepository)
final weightRepositoryProvider = WeightRepositoryProvider._();

final class WeightRepositoryProvider
    extends
        $FunctionalProvider<
          WeightRepository,
          WeightRepository,
          WeightRepository
        >
    with $Provider<WeightRepository> {
  WeightRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weightRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weightRepositoryHash();

  @$internal
  @override
  $ProviderElement<WeightRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WeightRepository create(Ref ref) {
    return weightRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeightRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeightRepository>(value),
    );
  }
}

String _$weightRepositoryHash() => r'0987b0f197e0b065c8fbac5eb774b06a47887f4c';

/// Non-deleted measurements of the current dog, newest first.

@ProviderFor(weights)
final weightsProvider = WeightsProvider._();

/// Non-deleted measurements of the current dog, newest first.

final class WeightsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WeightEntry>>,
          List<WeightEntry>,
          Stream<List<WeightEntry>>
        >
    with
        $FutureModifier<List<WeightEntry>>,
        $StreamProvider<List<WeightEntry>> {
  /// Non-deleted measurements of the current dog, newest first.
  WeightsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weightsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weightsHash();

  @$internal
  @override
  $StreamProviderElement<List<WeightEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<WeightEntry>> create(Ref ref) {
    return weights(ref);
  }
}

String _$weightsHash() => r'c9f470949e0ebb09bb86968152a74db50edc6f0e';

@ProviderFor(WeightController)
final weightControllerProvider = WeightControllerProvider._();

final class WeightControllerProvider
    extends $NotifierProvider<WeightController, void> {
  WeightControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weightControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weightControllerHash();

  @$internal
  @override
  WeightController create() => WeightController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$weightControllerHash() => r'1bba368817785d4510a3a2b853dd4d13635a171b';

abstract class _$WeightController extends $Notifier<void> {
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
