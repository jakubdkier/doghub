import 'package:dog_app/app/app_shell.dart';
import 'package:dog_app/features/auth/presentation/login_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../helpers/fake_auth_repository.dart';
import '../helpers/pump_app.dart';

void main() {
  testWidgets('signed out user sees the login page', (tester) async {
    await pumpApp(tester, FakeAuthRepository());

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.text('Zaloguj przez Google'), findsOneWidget);
  });

  testWidgets('signed in user sees the shell with four tabs', (tester) async {
    await pumpApp(
      tester,
      FakeAuthRepository(initialUser: FakeAuthRepository.testUser),
    );

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
  });

  testWidgets('login, switch tab and logout', (tester) async {
    final auth = FakeAuthRepository();
    await pumpApp(tester, auth);

    await tester.tap(find.text('Zaloguj przez Google'));
    await tester.pumpAndSettle();
    expect(find.byType(AppShell), findsOneWidget);

    await tester.tap(find.text('Karma'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Karma'), findsOneWidget);

    auth.emit(null);
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

  testWidgets('sign out button on Today returns to login', (tester) async {
    await pumpApp(
      tester,
      FakeAuthRepository(initialUser: FakeAuthRepository.testUser),
    );

    await tester.tap(find.byTooltip('Wyloguj'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });
}
