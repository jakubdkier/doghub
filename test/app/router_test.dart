import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/app/app_shell.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:dog_app/features/auth/presentation/login_page.dart';
import 'package:dog_app/features/dogs/presentation/onboarding_dog_page.dart';
import 'package:dog_app/features/household/presentation/household_settings_page.dart';
import 'package:dog_app/features/household/presentation/onboarding_household_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/fake_auth_repository.dart';
import '../helpers/pump_app.dart';

FakeAuthRepository signedIn() =>
    FakeAuthRepository(initialUser: FakeAuthRepository.testUser);

void main() {
  testWidgets('signed out user sees the login page', (tester) async {
    await pumpApp(tester, FakeAuthRepository());

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('new user creates a household, adds a dog and lands on Today', (
    tester,
  ) async {
    final db = FakeFirebaseFirestore();
    await pumpApp(tester, FakeAuthRepository(), firestore: db);

    await tester.tap(find.text('Zaloguj przez Google'));
    await tester.pumpAndSettle();
    expect(find.byType(OnboardingHouseholdPage), findsOneWidget);

    await tester.enterText(find.byKey(const Key('householdName')), 'Kierowie');
    await tester.tap(find.text('Utwórz'));
    await tester.pumpAndSettle();
    expect(find.byType(OnboardingDogPage), findsOneWidget);

    // Name is required.
    await tester.tap(find.text('Zapisz'));
    await tester.pumpAndSettle();
    expect(find.text('To pole jest wymagane'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('dogName')), 'Burek');
    await tester.enterText(find.byKey(const Key('dogWeight')), '12,5');
    await tester.tap(find.text('Zapisz'));
    await tester.pumpAndSettle();

    expect(find.byType(AppShell), findsOneWidget);
    expect(find.text('Burek · Dziś'), findsOneWidget);

    final household = (await db.collection('households').get()).docs.single;
    expect(household['name'], 'Kierowie');
    expect(household['memberNames'], {'u1': 'Jakub'});
    final dog =
        (await household.reference.collection('dogs').get()).docs.single;
    final weight =
        (await dog.reference.collection('weights').get()).docs.single;
    expect(weight['kg'], 12.5);
    expect(weight['by'], 'u1');
  });

  testWidgets('user joins an existing household with a code', (tester) async {
    final db = await seededFirestore(owner: 'alice');
    await db.doc('invites/ABC234').set({
      'householdId': 'h1',
      'createdBy': 'alice',
      'expiresAt': Timestamp.fromDate(
        DateTime.now().add(const Duration(hours: 1)),
      ),
    });
    await pumpApp(tester, signedIn(), firestore: db);
    expect(find.byType(OnboardingHouseholdPage), findsOneWidget);

    await tester.enterText(find.byKey(const Key('inviteCode')), 'abc234');
    await tester.tap(find.text('Dołącz'));
    await tester.pumpAndSettle();

    expect(find.byType(AppShell), findsOneWidget);
    expect(find.text('Burek · Dziś'), findsOneWidget);
    final raw = (await db.doc('households/h1').get()).data()!;
    expect(raw['members'], ['alice', 'u1']);
  });

  testWidgets('unknown invite code shows an error', (tester) async {
    await pumpApp(tester, signedIn());

    await tester.enterText(find.byKey(const Key('inviteCode')), 'ZZZ999');
    await tester.tap(find.text('Dołącz'));
    await tester.pumpAndSettle();

    expect(find.text('Nie ma takiego kodu.'), findsOneWidget);
    expect(find.byType(OnboardingHouseholdPage), findsOneWidget);
  });

  testWidgets('household without a dog goes to the dog step', (tester) async {
    final db = await seededFirestore(withDog: false);
    await pumpApp(tester, signedIn(), firestore: db);

    expect(find.byType(OnboardingDogPage), findsOneWidget);
  });

  testWidgets('ready user sees the shell with four tabs', (tester) async {
    await pumpApp(tester, signedIn(), firestore: await seededFirestore());

    expect(find.byType(AppShell), findsOneWidget);
    for (final label in ['Dziś', 'Historia', 'Karma', 'Zdrowie']) {
      expect(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(label),
        ),
        findsOneWidget,
      );
    }
    await tester.tap(find.text('Karma'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Karma'), findsOneWidget);
  });

  testWidgets('settings: generate and revoke an invite, then sign out', (
    tester,
  ) async {
    final db = await seededFirestore();
    await pumpApp(tester, signedIn(), firestore: db);

    await tester.tap(find.byTooltip('Ustawienia'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dom i domownicy'));
    await tester.pumpAndSettle();
    expect(find.byType(HouseholdSettingsPage), findsOneWidget);
    expect(find.text('Jakub (Ty)'), findsOneWidget);

    await tester.tap(find.text('Wygeneruj kod'));
    await tester.pumpAndSettle();
    final code = (await db.doc('households/h1').get()).data()!['inviteCode'];
    expect(code, isA<String>());
    expect(find.byKey(const Key('inviteCodeValue')), findsOneWidget);

    await tester.tap(find.text('Unieważnij'));
    await tester.pumpAndSettle();
    expect(find.text('Wygeneruj kod'), findsOneWidget);
    expect((await db.doc('invites/$code').get()).exists, isFalse);

    final back = MaterialLocalizations.of(
      tester.element(find.byType(HouseholdSettingsPage)),
    ).backButtonTooltip;
    await tester.tap(find.byTooltip(back));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wyloguj'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('cancelled sign-in stays on login without error', (tester) async {
    final auth = FakeAuthRepository()..cancelNextSignIn = true;
    await pumpApp(tester, auth);

    await tester.tap(find.text('Zaloguj przez Google'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);
  });
}
