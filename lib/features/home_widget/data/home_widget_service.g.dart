// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widget_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Overridden in bootstrap with [PluginHomeWidgetService] and in tests.

@ProviderFor(homeWidgetService)
final homeWidgetServiceProvider = HomeWidgetServiceProvider._();

/// Overridden in bootstrap with [PluginHomeWidgetService] and in tests.

final class HomeWidgetServiceProvider
    extends
        $FunctionalProvider<
          HomeWidgetService,
          HomeWidgetService,
          HomeWidgetService
        >
    with $Provider<HomeWidgetService> {
  /// Overridden in bootstrap with [PluginHomeWidgetService] and in tests.
  HomeWidgetServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeWidgetServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeWidgetServiceHash();

  @$internal
  @override
  $ProviderElement<HomeWidgetService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeWidgetService create(Ref ref) {
    return homeWidgetService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeWidgetService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeWidgetService>(value),
    );
  }
}

String _$homeWidgetServiceHash() => r'cf1cf0b9d3a95473a67f8f5baee17ac97c205c14';
