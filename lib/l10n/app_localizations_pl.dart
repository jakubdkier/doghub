// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'DogHub';

  @override
  String get navToday => 'Dziś';

  @override
  String get navHistory => 'Historia';

  @override
  String get navFood => 'Karma';

  @override
  String get navHealth => 'Zdrowie';

  @override
  String get loginTagline => 'Wspólny dziennik Twojego psa';

  @override
  String get loginWithGoogle => 'Zaloguj przez Google';

  @override
  String get loginError => 'Nie udało się zalogować. Spróbuj ponownie.';

  @override
  String get signOut => 'Wyloguj';

  @override
  String get comingSoon => 'Wkrótce';
}
