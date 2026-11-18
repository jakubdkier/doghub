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
