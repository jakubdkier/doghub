import 'app_user.dart';

/// Thrown when the user dismisses the Google account picker.
class SignInCancelledException implements Exception {
  const SignInCancelledException();
}

abstract interface class AuthRepository {
  Stream<AppUser?> authStateChanges();

  AppUser? get currentUser;

  /// Throws [SignInCancelledException] when the user cancels.
  Future<void> signInWithGoogle();

  Future<void> signOut();
}
