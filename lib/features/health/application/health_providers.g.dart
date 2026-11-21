// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(healthRepository)
final healthRepositoryProvider = HealthRepositoryProvider._();

final class HealthRepositoryProvider
    extends
        $FunctionalProvider<
          HealthRepository,
          HealthRepository,
          HealthRepository
        >
    with $Provider<HealthRepository> {
  HealthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthRepositoryHash();

  @$internal
  @override
  $ProviderElement<HealthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HealthRepository create(Ref ref) {
    return healthRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HealthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HealthRepository>(value),
    );
  }
}

String _$healthRepositoryHash() => r'91be7e2d38bcc36246a97d467806cf227a955fa8';

@ProviderFor(healthTemplateRepository)
final healthTemplateRepositoryProvider = HealthTemplateRepositoryProvider._();

final class HealthTemplateRepositoryProvider
    extends
        $FunctionalProvider<
          HealthTemplateRepository,
          HealthTemplateRepository,
          HealthTemplateRepository
        >
    with $Provider<HealthTemplateRepository> {
  HealthTemplateRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthTemplateRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthTemplateRepositoryHash();

  @$internal
  @override
  $ProviderElement<HealthTemplateRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HealthTemplateRepository create(Ref ref) {
    return healthTemplateRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HealthTemplateRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HealthTemplateRepository>(value),
    );
  }
}

String _$healthTemplateRepositoryHash() =>
    r'5d2bbb5bc51349bffeb4f52478f5f6c619800def';

/// Built-in templates merged with the household's stored ones (incl.
/// archived). Defaults are available even before anything loads.

@ProviderFor(healthTemplates)
final healthTemplatesProvider = HealthTemplatesProvider._();

/// Built-in templates merged with the household's stored ones (incl.
/// archived). Defaults are available even before anything loads.

final class HealthTemplatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HealthTemplate>>,
          List<HealthTemplate>,
          Stream<List<HealthTemplate>>
        >
    with
        $FutureModifier<List<HealthTemplate>>,
        $StreamProvider<List<HealthTemplate>> {
  /// Built-in templates merged with the household's stored ones (incl.
  /// archived). Defaults are available even before anything loads.
  HealthTemplatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthTemplatesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthTemplatesHash();

  @$internal
  @override
  $StreamProviderElement<List<HealthTemplate>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HealthTemplate>> create(Ref ref) {
    return healthTemplates(ref);
  }
}

String _$healthTemplatesHash() => r'687b120857900741512b96a35a2167ce251c4a77';

/// Non-deleted health entries of the current dog, newest first.

@ProviderFor(healthEntries)
final healthEntriesProvider = HealthEntriesProvider._();

/// Non-deleted health entries of the current dog, newest first.

final class HealthEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HealthEntry>>,
          List<HealthEntry>,
          Stream<List<HealthEntry>>
        >
    with
        $FutureModifier<List<HealthEntry>>,
        $StreamProvider<List<HealthEntry>> {
  /// Non-deleted health entries of the current dog, newest first.
  HealthEntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthEntriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthEntriesHash();

  @$internal
  @override
  $StreamProviderElement<List<HealthEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HealthEntry>> create(Ref ref) {
    return healthEntries(ref);
  }
}

String _$healthEntriesHash() => r'069ab8247e7bb124fc9bacff6fc83e439a5173d3';

/// Series with status, most urgent first; null until entries load.

@ProviderFor(healthSeriesList)
final healthSeriesListProvider = HealthSeriesListProvider._();

/// Series with status, most urgent first; null until entries load.

final class HealthSeriesListProvider
    extends
        $FunctionalProvider<
          List<HealthSeries>?,
          List<HealthSeries>?,
          List<HealthSeries>?
        >
    with $Provider<List<HealthSeries>?> {
  /// Series with status, most urgent first; null until entries load.
  HealthSeriesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthSeriesListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthSeriesListHash();

  @$internal
  @override
  $ProviderElement<List<HealthSeries>?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<HealthSeries>? create(Ref ref) {
    return healthSeriesList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<HealthSeries>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<HealthSeries>?>(value),
    );
  }
}

String _$healthSeriesListHash() => r'947de2b2a3c70bfd50924758ad966e53b00d907b';

@ProviderFor(HealthController)
final healthControllerProvider = HealthControllerProvider._();

final class HealthControllerProvider
    extends $NotifierProvider<HealthController, void> {
  HealthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthControllerHash();

  @$internal
  @override
  HealthController create() => HealthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$healthControllerHash() => r'1069a1e8a1e0f70bf1fb4598cf1febcef7ab5cf8';

abstract class _$HealthController extends $Notifier<void> {
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
