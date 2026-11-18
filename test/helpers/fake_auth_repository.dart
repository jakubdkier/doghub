import 'dart:async';

import 'package:dog_app/features/auth/domain/app_user.dart';
import 'package:dog_app/features/auth/domain/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({AppUser? initialUser}) : _user = initialUser;

  static const testUser = AppUser(uid: 'u1', displayName: 'Jakub');

  final _controller = StreamController<AppUser?>.broadcast();
  AppUser? _user;
  bool cancelNextSignIn = false;

  void emit(AppUser? user) {
    _user = user;
    _controller.add(user);
  }

  @override
  Stream<AppUser?> authStateChanges() async* {
    yield _user;
    yield* _controller.stream;
  }

  @override
  AppUser? get currentUser => _user;

  @override
  Future<void> signInWithGoogle() async {
    if (cancelNextSignIn) {
      cancelNextSignIn = false;
      throw const SignInCancelledException();
    }
    emit(testUser);
  }

  @override
  Future<void> signOut() async => emit(null);
}
