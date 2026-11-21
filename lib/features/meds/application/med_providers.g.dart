// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'med_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(medRepository)
final medRepositoryProvider = MedRepositoryProvider._();

final class MedRepositoryProvider
    extends $FunctionalProvider<MedRepository, MedRepository, MedRepository>
    with $Provider<MedRepository> {
  MedRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medRepositoryHash();

  @$internal
  @override
  $ProviderElement<MedRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MedRepository create(Ref ref) {
    return medRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MedRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MedRepository>(value),
    );
  }
}

String _$medRepositoryHash() => r'6986978c7340550ffbcd1090c8e90515f5b58c6f';

@ProviderFor(meds)
final medsProvider = MedsProvider._();

final class MedsProvider
    extends
        $FunctionalProvider<AsyncValue<List<Med>>, List<Med>, Stream<List<Med>>>
    with $FutureModifier<List<Med>>, $StreamProvider<List<Med>> {
  MedsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medsHash();

  @$internal
  @override
  $StreamProviderElement<List<Med>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Med>> create(Ref ref) {
    return meds(ref);
  }
}

String _$medsHash() => r'08f1175d1a0417ce6e36904243ad8288c732af25';

@ProviderFor(medDoses)
final medDosesProvider = MedDosesProvider._();

final class MedDosesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MedDose>>,
          List<MedDose>,
          Stream<List<MedDose>>
        >
    with $FutureModifier<List<MedDose>>, $StreamProvider<List<MedDose>> {
  MedDosesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medDosesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medDosesHash();

  @$internal
  @override
  $StreamProviderElement<List<MedDose>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MedDose>> create(Ref ref) {
    return medDoses(ref);
  }
}

String _$medDosesHash() => r'dfc3e5aa54959a684269fc98bc2eeade2defe9da';

@ProviderFor(MedController)
final medControllerProvider = MedControllerProvider._();

final class MedControllerProvider
    extends $NotifierProvider<MedController, void> {
  MedControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medControllerHash();

  @$internal
  @override
  MedController create() => MedController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$medControllerHash() => r'1c2e530dade19381b84af8811d589767de2422df';

abstract class _$MedController extends $Notifier<void> {
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
