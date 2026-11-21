import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/app/app.dart';
import 'package:dog_app/core/config/app_config.dart';
import 'package:dog_app/core/config/app_config_provider.dart';
import 'package:dog_app/core/firebase/firebase_providers.dart';
import 'package:dog_app/core/notifications/local_notifications.dart';
import 'package:dog_app/core/storage/preferences.dart';
import 'package:dog_app/features/auth/application/auth_providers.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart'
    show MaterialLocalizations, NavigationBar, Scaffold;
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_auth_repository.dart';
import 'fake_notifications.dart';

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
  FakeLocalNotifications? notifications,
  Map<String, Object> prefs = const {},
}) async {
  Intl.defaultLocale = 'pl_PL';
  await initializeDateFormatting('pl_PL');
  SharedPreferences.setMockInitialValues(prefs);
  final sharedPreferences = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(testConfig),
        authRepositoryProvider.overrideWithValue(auth),
        firestoreProvider.overrideWithValue(
          firestore ?? FakeFirebaseFirestore(),
        ),
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        localNotificationsProvider.overrideWithValue(
          notifications ?? FakeLocalNotifications(),
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

/// Taps a bottom navigation tab by its label.
Future<void> tapTab(WidgetTester tester, String label) async {
  await tester.tap(
    find.descendant(of: find.byType(NavigationBar), matching: find.text(label)),
  );
  await tester.pumpAndSettle();
}

/// Taps the app bar back button (`pageBack` expects a Cupertino one).
Future<void> tapBack(WidgetTester tester) async {
  final tooltip = MaterialLocalizations.of(
    tester.element(find.byType(Scaffold).last),
  ).backButtonTooltip;
  await tester.tap(find.byTooltip(tooltip).last);
  await tester.pumpAndSettle();
}
