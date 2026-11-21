import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('pl')];

  /// No description provided for @appTitle.
  ///
  /// In pl, this message translates to:
  /// **'DogHub'**
  String get appTitle;

  /// No description provided for @navToday.
  ///
  /// In pl, this message translates to:
  /// **'Dziś'**
  String get navToday;

  /// No description provided for @navHistory.
  ///
  /// In pl, this message translates to:
  /// **'Historia'**
  String get navHistory;

  /// No description provided for @navFood.
  ///
  /// In pl, this message translates to:
  /// **'Karma'**
  String get navFood;

  /// No description provided for @navHealth.
  ///
  /// In pl, this message translates to:
  /// **'Zdrowie'**
  String get navHealth;

  /// No description provided for @loginTagline.
  ///
  /// In pl, this message translates to:
  /// **'Wspólny dziennik Twojego psa'**
  String get loginTagline;

  /// No description provided for @loginWithGoogle.
  ///
  /// In pl, this message translates to:
  /// **'Zaloguj przez Google'**
  String get loginWithGoogle;

  /// No description provided for @loginError.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się zalogować. Spróbuj ponownie.'**
  String get loginError;

  /// No description provided for @signOut.
  ///
  /// In pl, this message translates to:
  /// **'Wyloguj'**
  String get signOut;

  /// No description provided for @comingSoon.
  ///
  /// In pl, this message translates to:
  /// **'Wkrótce'**
  String get comingSoon;

  /// No description provided for @genericError.
  ///
  /// In pl, this message translates to:
  /// **'Coś poszło nie tak.'**
  String get genericError;

  /// No description provided for @fieldRequired.
  ///
  /// In pl, this message translates to:
  /// **'To pole jest wymagane'**
  String get fieldRequired;

  /// No description provided for @save.
  ///
  /// In pl, this message translates to:
  /// **'Zapisz'**
  String get save;

  /// No description provided for @splashError.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się wczytać danych. Sprawdź połączenie i uruchom aplikację ponownie.'**
  String get splashError;

  /// No description provided for @onboardingHouseholdTitle.
  ///
  /// In pl, this message translates to:
  /// **'Wspólny dom'**
  String get onboardingHouseholdTitle;

  /// No description provided for @onboardingHouseholdIntro.
  ///
  /// In pl, this message translates to:
  /// **'Dziennik psa prowadzicie razem w ramach jednego domu. Utwórz nowy albo dołącz kodem od domownika.'**
  String get onboardingHouseholdIntro;

  /// No description provided for @createHouseholdHeader.
  ///
  /// In pl, this message translates to:
  /// **'Utwórz nowy dom'**
  String get createHouseholdHeader;

  /// No description provided for @householdNameLabel.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa domu'**
  String get householdNameLabel;

  /// No description provided for @householdNameDefault.
  ///
  /// In pl, this message translates to:
  /// **'Nasz dom'**
  String get householdNameDefault;

  /// No description provided for @createHouseholdButton.
  ///
  /// In pl, this message translates to:
  /// **'Utwórz'**
  String get createHouseholdButton;

  /// No description provided for @joinHouseholdHeader.
  ///
  /// In pl, this message translates to:
  /// **'Mam kod zaproszenia'**
  String get joinHouseholdHeader;

  /// No description provided for @inviteCodeLabel.
  ///
  /// In pl, this message translates to:
  /// **'Kod zaproszenia'**
  String get inviteCodeLabel;

  /// No description provided for @joinButton.
  ///
  /// In pl, this message translates to:
  /// **'Dołącz'**
  String get joinButton;

  /// No description provided for @joinErrorInvalidCode.
  ///
  /// In pl, this message translates to:
  /// **'Kod ma 6 znaków (litery i cyfry).'**
  String get joinErrorInvalidCode;

  /// No description provided for @joinErrorNotFound.
  ///
  /// In pl, this message translates to:
  /// **'Nie ma takiego kodu.'**
  String get joinErrorNotFound;

  /// No description provided for @joinErrorExpired.
  ///
  /// In pl, this message translates to:
  /// **'Kod wygasł. Poproś domownika o nowy.'**
  String get joinErrorExpired;

  /// No description provided for @joinErrorOffline.
  ///
  /// In pl, this message translates to:
  /// **'Brak połączenia z internetem.'**
  String get joinErrorOffline;

  /// No description provided for @joinErrorDenied.
  ///
  /// In pl, this message translates to:
  /// **'Nie udało się dołączyć. Poproś o nowy kod.'**
  String get joinErrorDenied;

  /// No description provided for @onboardingDogTitle.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj psa'**
  String get onboardingDogTitle;

  /// No description provided for @dogNameLabel.
  ///
  /// In pl, this message translates to:
  /// **'Imię'**
  String get dogNameLabel;

  /// No description provided for @dogBreedLabel.
  ///
  /// In pl, this message translates to:
  /// **'Rasa (opcjonalnie)'**
  String get dogBreedLabel;

  /// No description provided for @dogBirthDateLabel.
  ///
  /// In pl, this message translates to:
  /// **'Data urodzenia (opcjonalnie)'**
  String get dogBirthDateLabel;

  /// No description provided for @dogWeightLabel.
  ///
  /// In pl, this message translates to:
  /// **'Waga startowa w kg (opcjonalnie)'**
  String get dogWeightLabel;

  /// No description provided for @dogWeightInvalid.
  ///
  /// In pl, this message translates to:
  /// **'Podaj wagę, np. 12,5'**
  String get dogWeightInvalid;

  /// No description provided for @settingsTitle.
  ///
  /// In pl, this message translates to:
  /// **'Ustawienia'**
  String get settingsTitle;

  /// No description provided for @settingsHousehold.
  ///
  /// In pl, this message translates to:
  /// **'Dom i domownicy'**
  String get settingsHousehold;

  /// No description provided for @householdMembers.
  ///
  /// In pl, this message translates to:
  /// **'Domownicy'**
  String get householdMembers;

  /// No description provided for @memberYou.
  ///
  /// In pl, this message translates to:
  /// **'{name} (Ty)'**
  String memberYou(String name);

  /// No description provided for @inviteHeader.
  ///
  /// In pl, this message translates to:
  /// **'Zaproś domownika'**
  String get inviteHeader;

  /// No description provided for @inviteDescription.
  ///
  /// In pl, this message translates to:
  /// **'Kod jest ważny 24 godziny. Domownik wpisuje go po zalogowaniu się w aplikacji.'**
  String get inviteDescription;

  /// No description provided for @inviteGenerate.
  ///
  /// In pl, this message translates to:
  /// **'Wygeneruj kod'**
  String get inviteGenerate;

  /// No description provided for @inviteValidUntil.
  ///
  /// In pl, this message translates to:
  /// **'Ważny do {date}'**
  String inviteValidUntil(String date);

  /// No description provided for @inviteCopy.
  ///
  /// In pl, this message translates to:
  /// **'Kopiuj kod'**
  String get inviteCopy;

  /// No description provided for @inviteCopied.
  ///
  /// In pl, this message translates to:
  /// **'Skopiowano kod'**
  String get inviteCopied;

  /// No description provided for @inviteRevoke.
  ///
  /// In pl, this message translates to:
  /// **'Unieważnij'**
  String get inviteRevoke;

  /// No description provided for @inviteErrorOffline.
  ///
  /// In pl, this message translates to:
  /// **'Wygenerowanie kodu wymaga połączenia z internetem.'**
  String get inviteErrorOffline;

  /// No description provided for @cancel.
  ///
  /// In pl, this message translates to:
  /// **'Anuluj'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In pl, this message translates to:
  /// **'Usuń'**
  String get delete;

  /// No description provided for @undo.
  ///
  /// In pl, this message translates to:
  /// **'Cofnij'**
  String get undo;

  /// No description provided for @eventMeal.
  ///
  /// In pl, this message translates to:
  /// **'Posiłek'**
  String get eventMeal;

  /// No description provided for @eventPoop.
  ///
  /// In pl, this message translates to:
  /// **'Kupa'**
  String get eventPoop;

  /// No description provided for @eventPee.
  ///
  /// In pl, this message translates to:
  /// **'Siku'**
  String get eventPee;

  /// No description provided for @eventWalk.
  ///
  /// In pl, this message translates to:
  /// **'Spacer'**
  String get eventWalk;

  /// No description provided for @eventNote.
  ///
  /// In pl, this message translates to:
  /// **'Notatka'**
  String get eventNote;

  /// No description provided for @poopColorBrown.
  ///
  /// In pl, this message translates to:
  /// **'brązowa'**
  String get poopColorBrown;

  /// No description provided for @poopColorDark.
  ///
  /// In pl, this message translates to:
  /// **'ciemna / czarna'**
  String get poopColorDark;

  /// No description provided for @poopColorYellow.
  ///
  /// In pl, this message translates to:
  /// **'żółta / pomarańczowa'**
  String get poopColorYellow;

  /// No description provided for @poopColorGreen.
  ///
  /// In pl, this message translates to:
  /// **'zielona'**
  String get poopColorGreen;

  /// No description provided for @poopColorGrey.
  ///
  /// In pl, this message translates to:
  /// **'szara / gliniasta'**
  String get poopColorGrey;

  /// No description provided for @poopColorBloody.
  ///
  /// In pl, this message translates to:
  /// **'z krwią'**
  String get poopColorBloody;

  /// No description provided for @bristol1.
  ///
  /// In pl, this message translates to:
  /// **'twarde, oddzielne grudki'**
  String get bristol1;

  /// No description provided for @bristol2.
  ///
  /// In pl, this message translates to:
  /// **'zbita, grudkowata'**
  String get bristol2;

  /// No description provided for @bristol3.
  ///
  /// In pl, this message translates to:
  /// **'kształtna, z pęknięciami'**
  String get bristol3;

  /// No description provided for @bristol4.
  ///
  /// In pl, this message translates to:
  /// **'gładka i miękka (norma)'**
  String get bristol4;

  /// No description provided for @bristol5.
  ///
  /// In pl, this message translates to:
  /// **'miękkie kawałki'**
  String get bristol5;

  /// No description provided for @bristol6.
  ///
  /// In pl, this message translates to:
  /// **'papkowata'**
  String get bristol6;

  /// No description provided for @bristol7.
  ///
  /// In pl, this message translates to:
  /// **'wodnista'**
  String get bristol7;

  /// No description provided for @gramsValue.
  ///
  /// In pl, this message translates to:
  /// **'{grams} g'**
  String gramsValue(int grams);

  /// No description provided for @minutesValue.
  ///
  /// In pl, this message translates to:
  /// **'{minutes} min'**
  String minutesValue(int minutes);

  /// No description provided for @bristolValue.
  ///
  /// In pl, this message translates to:
  /// **'Bristol {score}'**
  String bristolValue(int score);

  /// No description provided for @agoJustNow.
  ///
  /// In pl, this message translates to:
  /// **'przed chwilą'**
  String get agoJustNow;

  /// No description provided for @agoMinutes.
  ///
  /// In pl, this message translates to:
  /// **'{minutes} min temu'**
  String agoMinutes(int minutes);

  /// No description provided for @agoHours.
  ///
  /// In pl, this message translates to:
  /// **'{hours} h temu'**
  String agoHours(int hours);

  /// No description provided for @agoDays.
  ///
  /// In pl, this message translates to:
  /// **'{days, plural, =1{wczoraj} other{{days} dni temu}}'**
  String agoDays(int days);

  /// No description provided for @dayToday.
  ///
  /// In pl, this message translates to:
  /// **'Dziś'**
  String get dayToday;

  /// No description provided for @dayYesterday.
  ///
  /// In pl, this message translates to:
  /// **'Wczoraj'**
  String get dayYesterday;

  /// No description provided for @recentHeader.
  ///
  /// In pl, this message translates to:
  /// **'Ostatnio'**
  String get recentHeader;

  /// No description provided for @recentNone.
  ///
  /// In pl, this message translates to:
  /// **'brak w ostatnich 7 dniach'**
  String get recentNone;

  /// No description provided for @todayTimelineHeader.
  ///
  /// In pl, this message translates to:
  /// **'Dzisiejsze wpisy'**
  String get todayTimelineHeader;

  /// No description provided for @todayEmpty.
  ///
  /// In pl, this message translates to:
  /// **'Nic jeszcze dziś nie zapisano.'**
  String get todayEmpty;

  /// No description provided for @eventTimeLabel.
  ///
  /// In pl, this message translates to:
  /// **'Czas'**
  String get eventTimeLabel;

  /// No description provided for @eventNoteLabel.
  ///
  /// In pl, this message translates to:
  /// **'Notatka (opcjonalnie)'**
  String get eventNoteLabel;

  /// No description provided for @eventNoteRequired.
  ///
  /// In pl, this message translates to:
  /// **'Wpisz treść notatki'**
  String get eventNoteRequired;

  /// No description provided for @mealGramsLabel.
  ///
  /// In pl, this message translates to:
  /// **'Porcja w gramach'**
  String get mealGramsLabel;

  /// No description provided for @mealGramsInvalid.
  ///
  /// In pl, this message translates to:
  /// **'Podaj porcję od 1 do 5000 g'**
  String get mealGramsInvalid;

  /// No description provided for @mealFoodLabel.
  ///
  /// In pl, this message translates to:
  /// **'Karma'**
  String get mealFoodLabel;

  /// No description provided for @walkDurationLabel.
  ///
  /// In pl, this message translates to:
  /// **'Czas spaceru w minutach'**
  String get walkDurationLabel;

  /// No description provided for @walkDurationInvalid.
  ///
  /// In pl, this message translates to:
  /// **'Podaj od 1 do 1440 minut'**
  String get walkDurationInvalid;

  /// No description provided for @poopScoreLabel.
  ///
  /// In pl, this message translates to:
  /// **'Skala Bristol'**
  String get poopScoreLabel;

  /// No description provided for @poopColorLabel.
  ///
  /// In pl, this message translates to:
  /// **'Kolor'**
  String get poopColorLabel;

  /// No description provided for @eventDeleted.
  ///
  /// In pl, this message translates to:
  /// **'Usunięto wpis'**
  String get eventDeleted;

  /// No description provided for @eventNotFound.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono wpisu.'**
  String get eventNotFound;

  /// No description provided for @editEventTitle.
  ///
  /// In pl, this message translates to:
  /// **'Edycja wpisu'**
  String get editEventTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In pl, this message translates to:
  /// **'Brak wpisów.'**
  String get historyEmpty;

  /// No description provided for @historyFilterAll.
  ///
  /// In pl, this message translates to:
  /// **'Wszystkie'**
  String get historyFilterAll;

  /// No description provided for @foodsEmpty.
  ///
  /// In pl, this message translates to:
  /// **'Nie dodano jeszcze żadnej karmy.'**
  String get foodsEmpty;

  /// No description provided for @addFood.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj karmę'**
  String get addFood;

  /// No description provided for @editFood.
  ///
  /// In pl, this message translates to:
  /// **'Edytuj karmę'**
  String get editFood;

  /// No description provided for @foodNameLabel.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa'**
  String get foodNameLabel;

  /// No description provided for @foodBrandLabel.
  ///
  /// In pl, this message translates to:
  /// **'Marka (opcjonalnie)'**
  String get foodBrandLabel;

  /// No description provided for @foodActive.
  ///
  /// In pl, this message translates to:
  /// **'W użyciu'**
  String get foodActive;

  /// No description provided for @foodArchivedHeader.
  ///
  /// In pl, this message translates to:
  /// **'Nieużywane'**
  String get foodArchivedHeader;

  /// No description provided for @eventAuthorTime.
  ///
  /// In pl, this message translates to:
  /// **'{time} · {author}'**
  String eventAuthorTime(String time, String author);

  /// No description provided for @reminderFoodTitle.
  ///
  /// In pl, this message translates to:
  /// **'Kup karmę'**
  String get reminderFoodTitle;

  /// No description provided for @reminderFoodBody.
  ///
  /// In pl, this message translates to:
  /// **'{food}: zostało ok. {kg} kg.'**
  String reminderFoodBody(String food, String kg);

  /// No description provided for @reminderFoodBodyDays.
  ///
  /// In pl, this message translates to:
  /// **'{food}: zostało ok. {kg} kg, czyli na {days, plural, =0{niecały dzień} =1{1 dzień} other{{days} dni}}.'**
  String reminderFoodBodyDays(String food, String kg, int days);

  /// No description provided for @ratingLabel.
  ///
  /// In pl, this message translates to:
  /// **'Ocena psa'**
  String get ratingLabel;

  /// No description provided for @ratingGood.
  ///
  /// In pl, this message translates to:
  /// **'Smakuje'**
  String get ratingGood;

  /// No description provided for @ratingNeutral.
  ///
  /// In pl, this message translates to:
  /// **'Tak sobie'**
  String get ratingNeutral;

  /// No description provided for @ratingBad.
  ///
  /// In pl, this message translates to:
  /// **'Nie smakuje'**
  String get ratingBad;

  /// No description provided for @stockNoPurchases.
  ///
  /// In pl, this message translates to:
  /// **'brak zakupów'**
  String get stockNoPurchases;

  /// No description provided for @stockNoPace.
  ///
  /// In pl, this message translates to:
  /// **'brak danych o zużyciu'**
  String get stockNoPace;

  /// No description provided for @stockLow.
  ///
  /// In pl, this message translates to:
  /// **'Kończy się'**
  String get stockLow;

  /// No description provided for @stockUnknownFood.
  ///
  /// In pl, this message translates to:
  /// **'wybierz karmę przy posiłku'**
  String get stockUnknownFood;

  /// No description provided for @purchasesHeader.
  ///
  /// In pl, this message translates to:
  /// **'Zakupy'**
  String get purchasesHeader;

  /// No description provided for @purchasesEmpty.
  ///
  /// In pl, this message translates to:
  /// **'Brak zakupów. Napoczęty worek możesz dodać jako zakup bez ceny.'**
  String get purchasesEmpty;

  /// No description provided for @addPurchase.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj zakup'**
  String get addPurchase;

  /// No description provided for @purchaseKgLabel.
  ///
  /// In pl, this message translates to:
  /// **'Ilość w kg'**
  String get purchaseKgLabel;

  /// No description provided for @purchaseKgInvalid.
  ///
  /// In pl, this message translates to:
  /// **'Podaj ilość, np. 12 albo 1,5'**
  String get purchaseKgInvalid;

  /// No description provided for @purchasePriceLabel.
  ///
  /// In pl, this message translates to:
  /// **'Cena w zł (opcjonalnie)'**
  String get purchasePriceLabel;

  /// No description provided for @purchasePriceInvalid.
  ///
  /// In pl, this message translates to:
  /// **'Podaj cenę, np. 249,99'**
  String get purchasePriceInvalid;

  /// No description provided for @purchaseDateLabel.
  ///
  /// In pl, this message translates to:
  /// **'Data'**
  String get purchaseDateLabel;

  /// No description provided for @purchaseFoodRequired.
  ///
  /// In pl, this message translates to:
  /// **'Wybierz karmę'**
  String get purchaseFoodRequired;

  /// No description provided for @purchaseDeleted.
  ///
  /// In pl, this message translates to:
  /// **'Usunięto zakup'**
  String get purchaseDeleted;

  /// No description provided for @purchaseNoFoods.
  ///
  /// In pl, this message translates to:
  /// **'Najpierw dodaj karmę.'**
  String get purchaseNoFoods;

  /// No description provided for @foodNotFound.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono karmy.'**
  String get foodNotFound;

  /// No description provided for @consumptionChartTitle.
  ///
  /// In pl, this message translates to:
  /// **'Zużycie w ostatnich 30 dniach (g)'**
  String get consumptionChartTitle;

  /// No description provided for @settingsReminders.
  ///
  /// In pl, this message translates to:
  /// **'Przypomnienia'**
  String get settingsReminders;

  /// No description provided for @remindersFoodEnabled.
  ///
  /// In pl, this message translates to:
  /// **'Przypominaj o kupnie karmy'**
  String get remindersFoodEnabled;

  /// No description provided for @remindersTime.
  ///
  /// In pl, this message translates to:
  /// **'Godzina przypomnień'**
  String get remindersTime;

  /// No description provided for @remindersInfo.
  ///
  /// In pl, this message translates to:
  /// **'Ustawienia dotyczą tylko tego telefonu. Przypomnienie przychodzi w dniu, w którym przy obecnym tempie jedzenia zapas spadnie poniżej progu.'**
  String get remindersInfo;

  /// No description provided for @kgValue.
  ///
  /// In pl, this message translates to:
  /// **'{kg} kg'**
  String kgValue(String kg);

  /// No description provided for @stockRemaining.
  ///
  /// In pl, this message translates to:
  /// **'zostało {kg} kg'**
  String stockRemaining(String kg);

  /// No description provided for @stockDaysLeft.
  ///
  /// In pl, this message translates to:
  /// **'~{days, plural, =0{mniej niż dzień} =1{1 dzień} other{{days} dni}}'**
  String stockDaysLeft(int days);

  /// No description provided for @stockAverage.
  ///
  /// In pl, this message translates to:
  /// **'średnio {grams} g dziennie'**
  String stockAverage(int grams);

  /// No description provided for @stockEnds.
  ///
  /// In pl, this message translates to:
  /// **'koniec ok. {date}'**
  String stockEnds(String date);

  /// No description provided for @remindersThreshold.
  ///
  /// In pl, this message translates to:
  /// **'Gdy zostanie mniej niż {kg} kg'**
  String remindersThreshold(String kg);

  /// No description provided for @reminderWeighTitle.
  ///
  /// In pl, this message translates to:
  /// **'Czas zważyć: {dog}'**
  String reminderWeighTitle(String dog);

  /// No description provided for @reminderWeighBody.
  ///
  /// In pl, this message translates to:
  /// **'Ostatni pomiar: {kg} kg ({date}).'**
  String reminderWeighBody(String kg, String date);

  /// No description provided for @weightTitle.
  ///
  /// In pl, this message translates to:
  /// **'Waga'**
  String get weightTitle;

  /// No description provided for @weightAdd.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj pomiar'**
  String get weightAdd;

  /// No description provided for @weightEdit.
  ///
  /// In pl, this message translates to:
  /// **'Edytuj pomiar'**
  String get weightEdit;

  /// No description provided for @weightEmpty.
  ///
  /// In pl, this message translates to:
  /// **'Brak pomiarów. Dodaj pierwszy, żeby zobaczyć wykres.'**
  String get weightEmpty;

  /// No description provided for @weightKgLabel.
  ///
  /// In pl, this message translates to:
  /// **'Waga w kg'**
  String get weightKgLabel;

  /// No description provided for @weightDayLabel.
  ///
  /// In pl, this message translates to:
  /// **'Data'**
  String get weightDayLabel;

  /// No description provided for @weightDeleted.
  ///
  /// In pl, this message translates to:
  /// **'Usunięto pomiar'**
  String get weightDeleted;

  /// No description provided for @weightRange3m.
  ///
  /// In pl, this message translates to:
  /// **'3M'**
  String get weightRange3m;

  /// No description provided for @weightRange6m.
  ///
  /// In pl, this message translates to:
  /// **'6M'**
  String get weightRange6m;

  /// No description provided for @weightRange1y.
  ///
  /// In pl, this message translates to:
  /// **'1R'**
  String get weightRange1y;

  /// No description provided for @weightRangeAll.
  ///
  /// In pl, this message translates to:
  /// **'Wszystko'**
  String get weightRangeAll;

  /// No description provided for @weightChartTooFew.
  ///
  /// In pl, this message translates to:
  /// **'Za mało pomiarów w tym okresie.'**
  String get weightChartTooFew;

  /// No description provided for @weightHistoryHeader.
  ///
  /// In pl, this message translates to:
  /// **'Pomiary'**
  String get weightHistoryHeader;

  /// No description provided for @remindersWeighEnabled.
  ///
  /// In pl, this message translates to:
  /// **'Przypominaj o ważeniu'**
  String get remindersWeighEnabled;

  /// No description provided for @remindersWeighInfo.
  ///
  /// In pl, this message translates to:
  /// **'Miesiąc po ostatnim pomiarze.'**
  String get remindersWeighInfo;

  /// No description provided for @remindersFoodHeader.
  ///
  /// In pl, this message translates to:
  /// **'Karma'**
  String get remindersFoodHeader;

  /// No description provided for @remindersWeighHeader.
  ///
  /// In pl, this message translates to:
  /// **'Waga'**
  String get remindersWeighHeader;

  /// No description provided for @weightChange.
  ///
  /// In pl, this message translates to:
  /// **'{change} kg od {date}'**
  String weightChange(String change, String date);

  /// No description provided for @reminderHealthSoonTitle.
  ///
  /// In pl, this message translates to:
  /// **'Zbliża się: {name}'**
  String reminderHealthSoonTitle(String name);

  /// No description provided for @reminderHealthDueTitle.
  ///
  /// In pl, this message translates to:
  /// **'Dziś termin: {name}'**
  String reminderHealthDueTitle(String name);

  /// No description provided for @reminderHealthOverdueTitle.
  ///
  /// In pl, this message translates to:
  /// **'Po terminie: {name}'**
  String reminderHealthOverdueTitle(String name);

  /// No description provided for @reminderHealthBody.
  ///
  /// In pl, this message translates to:
  /// **'{dog} · termin {date}'**
  String reminderHealthBody(String dog, String date);

  /// No description provided for @healthVaccination.
  ///
  /// In pl, this message translates to:
  /// **'Szczepienia'**
  String get healthVaccination;

  /// No description provided for @healthDeworming.
  ///
  /// In pl, this message translates to:
  /// **'Odrobaczanie'**
  String get healthDeworming;

  /// No description provided for @healthTicks.
  ///
  /// In pl, this message translates to:
  /// **'Kleszcze i pchły'**
  String get healthTicks;

  /// No description provided for @healthVet.
  ///
  /// In pl, this message translates to:
  /// **'Wizyty u weta'**
  String get healthVet;

  /// No description provided for @healthStatusOk.
  ///
  /// In pl, this message translates to:
  /// **'OK'**
  String get healthStatusOk;

  /// No description provided for @healthStatusSoon.
  ///
  /// In pl, this message translates to:
  /// **'Wkrótce'**
  String get healthStatusSoon;

  /// No description provided for @healthStatusOverdue.
  ///
  /// In pl, this message translates to:
  /// **'Po terminie'**
  String get healthStatusOverdue;

  /// No description provided for @healthNoEntries.
  ///
  /// In pl, this message translates to:
  /// **'Brak wpisów'**
  String get healthNoEntries;

  /// No description provided for @healthNoNextDue.
  ///
  /// In pl, this message translates to:
  /// **'bez kolejnego terminu'**
  String get healthNoNextDue;

  /// No description provided for @healthAdd.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj wpis'**
  String get healthAdd;

  /// No description provided for @healthEdit.
  ///
  /// In pl, this message translates to:
  /// **'Edycja wpisu'**
  String get healthEdit;

  /// No description provided for @healthOther.
  ///
  /// In pl, this message translates to:
  /// **'Inne'**
  String get healthOther;

  /// No description provided for @healthNameLabel.
  ///
  /// In pl, this message translates to:
  /// **'Nazwa'**
  String get healthNameLabel;

  /// No description provided for @healthDateLabel.
  ///
  /// In pl, this message translates to:
  /// **'Data'**
  String get healthDateLabel;

  /// No description provided for @healthNextDueLabel.
  ///
  /// In pl, this message translates to:
  /// **'Następny termin'**
  String get healthNextDueLabel;

  /// No description provided for @healthNextDueNone.
  ///
  /// In pl, this message translates to:
  /// **'brak'**
  String get healthNextDueNone;

  /// No description provided for @healthNextDueClear.
  ///
  /// In pl, this message translates to:
  /// **'Usuń termin'**
  String get healthNextDueClear;

  /// No description provided for @healthTemplateLabel.
  ///
  /// In pl, this message translates to:
  /// **'Rodzaj'**
  String get healthTemplateLabel;

  /// No description provided for @healthTypeLabel.
  ///
  /// In pl, this message translates to:
  /// **'Kategoria'**
  String get healthTypeLabel;

  /// No description provided for @healthEntryDeleted.
  ///
  /// In pl, this message translates to:
  /// **'Usunięto wpis'**
  String get healthEntryDeleted;

  /// No description provided for @healthHistory.
  ///
  /// In pl, this message translates to:
  /// **'Historia'**
  String get healthHistory;

  /// No description provided for @healthEntryNotFound.
  ///
  /// In pl, this message translates to:
  /// **'Nie znaleziono wpisu.'**
  String get healthEntryNotFound;

  /// No description provided for @healthMandatory.
  ///
  /// In pl, this message translates to:
  /// **'obowiązkowe'**
  String get healthMandatory;

  /// No description provided for @settingsTemplates.
  ///
  /// In pl, this message translates to:
  /// **'Szablony zdrowotne'**
  String get settingsTemplates;

  /// No description provided for @templateAdd.
  ///
  /// In pl, this message translates to:
  /// **'Dodaj szablon'**
  String get templateAdd;

  /// No description provided for @templateEdit.
  ///
  /// In pl, this message translates to:
  /// **'Edytuj szablon'**
  String get templateEdit;

  /// No description provided for @templateIntervalLabel.
  ///
  /// In pl, this message translates to:
  /// **'Co ile miesięcy (puste = bez terminu)'**
  String get templateIntervalLabel;

  /// No description provided for @templateIntervalInvalid.
  ///
  /// In pl, this message translates to:
  /// **'Podaj od 1 do 60 miesięcy'**
  String get templateIntervalInvalid;

  /// No description provided for @templateMandatory.
  ///
  /// In pl, this message translates to:
  /// **'Obowiązkowe'**
  String get templateMandatory;

  /// No description provided for @templateActive.
  ///
  /// In pl, this message translates to:
  /// **'W użyciu'**
  String get templateActive;

  /// No description provided for @templateArchived.
  ///
  /// In pl, this message translates to:
  /// **'Nieużywane'**
  String get templateArchived;

  /// No description provided for @templateNoInterval.
  ///
  /// In pl, this message translates to:
  /// **'bez stałego terminu'**
  String get templateNoInterval;

  /// No description provided for @remindersHealthEnabled.
  ///
  /// In pl, this message translates to:
  /// **'Przypominaj o terminach zdrowotnych'**
  String get remindersHealthEnabled;

  /// No description provided for @remindersHealthHeader.
  ///
  /// In pl, this message translates to:
  /// **'Zdrowie'**
  String get remindersHealthHeader;

  /// No description provided for @templateInterval.
  ///
  /// In pl, this message translates to:
  /// **'co {months, plural, =1{miesiąc} few{{months} miesiące} many{{months} miesięcy} other{{months} miesiąca}}'**
  String templateInterval(int months);

  /// No description provided for @remindersHealthDaysBefore.
  ///
  /// In pl, this message translates to:
  /// **'{days, plural, =1{1 dzień} other{{days} dni}} przed terminem (wizyty: dzień przed)'**
  String remindersHealthDaysBefore(int days);

  /// No description provided for @healthDueIn.
  ///
  /// In pl, this message translates to:
  /// **'{days, plural, =0{dziś} =1{jutro} other{za {days} dni}}'**
  String healthDueIn(int days);

  /// No description provided for @healthOverdueBy.
  ///
  /// In pl, this message translates to:
  /// **'{days, plural, =1{wczoraj} other{{days} dni temu}}'**
  String healthOverdueBy(int days);

  /// No description provided for @healthNextDue.
  ///
  /// In pl, this message translates to:
  /// **'termin {date}'**
  String healthNextDue(String date);

  /// No description provided for @healthAttentionBanner.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, =1{1 termin wymaga uwagi} few{{count} terminy wymagają uwagi} other{{count} terminów wymaga uwagi}}'**
  String healthAttentionBanner(int count);

  /// No description provided for @widgetFood.
  ///
  /// In pl, this message translates to:
  /// **'Karma: {stock}'**
  String widgetFood(String stock);

  /// No description provided for @widgetHealthOverdue.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, =1{1 termin po terminie} few{{count} terminy po terminie} other{{count} terminów po terminie}}'**
  String widgetHealthOverdue(int count);

  /// No description provided for @widgetHealthSoon.
  ///
  /// In pl, this message translates to:
  /// **'{count, plural, =1{1 termin wkrótce} few{{count} terminy wkrótce} other{{count} terminów wkrótce}}'**
  String widgetHealthSoon(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
