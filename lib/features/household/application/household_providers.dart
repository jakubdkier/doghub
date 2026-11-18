import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ProviderListenableSelect;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/firebase/firebase_providers.dart';
import '../../auth/application/auth_providers.dart';
import '../../auth/domain/app_user.dart';
import '../data/household_repository.dart';
import '../data/invite_repository.dart';
import '../domain/household.dart';
import '../domain/invite.dart';

part 'household_providers.g.dart';

@Riverpod(keepAlive: true)
HouseholdRepository householdRepository(Ref ref) =>
    HouseholdRepository(ref.watch(firestoreProvider));

@Riverpod(keepAlive: true)
InviteRepository inviteRepository(Ref ref) =>
    InviteRepository(ref.watch(firestoreProvider));

/// Signed-in user, or null.
@Riverpod(keepAlive: true)
AppUser? currentUser(Ref ref) => ref.watch(authStateProvider).value;

@Riverpod(keepAlive: true)
Stream<Household?> currentHousehold(Ref ref) {
  final uid = ref.watch(currentUserProvider.select((u) => u?.uid));
  if (uid == null) return Stream.value(null);
  return ref.watch(householdRepositoryProvider).watchForMember(uid);
}

/// The household's active invite (null when none or revoked).
@riverpod
Stream<Invite?> activeInvite(Ref ref) {
  final code = ref.watch(
    currentHouseholdProvider.select((h) => h.value?.inviteCode),
  );
  if (code == null) return Stream.value(null);
  return ref.watch(inviteRepositoryProvider).watch(code);
}

/// Onboarding and settings actions; errors surface through the state.
@riverpod
class HouseholdController extends _$HouseholdController {
  @override
  FutureOr<void> build() {}

  AppUser get _user {
    final user = ref.read(currentUserProvider);
    if (user == null) throw StateError('Not signed in');
    return user;
  }

  void create(String name) {
    final user = _user;
    ref
        .read(householdRepositoryProvider)
        .create(name: name, uid: user.uid, memberName: user.preferredName);
  }

  Future<void> join(String code) => _run(() async {
    final user = _user;
    await ref
        .read(householdRepositoryProvider)
        .join(code: code, uid: user.uid, memberName: user.preferredName);
  });

  Future<void> createInvite() => _run(() async {
    final household = await ref.read(currentHouseholdProvider.future);
    if (household == null) return;
    await ref
        .read(inviteRepositoryProvider)
        .create(householdId: household.id, uid: _user.uid);
  });

  void revokeInvite() {
    final household = ref.read(currentHouseholdProvider).value;
    final code = household?.inviteCode;
    if (household == null || code == null) return;
    ref
        .read(inviteRepositoryProvider)
        .revoke(householdId: household.id, code: code);
  }

  Future<void> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(action);
    if (ref.mounted) state = result;
  }
}
