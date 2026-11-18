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

  @override
  String get genericError => 'Coś poszło nie tak.';

  @override
  String get fieldRequired => 'To pole jest wymagane';

  @override
  String get save => 'Zapisz';

  @override
  String get splashError =>
      'Nie udało się wczytać danych. Sprawdź połączenie i uruchom aplikację ponownie.';

  @override
  String get onboardingHouseholdTitle => 'Wspólny dom';

  @override
  String get onboardingHouseholdIntro =>
      'Dziennik psa prowadzicie razem w ramach jednego domu. Utwórz nowy albo dołącz kodem od domownika.';

  @override
  String get createHouseholdHeader => 'Utwórz nowy dom';

  @override
  String get householdNameLabel => 'Nazwa domu';

  @override
  String get householdNameDefault => 'Nasz dom';

  @override
  String get createHouseholdButton => 'Utwórz';

  @override
  String get joinHouseholdHeader => 'Mam kod zaproszenia';

  @override
  String get inviteCodeLabel => 'Kod zaproszenia';

  @override
  String get joinButton => 'Dołącz';

  @override
  String get joinErrorInvalidCode => 'Kod ma 6 znaków (litery i cyfry).';

  @override
  String get joinErrorNotFound => 'Nie ma takiego kodu.';

  @override
  String get joinErrorExpired => 'Kod wygasł. Poproś domownika o nowy.';

  @override
  String get joinErrorOffline => 'Brak połączenia z internetem.';

  @override
  String get joinErrorDenied => 'Nie udało się dołączyć. Poproś o nowy kod.';

  @override
  String get onboardingDogTitle => 'Dodaj psa';

  @override
  String get dogNameLabel => 'Imię';

  @override
  String get dogBreedLabel => 'Rasa (opcjonalnie)';

  @override
  String get dogBirthDateLabel => 'Data urodzenia (opcjonalnie)';

  @override
  String get dogWeightLabel => 'Waga startowa w kg (opcjonalnie)';

  @override
  String get dogWeightInvalid => 'Podaj wagę, np. 12,5';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get settingsHousehold => 'Dom i domownicy';

  @override
  String get householdMembers => 'Domownicy';

  @override
  String memberYou(String name) {
    return '$name (Ty)';
  }

  @override
  String get inviteHeader => 'Zaproś domownika';

  @override
  String get inviteDescription =>
      'Kod jest ważny 24 godziny. Domownik wpisuje go po zalogowaniu się w aplikacji.';

  @override
  String get inviteGenerate => 'Wygeneruj kod';

  @override
  String inviteValidUntil(String date) {
    return 'Ważny do $date';
  }

  @override
  String get inviteCopy => 'Kopiuj kod';

  @override
  String get inviteCopied => 'Skopiowano kod';

  @override
  String get inviteRevoke => 'Unieważnij';

  @override
  String get inviteErrorOffline =>
      'Wygenerowanie kodu wymaga połączenia z internetem.';
}
