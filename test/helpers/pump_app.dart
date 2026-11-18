import 'package:dog_app/app/app.dart';
import 'package:dog_app/core/config/app_config.dart';
import 'package:dog_app/core/config/app_config_provider.dart';
import 'package:dog_app/features/auth/application/auth_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_auth_repository.dart';

const testConfig = AppConfig(
  flavor: Flavor.dev,
  firebaseOptions: FirebaseOptions(
    apiKey: 'test',
    appId: 'test',
    messagingSenderId: 'test',
    projectId: 'test',
  ),
  googleServerClientId: 'test',
);

Future<void> pumpApp(WidgetTester tester, FakeAuthRepository auth) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(testConfig),
        authRepositoryProvider.overrideWithValue(auth),
      ],
      child: const DogHubApp(),
    ),
  );
  await tester.pumpAndSettle();
}
