import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config_provider.dart';
import '../data/firebase_auth_repository.dart';
import '../domain/app_user.dart';
import '../domain/auth_repository.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => FirebaseAuthRepository(
  FirebaseAuth.instance,
  GoogleSignIn.instance,
  ref.watch(appConfigProvider).googleServerClientId,
);

@Riverpod(keepAlive: true)
Stream<AppUser?> authState(Ref ref) =>
    ref.watch(authRepositoryProvider).authStateChanges();

/// Sign-in / sign-out actions with loading and error state for the UI.
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      try {
        await ref.read(authRepositoryProvider).signInWithGoogle();
      } on SignInCancelledException {
        // Not an error: the user closed the account picker.
      }
    });
    if (ref.mounted) state = result;
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      ref.read(authRepositoryProvider).signOut,
    );
    if (ref.mounted) state = result;
  }
}
