// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(onboardingStep)
final onboardingStepProvider = OnboardingStepProvider._();

final class OnboardingStepProvider
    extends $FunctionalProvider<OnboardingStep, OnboardingStep, OnboardingStep>
    with $Provider<OnboardingStep> {
  OnboardingStepProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingStepProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingStepHash();

  @$internal
  @override
  $ProviderElement<OnboardingStep> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OnboardingStep create(Ref ref) {
    return onboardingStep(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingStep value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingStep>(value),
    );
  }
}

String _$onboardingStepHash() => r'df8396bb8c137f19cb3c67ad5529b0b2a0bfaaa9';
