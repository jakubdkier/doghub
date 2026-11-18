/// Route paths used across the app.
abstract final class Routes {
  static const login = '/login';
  static const today = '/today';
  static const history = '/history';
  static const food = '/food';
  static const health = '/health';
}

/// Pure redirect rule: no user -> /login; signed-in user on /login -> /today.
/// Onboarding steps (household, dog) are added in stage 2.
String? authRedirect({required bool signedIn, required String location}) {
  final onLogin = location == Routes.login;
  if (!signedIn) return onLogin ? null : Routes.login;
  if (onLogin || location == '/') return Routes.today;
  return null;
}
