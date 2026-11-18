import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/application/auth_providers.dart';
import '../features/dogs/application/dog_providers.dart';
import '../features/household/application/household_providers.dart';
import 'onboarding_step.dart';

part 'onboarding_provider.g.dart';

@Riverpod(keepAlive: true)
OnboardingStep onboardingStep(Ref ref) {
  final auth = ref.watch(authStateProvider);
  if (auth.hasError) return OnboardingStep.error;
  if (!auth.hasValue) return OnboardingStep.loading;
  if (auth.value == null) return OnboardingStep.signedOut;

  final household = ref.watch(currentHouseholdProvider);
  if (household.hasError) return OnboardingStep.error;
  if (!household.hasValue || household.isLoading) return OnboardingStep.loading;
  if (household.value == null) return OnboardingStep.needsHousehold;

  final dogs = ref.watch(dogsProvider);
  if (dogs.hasError) return OnboardingStep.error;
  if (!dogs.hasValue || dogs.isLoading) return OnboardingStep.loading;
  if (dogs.value!.isEmpty) return OnboardingStep.needsDog;

  return OnboardingStep.ready;
}
