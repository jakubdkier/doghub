# Dog App – plan MVP

Aplikacja mobilna Flutter (Android + iOS) do prowadzenia dziennika psa we wspólnym
household (2 osoby), z modelem danych od początku gotowym na wiele psów.

## Decyzje

- **Backend:** Firebase w darmowym planie Spark: Firestore (offline sync), Auth (Google).
  Bez Cloud Functions, Cloud Storage i planu Blaze.
- **Projekty Firebase:** dev = `dog-app-dev-8f3dc`, prod = (do utworzenia).
  Firestore `(default)` w `europe-central2`.
- **Bez zdjęć na start** (Cloud Storage wymaga Blaze).
- **Przypomnienia:** lokalne powiadomienia (flutter_local_notifications); prognoza karmy liczona w apce.
- **iOS:** na razie bez płatnego konta Apple Developer; rozwój i testy na Androidzie.
  Sign in with Apple odłożone.

## Funkcje MVP

- **Szybkie wpisy:** posiłek (karma + gramy), kupa (skala Bristol 1–7, kolor), siku, spacer,
  notatka; przy każdym wpisie zapisywane jest, kto go dodał. Widget na ekranie głównym.
- **Karma:** nazwa, marka, ocena psa (dobra / neutralna / zła); zakupy (kg, cena);
  stan = zakupy − posiłki; alert "kup karmę" na X dni przed końcem na podstawie średniego zużycia.
- **Waga psa** z wykresem.
- **Zdrowie:** szczepienia (konfigurowalne szablony; wścieklizna obowiązkowa w PL), odrobaczanie,
  kleszcze, wizyty u weta z przypomnieniem o następnym terminie.

**Na później:** zdjęcia, alerty anomalii (brak kupy przez 24 h, spadek wagi), korelacja
karma↔kupa, raport PDF dla weta, dokumenty, leki, spacery z GPS, koszty.

## Model danych Firestore

```
households/{id}            members: [uid…], name
  dogs/{dogId}             name, birthDate, breed
    events/{id}            type, at, createdAt, by, foodId?, grams?,
                           poopScore?, poopColor?, durationMin?, note?, deleted
    weights/{id}           kg, at, by
    health/{id}            type, templateId?, date, nextDue, note
    foods/{id}             name, brand, rating, active
    purchases/{id}         foodId, kg, price, at
invites/{code}             householdId, expiresAt, createdBy
```

- **Bez dokumentu `stock` i bez transakcji:** transakcje Firestore nie działają offline.
  Stan karmy i średnie dzienne zużycie (ostatnie 14 dni) liczy apka z danych w cache.
- **`at`** to czas zdarzenia z urządzenia (edytowalny, używany do sortowania i zapytań).
  **`createdAt`** to `serverTimestamp()` (audyt; offline ma wartość null do czasu synchronizacji).
- **`deleted`** to soft delete, który umożliwia "cofnij".
- **Zaproszenia:** zalogowany użytkownik może odczytać `invites/{code}`; na household może
  dopisać tylko siebie do `members`, jeśli w zapisie poda kod weryfikowany przez `get()`.

### Security Rules

- Odczyt i zapis `households/{h}` oraz wszystkich podkolekcji tylko dla `request.auth.uid in members`.
- Pole `by` przy zapisie musi być równe `request.auth.uid`.
- Reguły testowane w emulatorze (`@firebase/rules-unit-testing`).

## Ekrany

- **Onboarding:** logowanie Google, potem "Utwórz household" albo "Dołącz kodem", potem
  "Dodaj psa" (imię, data urodzenia, rasa, waga startowa).
- **Dziś:** przełącznik psa (przy jednym psie ukryty); kafle z ostatnim posiłkiem, kupą
  i spacerem ("2h temu") oraz stanem karmy ("~9 dni"); pasek szybkich akcji; oś czasu
  dzisiejszych wpisów z autorem (swipe usuwa wpis, snackbar pozwala cofnąć); banery przypomnień.
