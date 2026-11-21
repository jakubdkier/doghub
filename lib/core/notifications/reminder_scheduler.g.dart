// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_scheduler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reminderScheduler)
final reminderSchedulerProvider = ReminderSchedulerProvider._();

final class ReminderSchedulerProvider
    extends
        $FunctionalProvider<
          ReminderScheduler,
          ReminderScheduler,
          ReminderScheduler
        >
    with $Provider<ReminderScheduler> {
  ReminderSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSchedulerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSchedulerHash();

  @$internal
  @override
  $ProviderElement<ReminderScheduler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReminderScheduler create(Ref ref) {
    return reminderScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderScheduler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderScheduler>(value),
    );
  }
}

String _$reminderSchedulerHash() => r'7b7d948a6c0eae9f2371f76bdeff0de9ab4f7be7';

/// Planned food reminders for the current dog (empty when signed out).

@ProviderFor(foodReminderPlan)
final foodReminderPlanProvider = FoodReminderPlanProvider._();

/// Planned food reminders for the current dog (empty when signed out).

final class FoodReminderPlanProvider
    extends
        $FunctionalProvider<
          List<FoodReminder>,
          List<FoodReminder>,
          List<FoodReminder>
        >
    with $Provider<List<FoodReminder>> {
  /// Planned food reminders for the current dog (empty when signed out).
  FoodReminderPlanProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodReminderPlanProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodReminderPlanHash();

  @$internal
  @override
  $ProviderElement<List<FoodReminder>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<FoodReminder> create(Ref ref) {
    return foodReminderPlan(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FoodReminder> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FoodReminder>>(value),
    );
  }
}

String _$foodReminderPlanHash() => r'f9894d856adbdb6bef8196dbdb9ff27119b7afec';

/// Everything to schedule, or null while data is still loading.

@ProviderFor(reminderPlan)
final reminderPlanProvider = ReminderPlanProvider._();

/// Everything to schedule, or null while data is still loading.

final class ReminderPlanProvider
    extends
        $FunctionalProvider<
          List<PlannedReminder>?,
          List<PlannedReminder>?,
          List<PlannedReminder>?
        >
    with $Provider<List<PlannedReminder>?> {
  /// Everything to schedule, or null while data is still loading.
  ReminderPlanProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderPlanProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderPlanHash();

  @$internal
  @override
  $ProviderElement<List<PlannedReminder>?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PlannedReminder>? create(Ref ref) {
    return reminderPlan(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PlannedReminder>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PlannedReminder>?>(value),
    );
  }
}

String _$reminderPlanHash() => r'70f537019a18670c121750755a1805a98dd03755';

/// Keeps scheduled notifications in sync with the data. Watched by the
/// app root, so it runs on start and after every relevant change.

@ProviderFor(reminderSync)
final reminderSyncProvider = ReminderSyncProvider._();

/// Keeps scheduled notifications in sync with the data. Watched by the
/// app root, so it runs on start and after every relevant change.

final class ReminderSyncProvider extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Keeps scheduled notifications in sync with the data. Watched by the
  /// app root, so it runs on start and after every relevant change.
  ReminderSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderSyncHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return reminderSync(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$reminderSyncHash() => r'919025dad64e3c79843da440e1d4577831ad2512';
