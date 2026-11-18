// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(householdRepository)
final householdRepositoryProvider = HouseholdRepositoryProvider._();

final class HouseholdRepositoryProvider
    extends
        $FunctionalProvider<
          HouseholdRepository,
          HouseholdRepository,
          HouseholdRepository
        >
    with $Provider<HouseholdRepository> {
  HouseholdRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'householdRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$householdRepositoryHash();

  @$internal
  @override
  $ProviderElement<HouseholdRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HouseholdRepository create(Ref ref) {
    return householdRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HouseholdRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HouseholdRepository>(value),
    );
  }
}

String _$householdRepositoryHash() =>
    r'8ed7bc5b7def640578c51b7ed0ec8b83bbe3407f';

@ProviderFor(inviteRepository)
final inviteRepositoryProvider = InviteRepositoryProvider._();

final class InviteRepositoryProvider
    extends
        $FunctionalProvider<
          InviteRepository,
          InviteRepository,
          InviteRepository
        >
    with $Provider<InviteRepository> {
  InviteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteRepositoryHash();

  @$internal
  @override
  $ProviderElement<InviteRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InviteRepository create(Ref ref) {
    return inviteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InviteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InviteRepository>(value),
    );
  }
}

String _$inviteRepositoryHash() => r'ad60a6c3f8f7d8bc367a8e027168bc1022ad323e';

/// Signed-in user, or null.

@ProviderFor(currentUser)
final currentUserProvider = CurrentUserProvider._();

/// Signed-in user, or null.

final class CurrentUserProvider
    extends $FunctionalProvider<AppUser?, AppUser?, AppUser?>
    with $Provider<AppUser?> {
  /// Signed-in user, or null.
  CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $ProviderElement<AppUser?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppUser? create(Ref ref) {
    return currentUser(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppUser? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppUser?>(value),
    );
  }
}

String _$currentUserHash() => r'e847c442bf06dd95e98daa78092b57243a8221cd';

@ProviderFor(currentHousehold)
final currentHouseholdProvider = CurrentHouseholdProvider._();

final class CurrentHouseholdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Household?>,
          Household?,
          Stream<Household?>
        >
    with $FutureModifier<Household?>, $StreamProvider<Household?> {
  CurrentHouseholdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentHouseholdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentHouseholdHash();

  @$internal
  @override
  $StreamProviderElement<Household?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Household?> create(Ref ref) {
    return currentHousehold(ref);
  }
}

String _$currentHouseholdHash() => r'9a41c3fcb37a279efec986f2d17180aa47425aa9';

/// The household's active invite (null when none or revoked).

@ProviderFor(activeInvite)
final activeInviteProvider = ActiveInviteProvider._();

/// The household's active invite (null when none or revoked).

final class ActiveInviteProvider
    extends $FunctionalProvider<AsyncValue<Invite?>, Invite?, Stream<Invite?>>
    with $FutureModifier<Invite?>, $StreamProvider<Invite?> {
  /// The household's active invite (null when none or revoked).
  ActiveInviteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeInviteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeInviteHash();

  @$internal
  @override
  $StreamProviderElement<Invite?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Invite?> create(Ref ref) {
    return activeInvite(ref);
  }
}

String _$activeInviteHash() => r'796f2cae4d66528ebd298c49becee7e291f7bc2c';

/// Onboarding and settings actions; errors surface through the state.

@ProviderFor(HouseholdController)
final householdControllerProvider = HouseholdControllerProvider._();

/// Onboarding and settings actions; errors surface through the state.
final class HouseholdControllerProvider
    extends $AsyncNotifierProvider<HouseholdController, void> {
  /// Onboarding and settings actions; errors surface through the state.
  HouseholdControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'householdControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$householdControllerHash();

  @$internal
  @override
  HouseholdController create() => HouseholdController();
}

String _$householdControllerHash() =>
    r'aca2b16f01ffe51e86285da291506877752c0c96';

/// Onboarding and settings actions; errors surface through the state.

abstract class _$HouseholdController extends $AsyncNotifier<void> {
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
