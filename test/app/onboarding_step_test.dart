import 'package:dog_app/app/onboarding_step.dart';
import 'package:dog_app/app/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('onboardingRedirect', () {
    test('loading and error show the splash', () {
      expect(
        onboardingRedirect(OnboardingStep.loading, Routes.today),
        Routes.splash,
      );
      expect(
        onboardingRedirect(OnboardingStep.error, Routes.login),
        Routes.splash,
      );
      expect(onboardingRedirect(OnboardingStep.loading, Routes.splash), isNull);
    });

    test('signed out goes to login from anywhere', () {
      expect(
        onboardingRedirect(OnboardingStep.signedOut, Routes.food),
        Routes.login,
      );
      expect(
        onboardingRedirect(OnboardingStep.signedOut, Routes.settings),
        Routes.login,
      );
      expect(
        onboardingRedirect(OnboardingStep.signedOut, Routes.login),
        isNull,
      );
    });

    test('missing household or dog forces the onboarding step', () {
      expect(
        onboardingRedirect(OnboardingStep.needsHousehold, Routes.today),
        Routes.onboardingHousehold,
      );
      expect(
        onboardingRedirect(OnboardingStep.needsHousehold, Routes.onboardingDog),
        Routes.onboardingHousehold,
      );
      expect(
        onboardingRedirect(OnboardingStep.needsDog, Routes.onboardingHousehold),
        Routes.onboardingDog,
      );
      expect(
        onboardingRedirect(OnboardingStep.needsDog, Routes.onboardingDog),
        isNull,
      );
    });

    test('ready user leaves entry pages for /today', () {
      for (final entry in [
        '/',
        Routes.splash,
        Routes.login,
        Routes.onboardingHousehold,
        Routes.onboardingDog,
      ]) {
        expect(onboardingRedirect(OnboardingStep.ready, entry), Routes.today);
      }
    });

    test('ready user keeps app pages', () {
      expect(onboardingRedirect(OnboardingStep.ready, Routes.health), isNull);
      expect(
        onboardingRedirect(OnboardingStep.ready, Routes.settingsHousehold),
        isNull,
      );
    });
  });
}
