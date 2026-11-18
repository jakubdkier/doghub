import 'package:dog_app/core/config/app_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';

const _options = FirebaseOptions(
  apiKey: 'k',
  appId: 'a',
  messagingSenderId: 'm',
  projectId: 'p',
);

void main() {
  test('emulators are rejected in the prod flavor', () {
    expect(
      () => AppConfig(
        flavor: Flavor.prod,
        firebaseOptions: _options,
        googleServerClientId: '',
        useEmulator: true,
      ),
      throwsA(isA<AssertionError>()),
    );
  });

  test('dev flavor defaults to Android emulator host', () {
    const config = AppConfig(
      flavor: Flavor.dev,
      firebaseOptions: _options,
      googleServerClientId: '',
      useEmulator: true,
    );
    expect(config.isDev, isTrue);
    expect(config.emulatorHost, '10.0.2.2');
  });
}
