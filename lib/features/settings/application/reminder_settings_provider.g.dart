// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Per-device reminder settings stored in shared preferences.

@ProviderFor(ReminderSettingsController)
final reminderSettingsControllerProvider =
    ReminderSettingsControllerProvider._();

/// Per-device reminder settings stored in shared preferences.
final class ReminderSettingsControllerProvider
    extends $NotifierProvider<ReminderSettingsController, ReminderSettings> {
  /// Per-device reminder settings stored in shared preferences.
  ReminderSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSettingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSettingsControllerHash();

  @$internal
  @override
  ReminderSettingsController create() => ReminderSettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderSettings>(value),
    );
  }
}

String _$reminderSettingsControllerHash() =>
    r'8334c7cbf27625f97da440784323766e621e9ce6';

/// Per-device reminder settings stored in shared preferences.

abstract class _$ReminderSettingsController
    extends $Notifier<ReminderSettings> {
  ReminderSettings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReminderSettings, ReminderSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReminderSettings, ReminderSettings>,
              ReminderSettings,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
