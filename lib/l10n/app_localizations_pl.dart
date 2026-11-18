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

  @override
  String get cancel => 'Anuluj';

  @override
  String get delete => 'Usuń';

  @override
  String get undo => 'Cofnij';

  @override
  String get eventMeal => 'Posiłek';

  @override
  String get eventPoop => 'Kupa';

  @override
  String get eventPee => 'Siku';

  @override
  String get eventWalk => 'Spacer';

  @override
  String get eventNote => 'Notatka';

  @override
  String get poopColorBrown => 'brązowa';

  @override
  String get poopColorDark => 'ciemna / czarna';

  @override
  String get poopColorYellow => 'żółta / pomarańczowa';

  @override
  String get poopColorGreen => 'zielona';

  @override
  String get poopColorGrey => 'szara / gliniasta';

  @override
  String get poopColorBloody => 'z krwią';

  @override
  String get bristol1 => 'twarde, oddzielne grudki';

  @override
  String get bristol2 => 'zbita, grudkowata';

  @override
  String get bristol3 => 'kształtna, z pęknięciami';

  @override
  String get bristol4 => 'gładka i miękka (norma)';

  @override
  String get bristol5 => 'miękkie kawałki';

  @override
  String get bristol6 => 'papkowata';

  @override
  String get bristol7 => 'wodnista';

  @override
  String gramsValue(int grams) {
    return '$grams g';
  }

  @override
  String minutesValue(int minutes) {
    return '$minutes min';
  }

  @override
  String bristolValue(int score) {
    return 'Bristol $score';
  }

  @override
  String get agoJustNow => 'przed chwilą';

  @override
  String agoMinutes(int minutes) {
    return '$minutes min temu';
  }

  @override
  String agoHours(int hours) {
    return '$hours h temu';
  }

  @override
  String agoDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dni temu',
      one: 'wczoraj',
    );
    return '$_temp0';
  }

  @override
  String get dayToday => 'Dziś';

  @override
  String get dayYesterday => 'Wczoraj';

  @override
  String get recentHeader => 'Ostatnio';

  @override
  String get recentNone => 'brak w ostatnich 7 dniach';

  @override
  String get todayTimelineHeader => 'Dzisiejsze wpisy';

  @override
  String get todayEmpty => 'Nic jeszcze dziś nie zapisano.';

  @override
  String get eventTimeLabel => 'Czas';

  @override
  String get eventNoteLabel => 'Notatka (opcjonalnie)';

  @override
  String get eventNoteRequired => 'Wpisz treść notatki';

  @override
  String get mealGramsLabel => 'Porcja w gramach';

  @override
  String get mealGramsInvalid => 'Podaj porcję od 1 do 5000 g';

  @override
  String get mealFoodLabel => 'Karma';

  @override
  String get walkDurationLabel => 'Czas spaceru w minutach';

  @override
  String get walkDurationInvalid => 'Podaj od 1 do 1440 minut';

  @override
  String get poopScoreLabel => 'Skala Bristol';

  @override
  String get poopColorLabel => 'Kolor';

  @override
  String get eventDeleted => 'Usunięto wpis';

  @override
  String get eventNotFound => 'Nie znaleziono wpisu.';

  @override
  String get editEventTitle => 'Edycja wpisu';

  @override
  String get historyEmpty => 'Brak wpisów.';

  @override
  String get historyFilterAll => 'Wszystkie';

  @override
  String get foodsEmpty => 'Nie dodano jeszcze żadnej karmy.';

  @override
  String get addFood => 'Dodaj karmę';

  @override
  String get editFood => 'Edytuj karmę';

  @override
  String get foodNameLabel => 'Nazwa';

  @override
  String get foodBrandLabel => 'Marka (opcjonalnie)';

  @override
  String get foodActive => 'W użyciu';

  @override
  String get foodArchivedHeader => 'Nieużywane';

  @override
  String eventAuthorTime(String time, String author) {
    return '$time · $author';
  }
}
