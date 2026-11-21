/// Route paths used across the app.
abstract final class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const onboardingHousehold = '/onboarding/household';
  static const onboardingDog = '/onboarding/dog';
  static const today = '/today';
  static const history = '/history';
  static const food = '/food';
  static String foodDetail(String foodId) => '/food/$foodId';
  static const newPurchase = '/food/purchase/new';
  static String newPurchaseFor(String foodId) => '$newPurchase?foodId=$foodId';
  static const health = '/health';
  static const healthWeight = '/health/weight';
  static const healthNew = '/health/new';
  static String healthNewFor(String type) => '$healthNew?type=$type';
  static String healthType(String type) => '/health/type/$type';
  static String healthEntry(String id) => '/health/entry/$id';
  static const settings = '/settings';
  static const settingsHousehold = '/settings/household';
  static const settingsReminders = '/settings/reminders';
  static const settingsTemplates = '/settings/templates';

  /// Edit an event (outside the shell, like settings).
  static const eventPattern = '/event/:id';
  static String event(String id) => '/event/$id';

  /// Deep link target for the home widget and notifications.
  static const quickAdd = '/quick-add';
  static String quickAddFor(String type) => '$quickAdd?type=$type';
}
