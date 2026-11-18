// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hidden_events.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ids swiped away in this session. Hides them at once, before the
/// Firestore snapshot reflects the soft delete (Dismissible requires it).

@ProviderFor(HiddenEvents)
final hiddenEventsProvider = HiddenEventsProvider._();

/// Ids swiped away in this session. Hides them at once, before the
/// Firestore snapshot reflects the soft delete (Dismissible requires it).
final class HiddenEventsProvider
    extends $NotifierProvider<HiddenEvents, Set<String>> {
  /// Ids swiped away in this session. Hides them at once, before the
  /// Firestore snapshot reflects the soft delete (Dismissible requires it).
  HiddenEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hiddenEventsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hiddenEventsHash();

  @$internal
  @override
  HiddenEvents create() => HiddenEvents();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$hiddenEventsHash() => r'dc6b6dea81715d509c1c5a3c6f90ea101bcad6ce';

/// Ids swiped away in this session. Hides them at once, before the
/// Firestore snapshot reflects the soft delete (Dismissible requires it).

abstract class _$HiddenEvents extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
