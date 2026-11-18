/// Route paths used across the app.
abstract final class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const onboardingHousehold = '/onboarding/household';
  static const onboardingDog = '/onboarding/dog';
  static const today = '/today';
  static const history = '/history';
  static const food = '/food';
  static const health = '/health';
  static const settings = '/settings';
  static const settingsHousehold = '/settings/household';

  /// Edit an event (outside the shell, like settings).
  static const eventPattern = '/event/:id';
  static String event(String id) => '/event/$id';

  /// Deep link target for the home widget and notifications.
  static const quickAdd = '/quick-add';
  static String quickAddFor(String type) => '$quickAdd?type=$type';
}
