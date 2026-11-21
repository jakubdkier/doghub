/// Single source of Firestore paths (see docs/PLAN.md data model).
abstract final class FirestorePaths {
  static const households = 'households';
  static String household(String householdId) => '$households/$householdId';

  static String healthTemplates(String householdId) =>
      '${household(householdId)}/healthTemplates';

  static String dogs(String householdId) => '${household(householdId)}/dogs';
  static String dog(String householdId, String dogId) =>
      '${dogs(householdId)}/$dogId';

  static String weights(String householdId, String dogId) =>
      '${dog(householdId, dogId)}/weights';

  static String events(String householdId, String dogId) =>
      '${dog(householdId, dogId)}/events';

  static String foods(String householdId, String dogId) =>
      '${dog(householdId, dogId)}/foods';

  static String health(String householdId, String dogId) =>
      '${dog(householdId, dogId)}/health';

  static String purchases(String householdId, String dogId) =>
      '${dog(householdId, dogId)}/purchases';

  static const invites = 'invites';
  static String invite(String code) => '$invites/$code';
}
