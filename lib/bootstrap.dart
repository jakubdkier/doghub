import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'app/app.dart';
import 'core/config/app_config.dart';
import 'core/config/app_config_provider.dart';
import 'core/notifications/local_notifications.dart';
import 'core/storage/preferences.dart';

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

  final prefs = await SharedPreferences.getInstance();
  await _initTimeZone();
  final notifications = await PluginLocalNotifications.init();

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        sharedPreferencesProvider.overrideWithValue(prefs),
        localNotificationsProvider.overrideWithValue(notifications),
      ],
      child: const DogHubApp(),
    ),
  );
}

/// Scheduled reminders use wall-clock time in the device's zone.
Future<void> _initTimeZone() async {
  tz.initializeTimeZones();
  try {
    final info = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(info.identifier));
  } catch (e) {
    debugPrint('Local time zone unavailable, using Europe/Warsaw: $e');
    tz.setLocalLocation(tz.getLocation('Europe/Warsaw'));
  }
}
