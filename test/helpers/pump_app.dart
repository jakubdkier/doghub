import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/app/app.dart';
import 'package:dog_app/core/config/app_config.dart';
import 'package:dog_app/core/config/app_config_provider.dart';
import 'package:dog_app/core/firebase/firebase_providers.dart';
import 'package:dog_app/features/auth/application/auth_providers.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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

Future<void> pumpApp(
  WidgetTester tester,
  FakeAuthRepository auth, {
  FakeFirebaseFirestore? firestore,
}) async {
  Intl.defaultLocale = 'pl_PL';
  await initializeDateFormatting('pl_PL');
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(testConfig),
        authRepositoryProvider.overrideWithValue(auth),
        firestoreProvider.overrideWithValue(
          firestore ?? FakeFirebaseFirestore(),
        ),
      ],
      child: const DogHubApp(),
    ),
  );
  await tester.pumpAndSettle();
}

/// Household h1 owned by the test user, optionally with dog d1.
Future<FakeFirebaseFirestore> seededFirestore({
  bool withDog = true,
  String owner = 'u1',
}) async {
  final db = FakeFirebaseFirestore();
  await db.doc('households/h1').set({
    'name': 'Dom',
    'members': [owner],
    'memberNames': {owner: owner == 'u1' ? 'Jakub' : 'Ala'},
    'createdAt': Timestamp.now(),
  });
  if (withDog) {
    await db.doc('households/h1/dogs/d1').set({
      'name': 'Burek',
      'createdAt': Timestamp.now(),
    });
  }
  return db;
}
