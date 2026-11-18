/// Single source of Firestore paths (see docs/PLAN.md data model).
abstract final class FirestorePaths {
  static const households = 'households';
  static String household(String householdId) => '$households/$householdId';

  static String dogs(String householdId) => '${household(householdId)}/dogs';
  static String dog(String householdId, String dogId) =>
      '${dogs(householdId)}/$dogId';

  static String weights(String householdId, String dogId) =>
      '${dog(householdId, dogId)}/weights';

  static const invites = 'invites';
  static String invite(String code) => '$invites/$code';
}