- **Arkusz szybkiego wpisu (bottom sheet):**
  - posiłek: domyślnie ostatnia karma i ostatnia porcja,
  - kupa: duże przyciski skali 1–7 i chipy z kolorem,
  - spacer: chipy czasu (15/30/45/60),
  - wspólne dla wszystkich: czas (domyślnie teraz) i notatka.
- **Historia:** wpisy pogrupowane po dniach, filtr typów, przewijanie w nieskończoność, tap otwiera edycję.
- **Karma:** lista karm z oceną; karta stanu (zostało X kg, średnio Y g/dzień, przewidywany koniec);
  szczegóły karmy z zakupami i wykresem zużycia; dodawanie zakupu.
- **Zdrowie:** sekcje z najbliższym terminem i statusem (OK / wkrótce / po terminie);
  dodawanie wpisu z szablonu (`nextDue` wyliczany, do edycji); waga z wykresem (3M/6M/1R/wszystko).
- **Ustawienia:** profil psa, członkowie i kod zaproszenia, szablony zdrowotne,
  przypomnienia (próg dni dla karmy, godzina powiadomień), wyloguj.

## Nawigacja (go_router)

```
/login
/onboarding/household
/onboarding/dog
/                       ShellRoute (BottomNav: Dziś, Historia, Karma, Zdrowie)
  /today
  /history
  /history/event/:id
  /food
  /food/:foodId
  /food/purchase/new
  /health
  /health/new
  /health/weight
/settings
/settings/household
/settings/templates
/quick-add?type=…       deep link z widgetu i powiadomień
```

Redirect: brak usera prowadzi do `/login`, brak household lub psa do odpowiedniego kroku onboardingu.

## Struktura projektu

```
lib/
├── main_dev.dart / main_prod.dart
├── bootstrap.dart               # Firebase.init, persistence, notifications
├── app/                         # app.dart, router.dart, theme.dart
├── core/
│   ├── firebase/                # firestore_paths.dart, converters.dart
│   ├── notifications/           # notification_service.dart, reminder_scheduler.dart
│   ├── widgets/
│   └── utils/
└── features/
    ├── auth/  household/  dogs/  events/  food/  health/  weight/  home_widget/  settings/
    └── (każdy: domain/ data/ application/ presentation/)
test/
firestore.rules
firestore.indexes.json
```

`domain/` zawiera czysty Dart (freezed) bez importów Firebase; logika (np. `StockForecast`,
wyliczanie `nextDue`) ma unit testy.

## Paczki

flutter_riverpod + riverpod_generator, go_router, freezed, json_serializable, firebase_core,
firebase_auth, cloud_firestore, google_sign_in, flutter_local_notifications, timezone,
flutter_timezone, fl_chart, home_widget, intl; testy: mocktail, fake_cloud_firestore.

## Ryzyka

- **Widget:** w MVP tylko wyświetla dane; tap otwiera deep link `/quick-add?type=…`
  (bez zapisu do Firestore z tła).
- **Przypomnienia:** każde urządzenie planuje je samo. Po każdej zmianie w `health` lub
  `purchases` trzeba wywołać `ReminderScheduler.resync()`, który przelicza wszystko od zera.
  iOS ma limit 64 zaplanowanych powiadomień.
- **Logowanie Google na Androidzie** wymaga dodania odcisku SHA-1 klucza debug w konsoli Firebase.

## Kolejność implementacji

1. Szkielet: zależności, flavory dev/prod, Firebase, router, logowanie Google, emulatory.
2. Household + pies: onboarding, zaproszenia, Security Rules z testami.
3. Wpisy: quick-add, Dziś, Historia.
4. Karma: karmy, zakupy, prognoza zapasu, powiadomienie "kup karmę".
5. Waga: pomiary i wykres.
6. Zdrowie: szablony, wpisy, `nextDue`, `ReminderScheduler.resync()`.
7. Widget: odczyt danych i deep link do quick-add.
