import 'routes.dart';

/// Where the signed-in user is in the setup flow.
enum OnboardingStep {
  loading,
  error,
  signedOut,
  needsHousehold,
  needsDog,
  ready,
}

/// Pure redirect rule for go_router based on the onboarding step.
String? onboardingRedirect(OnboardingStep step, String location) {
  String? only(String target) => location == target ? null : target;

  switch (step) {
    case OnboardingStep.loading:
    case OnboardingStep.error:
      return only(Routes.splash);
    case OnboardingStep.signedOut:
      return only(Routes.login);
    case OnboardingStep.needsHousehold:
      return only(Routes.onboardingHousehold);
    case OnboardingStep.needsDog:
      return only(Routes.onboardingDog);
    case OnboardingStep.ready:
      const entryPages = {
        '/',
        Routes.splash,
        Routes.login,
        Routes.onboardingHousehold,
        Routes.onboardingDog,
      };
      return entryPages.contains(location) ? Routes.today : null;
  }
}
