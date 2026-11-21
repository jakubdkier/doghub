// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widget_sync.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Current widget content; [WidgetSnapshot.empty] without a dog.

@ProviderFor(widgetSnapshot)
final widgetSnapshotProvider = WidgetSnapshotProvider._();

/// Current widget content; [WidgetSnapshot.empty] without a dog.

final class WidgetSnapshotProvider
    extends $FunctionalProvider<WidgetSnapshot, WidgetSnapshot, WidgetSnapshot>
    with $Provider<WidgetSnapshot> {
  /// Current widget content; [WidgetSnapshot.empty] without a dog.
  WidgetSnapshotProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'widgetSnapshotProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$widgetSnapshotHash();

  @$internal
  @override
  $ProviderElement<WidgetSnapshot> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WidgetSnapshot create(Ref ref) {
    return widgetSnapshot(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WidgetSnapshot value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WidgetSnapshot>(value),
    );
  }
}

String _$widgetSnapshotHash() => r'1a0fcda9f822f15beb01153ef4198bb4d50cb129';

/// Pushes the snapshot to the home screen widgets when it changes.
/// Watched by the app root.

@ProviderFor(homeWidgetSync)
final homeWidgetSyncProvider = HomeWidgetSyncProvider._();

/// Pushes the snapshot to the home screen widgets when it changes.
/// Watched by the app root.

final class HomeWidgetSyncProvider extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Pushes the snapshot to the home screen widgets when it changes.
  /// Watched by the app root.
  HomeWidgetSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeWidgetSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeWidgetSyncHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return homeWidgetSync(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$homeWidgetSyncHash() => r'a9a3d9143edffd23037fab888dda6642b456ba5d';
