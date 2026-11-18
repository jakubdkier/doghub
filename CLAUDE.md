# Dog App

Aplikacja Flutter (Android + iOS) do prowadzenia dziennika psa we wspólnym
household (2 osoby, model gotowy na wiele psów). Pełny plan: docs/PLAN.md
"Aplikacja dla psa – plan MVP".

## Stack i decyzje
- Firebase Spark: Firestore (offline sync), Auth (Google, później Apple).
  Bez Cloud Functions, Cloud Storage i Blaze.
- Przypomnienia: flutter_local_notifications planowane lokalnie,
  ReminderScheduler.resync() po każdej zmianie danych zdrowotnych lub zakupów.
- Stan karmy i średnie zużycie liczone w apce (zakupy - posiłki), bez dokumentu
  stock i bez transakcji (transakcje Firestore nie działają offline).
- Riverpod (riverpod_generator), go_router, freezed + json_serializable,
  fl_chart, home_widget, intl (pl_PL).

## Model danych
households/{h} members[], dogs/{d}/{events, weights, health, foods, purchases},
invites/{code}. Event: type, at (czas zdarzenia, do sortowania),
createdAt (serverTimestamp), by (uid), pola zależne od typu, deleted.

## Konwencje
- Struktura feature-first: lib/features/<feature>/{domain,data,application,presentation}.
- domain/ to czysty Dart bez importów Firebase, z unit testami.
- Repozytoria używają withConverter i ścieżek z core/firebase/firestore_paths.dart.
- UI po polsku; teksty w plikach ARB (lib/l10n).
- Kod, nazwy i komentarze po angielsku.
- Flavory dev i prod z osobnymi projektami Firebase; nigdy nie zapisuj do prod
  podczas developmentu.

## Komendy
- flutter analyze
- flutter test
- dart run build_runner build -d
- firebase emulators:start (Firestore + Auth)
- flutter run --flavor dev -t lib/main_dev.dart

## Zasady pracy
- Po każdej zmianie: flutter analyze i flutter test muszą przechodzić.
- Zmiany w firestore.rules tylko razem z testami reguł na emulatorze.
- Małe commity, jeden etap planu na gałąź.
