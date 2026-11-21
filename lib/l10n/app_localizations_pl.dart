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

  @override
  String get reminderFoodTitle => 'Kup karmę';

  @override
  String reminderFoodBody(String food, String kg) {
    return '$food: zostało ok. $kg kg.';
  }

  @override
  String reminderFoodBodyDays(String food, String kg, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dni',
      one: '1 dzień',
      zero: 'niecały dzień',
    );
    return '$food: zostało ok. $kg kg, czyli na $_temp0.';
  }

  @override
  String get ratingLabel => 'Ocena psa';

  @override
  String get ratingGood => 'Smakuje';

  @override
  String get ratingNeutral => 'Tak sobie';

  @override
  String get ratingBad => 'Nie smakuje';

  @override
  String get stockNoPurchases => 'brak zakupów';

  @override
  String get stockNoPace => 'brak danych o zużyciu';

  @override
  String get stockLow => 'Kończy się';

  @override
  String get stockUnknownFood => 'wybierz karmę przy posiłku';

  @override
  String get purchasesHeader => 'Zakupy';

  @override
  String get purchasesEmpty =>
      'Brak zakupów. Napoczęty worek możesz dodać jako zakup bez ceny.';

  @override
  String get addPurchase => 'Dodaj zakup';

  @override
  String get purchaseKgLabel => 'Ilość w kg';

  @override
  String get purchaseKgInvalid => 'Podaj ilość, np. 12 albo 1,5';

  @override
  String get purchasePriceLabel => 'Cena w zł (opcjonalnie)';

  @override
  String get purchasePriceInvalid => 'Podaj cenę, np. 249,99';

  @override
  String get purchaseDateLabel => 'Data';

  @override
  String get purchaseFoodRequired => 'Wybierz karmę';

  @override
  String get purchaseDeleted => 'Usunięto zakup';

  @override
  String get purchaseNoFoods => 'Najpierw dodaj karmę.';

  @override
  String get foodNotFound => 'Nie znaleziono karmy.';

  @override
  String get consumptionChartTitle => 'Zużycie w ostatnich 30 dniach (g)';

  @override
  String get settingsReminders => 'Przypomnienia';

  @override
  String get remindersFoodEnabled => 'Przypominaj o kupnie karmy';

  @override
  String get remindersTime => 'Godzina przypomnień';

  @override
  String get remindersInfo =>
      'Ustawienia dotyczą tylko tego telefonu. Przypomnienie przychodzi w dniu, w którym przy obecnym tempie jedzenia zapas spadnie poniżej progu.';

  @override
  String kgValue(String kg) {
    return '$kg kg';
  }

  @override
  String stockRemaining(String kg) {
    return 'zostało $kg kg';
  }

  @override
  String stockDaysLeft(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dni',
      one: '1 dzień',
      zero: 'mniej niż dzień',
    );
    return '~$_temp0';
  }

  @override
  String stockAverage(int grams) {
    return 'średnio $grams g dziennie';
  }

  @override
  String stockEnds(String date) {
    return 'koniec ok. $date';
  }

  @override
  String remindersThreshold(String kg) {
    return 'Gdy zostanie mniej niż $kg kg';
  }

  @override
  String reminderWeighTitle(String dog) {
    return 'Czas zważyć: $dog';
  }

  @override
  String reminderWeighBody(String kg, String date) {
    return 'Ostatni pomiar: $kg kg ($date).';
  }

  @override
  String get weightTitle => 'Waga';

  @override
  String get weightAdd => 'Dodaj pomiar';

  @override
  String get weightEdit => 'Edytuj pomiar';

  @override
  String get weightEmpty =>
      'Brak pomiarów. Dodaj pierwszy, żeby zobaczyć wykres.';

  @override
  String get weightKgLabel => 'Waga w kg';

  @override
  String get weightDayLabel => 'Data';

  @override
  String get weightDeleted => 'Usunięto pomiar';

  @override
  String get weightRange3m => '3M';

  @override
  String get weightRange6m => '6M';

  @override
  String get weightRange1y => '1R';

  @override
  String get weightRangeAll => 'Wszystko';

  @override
  String get weightChartTooFew => 'Za mało pomiarów w tym okresie.';

  @override
  String get weightHistoryHeader => 'Pomiary';

  @override
  String get remindersWeighEnabled => 'Przypominaj o ważeniu';

  @override
  String get remindersWeighInfo => 'Miesiąc po ostatnim pomiarze.';

  @override
  String get remindersFoodHeader => 'Karma';

  @override
  String get remindersWeighHeader => 'Waga';

  @override
  String weightChange(String change, String date) {
    return '$change kg od $date';
  }

  @override
  String reminderHealthSoonTitle(String name) {
    return 'Zbliża się: $name';
  }

  @override
  String reminderHealthDueTitle(String name) {
    return 'Dziś termin: $name';
  }

  @override
  String reminderHealthOverdueTitle(String name) {
    return 'Po terminie: $name';
  }

  @override
  String reminderHealthBody(String dog, String date) {
    return '$dog · termin $date';
  }

  @override
  String get healthVaccination => 'Szczepienia';

  @override
  String get healthDeworming => 'Odrobaczanie';

  @override
  String get healthTicks => 'Kleszcze i pchły';

  @override
  String get healthVet => 'Wizyty u weta';

  @override
  String get healthStatusOk => 'OK';

  @override
  String get healthStatusSoon => 'Wkrótce';

  @override
  String get healthStatusOverdue => 'Po terminie';

  @override
  String get healthNoEntries => 'Brak wpisów';

  @override
  String get healthNoNextDue => 'bez kolejnego terminu';

  @override
  String get healthAdd => 'Dodaj wpis';

  @override
  String get healthEdit => 'Edycja wpisu';

  @override
  String get healthOther => 'Inne';

  @override
  String get healthNameLabel => 'Nazwa';

  @override
  String get healthDateLabel => 'Data';

  @override
  String get healthNextDueLabel => 'Następny termin';

  @override
  String get healthNextDueNone => 'brak';

  @override
  String get healthNextDueClear => 'Usuń termin';

  @override
  String get healthTemplateLabel => 'Rodzaj';

  @override
  String get healthTypeLabel => 'Kategoria';

  @override
  String get healthEntryDeleted => 'Usunięto wpis';

  @override
  String get healthHistory => 'Historia';

  @override
  String get healthEntryNotFound => 'Nie znaleziono wpisu.';

  @override
  String get healthMandatory => 'obowiązkowe';

  @override
  String get settingsTemplates => 'Szablony zdrowotne';

  @override
  String get templateAdd => 'Dodaj szablon';

  @override
  String get templateEdit => 'Edytuj szablon';

  @override
  String get templateIntervalLabel => 'Co ile miesięcy (puste = bez terminu)';

  @override
  String get templateIntervalInvalid => 'Podaj od 1 do 60 miesięcy';

  @override
  String get templateMandatory => 'Obowiązkowe';

  @override
  String get templateActive => 'W użyciu';

  @override
  String get templateArchived => 'Nieużywane';

  @override
  String get templateNoInterval => 'bez stałego terminu';

  @override
  String get remindersHealthEnabled => 'Przypominaj o terminach zdrowotnych';

  @override
  String get remindersHealthHeader => 'Zdrowie';

  @override
  String templateInterval(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months miesiąca',
      many: '$months miesięcy',
      few: '$months miesiące',
      one: 'miesiąc',
    );
    return 'co $_temp0';
  }

  @override
  String remindersHealthDaysBefore(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dni',
      one: '1 dzień',
    );
    return '$_temp0 przed terminem (wizyty: dzień przed)';
  }

  @override
  String healthDueIn(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'za $days dni',
      one: 'jutro',
      zero: 'dziś',
    );
    return '$_temp0';
  }

  @override
  String healthOverdueBy(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days dni temu',
      one: 'wczoraj',
    );
    return '$_temp0';
  }

  @override
  String healthNextDue(String date) {
    return 'termin $date';
  }

  @override
  String healthAttentionBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count terminów wymaga uwagi',
      few: '$count terminy wymagają uwagi',
      one: '1 termin wymaga uwagi',
    );
    return '$_temp0';
  }
}
