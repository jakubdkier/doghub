import 'bootstrap.dart';
import 'core/config/app_config.dart';
import 'core/firebase/firebase_options_dev.dart';

/// Run against local emulators:
/// `flutter run --flavor dev -t lib/main_dev.dart --dart-define=USE_EMULATOR=true`
/// On a physical device add `--dart-define=EMULATOR_HOST=<pc-lan-ip>`.
void main() => bootstrap(
  AppConfig(
    flavor: Flavor.dev,
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    googleServerClientId: '890174238222-9bl01anernra7qktoqc1elgbkmfuncv5.apps.googleusercontent.com',
    useEmulator: const bool.fromEnvironment('USE_EMULATOR'),
    emulatorHost: const String.fromEnvironment(
      'EMULATOR_HOST',
      defaultValue: AppConfig.defaultEmulatorHost,
    ),
  ),
);
