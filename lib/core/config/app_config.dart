import 'package:firebase_core/firebase_core.dart';

enum Flavor { dev, prod }

/// Per-flavor configuration created in `main_<flavor>.dart`.
class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.firebaseOptions,
    required this.googleServerClientId,
    this.useEmulator = false,
    this.emulatorHost = defaultEmulatorHost,
  }) : assert(
         !useEmulator || flavor == Flavor.dev,
         'Emulators are only allowed in the dev flavor.',
       );

  /// Android emulator alias for the host machine's localhost.
  static const defaultEmulatorHost = '10.0.2.2';

  final Flavor flavor;
  final FirebaseOptions firebaseOptions;

  /// OAuth web client id (client_type 3 in google-services.json), required by
  /// google_sign_in to obtain an ID token for Firebase Auth.
  final String googleServerClientId;

  final bool useEmulator;
  final String emulatorHost;

  bool get isDev => flavor == Flavor.dev;
}
