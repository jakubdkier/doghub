import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/features/weight/presentation/weight_page.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_notifications.dart';
import '../../../helpers/pump_app.dart';

const weights = 'households/h1/dogs/d1/weights';

FakeAuthRepository signedIn() =>
    FakeAuthRepository(initialUser: FakeAuthRepository.testUser);

DateTime daysAgo(int d) {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day - d, 12);
}

Future<void> seedWeight(
  FakeFirebaseFirestore db,
  String id,
  double kg,
  int ago, {
  String by = 'u1',
}) => db.doc('$weights/$id').set({
  'kg': kg,
  'at': Timestamp.fromDate(daysAgo(ago)),
  'by': by,
  'createdAt': Timestamp.now(),
  'deleted': false,
});

Future<void> openWeight(WidgetTester tester) async {
  await tapTab(tester, 'Zdrowie');
  await tester.tap(find.byKey(const Key('weightCard')));
  await tester.pumpAndSettle();
  expect(find.byType(WeightPage), findsOneWidget);
}

void main() {
  testWidgets('add the first weight, then a second one shows the change', (
    tester,
  ) async {
    final db = await seededFirestore();
    await pumpApp(tester, signedIn(), firestore: db);

    await tapTab(tester, 'Zdrowie');
    expect(
      find.text('Brak pomiarów. Dodaj pierwszy, żeby zobaczyć wykres.'),
      findsOneWidget,
    );
    await openWeight(tester);

    await tester.tap(find.text('Dodaj pomiar'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('weightKg')), 'ciężki');
    await tester.tap(find.widgetWithText(FilledButton, 'Zapisz'));
    await tester.pumpAndSettle();
    expect(find.text('Podaj wagę, np. 12,5'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('weightKg')), '12,46');
    await tester.tap(find.widgetWithText(FilledButton, 'Zapisz'));
    await tester.pumpAndSettle();
    expect(find.text('12,5 kg'), findsWidgets);
    expect(find.text('Za mało pomiarów w tym okresie.'), findsOneWidget);

    final saved = (await db.collection(weights).get()).docs.single.data();
    expect(saved['kg'], 12.5);
    expect(saved['by'], 'u1');
    expect((saved['at'] as Timestamp).toDate().hour, 12);
  });

  testWidgets('summary, change, chart ranges and edit', (tester) async {
    final db = await seededFirestore();
    await seedWeight(db, 'w1', 11.0, 300);
    await seedWeight(db, 'w2', 12.4, 20);
    await seedWeight(db, 'w3', 12.7, 1);
    await pumpApp(tester, signedIn(), firestore: db);
    await openWeight(tester);

    final summary = find.byKey(const Key('weightSummary'));
    expect(
      find.descendant(of: summary, matching: find.text('12,7 kg')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: summary, matching: find.textContaining('+0,3 kg od')),
      findsOneWidget,
    );
    expect(find.byKey(const Key('weightChart')), findsOneWidget);

    // 3M has two points; it still charts. Years-old data needs "Wszystko".
    await tester.tap(find.text('3M'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('weightChart')), findsOneWidget);

    // The list builds lazily; scroll until the row exists.
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('weight-w2')),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('weight-w2')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('weightKg')), '12,2');
    await tester.tap(find.widgetWithText(FilledButton, 'Zapisz'));
    await tester.pumpAndSettle();
    expect((await db.doc('$weights/w2').get())['kg'], 12.2);
    expect(
      find.descendant(
        of: find.byKey(const Key('weightSummary'), skipOffstage: false),
        matching: find.textContaining('+0,5 kg od', skipOffstage: false),
      ),
      findsOneWidget,
    );
  });

  testWidgets('delete a measurement with undo', (tester) async {
    final db = await seededFirestore();
    await seedWeight(db, 'w1', 12.0, 10);
    await seedWeight(db, 'w2', 12.5, 1);
    await pumpApp(tester, signedIn(), firestore: db);
    await openWeight(tester);

    await tester.ensureVisible(find.byKey(const ValueKey('weight-w2')));
    await tester.pumpAndSettle();
    await tester.dragFrom(
      tester.getTopLeft(find.byKey(const ValueKey('weight-w2'))) +
          const Offset(40, 20),
      const Offset(-600, 0),
    );
    await tester.pumpAndSettle();
    expect((await db.doc('$weights/w2').get())['deleted'], isTrue);
    expect(find.byKey(const ValueKey('weight-w2')), findsNothing);

    await tester.tap(find.text('Cofnij'));
    await tester.pumpAndSettle();
    expect((await db.doc('$weights/w2').get())['deleted'], isFalse);
    expect(find.byKey(const ValueKey('weight-w2')), findsOneWidget);
  });

  testWidgets('monthly weigh reminder is scheduled and can be turned off', (
    tester,
  ) async {
    final db = await seededFirestore();
    await seedWeight(db, 'w1', 12.5, 10);
    final notifications = FakeLocalNotifications();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
    );

    final r = notifications.scheduled.single;
    expect(r.title, 'Czas zważyć: Burek');
    expect(r.body, startsWith('Ostatni pomiar: 12,5 kg'));
    expect(r.route, '/health/weight');
    expect(
      r.at,
      DateTime(daysAgo(10).year, daysAgo(10).month, daysAgo(10).day + 30, 18),
    );

    await tester.tap(find.byTooltip('Ustawienia'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Przypomnienia'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('weighRemindersEnabled')));
    await tester.pumpAndSettle();
    expect(notifications.scheduled, isEmpty);
  });

  testWidgets('tapping the weigh reminder opens the weight page', (
    tester,
  ) async {
    final db = await seededFirestore();
    final notifications = FakeLocalNotifications();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
    );
    notifications.tap('/health/weight');
    await tester.pumpAndSettle();
    expect(find.byType(WeightPage), findsOneWidget);
  });

  testWidgets('onboarding start weight appears on the weight page', (
    tester,
  ) async {
    final db = await seededFirestore(withDog: false);
    await pumpApp(tester, signedIn(), firestore: db);
    await tester.enterText(find.byKey(const Key('dogName')), 'Burek');
    await tester.enterText(find.byKey(const Key('dogWeight')), '9,8');
    await tester.tap(find.text('Zapisz'));
    await tester.pumpAndSettle();

    await openWeight(tester);
    expect(find.text('9,8 kg'), findsWidgets);
  });
}
