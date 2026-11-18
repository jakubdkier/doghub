import 'bootstrap.dart';
import 'core/config/app_config.dart';
import 'core/firebase/firebase_options_prod.dart';

void main() => bootstrap(
  AppConfig(
    flavor: Flavor.prod,
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    // TODO(prod): web client id from the prod google-services.json.
    googleServerClientId: '',
  ),
);
