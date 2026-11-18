import 'package:dog_app/app/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('authRedirect', () {
    test('signed out user is sent to /login from any page', () {
      expect(
        authRedirect(signedIn: false, location: Routes.today),
        Routes.login,
      );
      expect(
        authRedirect(signedIn: false, location: Routes.food),
        Routes.login,
      );
    });

    test('signed out user stays on /login', () {
      expect(authRedirect(signedIn: false, location: Routes.login), isNull);
    });

    test('signed in user leaves /login and root for /today', () {
      expect(
        authRedirect(signedIn: true, location: Routes.login),
        Routes.today,
      );
      expect(authRedirect(signedIn: true, location: '/'), Routes.today);
    });

    test('signed in user keeps the requested page', () {
      expect(authRedirect(signedIn: true, location: Routes.health), isNull);
    });
  });
}
