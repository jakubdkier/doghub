import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';
import 'core/config/app_config_provider.dart';

Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'pl_PL';
  await initializeDateFormatting('pl_PL');

  await Firebase.initializeApp(options: config.firebaseOptions);

  // Offline-first: keep the whole household in the local cache.
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  if (config.useEmulator) {
    await FirebaseAuth.instance.useAuthEmulator(config.emulatorHost, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(config.emulatorHost, 8080);
  }

  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(config)],
      child: const DogHubApp(),
    ),
  );
}
