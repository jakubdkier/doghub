import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/core/utils/dates.dart';
import 'package:dog_app/features/health/presentation/health_entry_form_page.dart';
import 'package:dog_app/features/health/presentation/health_section_page.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_notifications.dart';
import '../../../helpers/pump_app.dart';

const health = 'households/h1/dogs/d1/health';

FakeAuthRepository signedIn() =>
    FakeAuthRepository(initialUser: FakeAuthRepository.testUser);

DateTime today() {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day, 12);
}

DateTime inDays(int d) {
  final t = today();
  return DateTime(t.year, t.month, t.day + d, 12);
}

Future<void> seedEntry(
  FakeFirebaseFirestore db,
  String id, {
  String type = 'vaccination',
  String? templateId = 'rabies',
  String name = 'Wścieklizna',
  required DateTime date,
  DateTime? nextDue,
}) => db.doc('$health/$id').set({
  'type': type,
  'templateId': ?templateId,
  'name': name,
  'date': Timestamp.fromDate(date),
  'nextDue': ?(nextDue == null ? null : Timestamp.fromDate(nextDue)),
  'by': 'u1',
  'createdAt': Timestamp.now(),
  'deleted': false,
});

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('add a rabies shot from its template; next due is computed', (
    tester,
  ) async {
    final db = await seededFirestore();
    await pumpApp(tester, signedIn(), firestore: db);

    await tapTab(tester, 'Zdrowie');
    await tester.tap(find.text('Dodaj wpis'));
    await tester.pumpAndSettle();
    expect(find.byType(HealthEntryFormPage), findsOneWidget);

    // First vaccination template is preselected; due = +12 months.
    final due = addMonths(today(), 12);
    expect(find.text(DateFormat.yMMMMd().format(due)), findsOneWidget);
    await tapVisible(tester, find.byKey(const Key('healthSave')));

    final saved = (await db.collection(health).get()).docs.single.data();
    expect(saved['templateId'], 'rabies');
    expect(saved['name'], 'Wścieklizna');
    expect(saved['type'], 'vaccination');
    expect((saved['nextDue'] as Timestamp).toDate(), due);

    final section = find.byKey(const Key('healthSection-vaccination'));
    expect(
      find.descendant(of: section, matching: find.text('Wścieklizna')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: section, matching: find.text('OK')),
      findsOneWidget,
    );
  });

  testWidgets('tick collar defaults to 6 months; overriding the template '
      'changes the next due', (tester) async {
    final db = await seededFirestore();
    await pumpApp(tester, signedIn(), firestore: db);

    await tester.tap(find.byTooltip('Ustawienia'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Szablony zdrowotne'));
    await tester.pumpAndSettle();
    expect(find.textContaining('co 6 miesięcy'), findsOneWidget);

    await tester.tap(find.byKey(const Key('template-tick_collar')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('templateInterval')), '8');
    await tester.tap(find.widgetWithText(FilledButton, 'Zapisz'));
    await tester.pumpAndSettle();
    expect(find.textContaining('co 8 miesięcy'), findsOneWidget);
    expect(
      (await db
          .doc('households/h1/healthTemplates/tick_collar')
          .get())['intervalMonths'],
      8,
    );

    await tapBack(tester);
    await tapBack(tester);
    await tapTab(tester, 'Zdrowie');
    await tester.tap(find.byKey(const Key('healthSection-ticks')));
    await tester.pumpAndSettle();
    expect(find.byType(HealthSectionPage), findsOneWidget);
    await tester.tap(find.text('Dodaj wpis'));
    await tester.pumpAndSettle();
    expect(
      find.text(DateFormat.yMMMMd().format(addMonths(today(), 8))),
      findsOneWidget,
    );
  });

  testWidgets('custom vet entry without a next visit', (tester) async {
    final db = await seededFirestore();
    await pumpApp(tester, signedIn(), firestore: db);

    await tapTab(tester, 'Zdrowie');
    await tester.scrollUntilVisible(
      find.byKey(const Key('healthSection-vet')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byKey(const Key('healthSection-vet')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dodaj wpis'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('healthOther')));
    await tester.pumpAndSettle();
    expect(find.text('brak'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('healthName')), 'Zęby');
    await tester.enterText(find.byKey(const Key('healthNote')), 'Kamień');
    await tapVisible(tester, find.byKey(const Key('healthSave')));

    final saved = (await db.collection(health).get()).docs.single.data();
    expect(saved['type'], 'vet');
    expect(saved.containsKey('templateId'), isFalse);
    expect(saved.containsKey('nextDue'), isFalse);
    expect(saved['note'], 'Kamień');
    expect(find.text('bez kolejnego terminu'), findsOneWidget);
  });

  testWidgets('overdue: banners on Today and Health, overdue reminder', (
    tester,
  ) async {
    final db = await seededFirestore();
    await seedEntry(db, 'e1', date: inDays(-400), nextDue: inDays(-35));
    final notifications = FakeLocalNotifications();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
    );

    expect(find.byKey(const Key('healthAttention')), findsOneWidget);
    expect(find.text('1 termin wymaga uwagi'), findsOneWidget);
    expect(find.textContaining('35 dni temu'), findsOneWidget);

    final r = notifications.scheduled.single;
    expect(r.title, 'Po terminie: Wścieklizna');
    expect(r.body, startsWith('Burek · termin'));
    expect(r.route, '/health');
    expect(r.at.hour, 18);

    await tester.tap(find.byKey(const Key('healthAttention')));
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byKey(const Key('healthSection-vaccination')),
        matching: find.text('Po terminie'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('due in 10 days: reminders 7 days before and on the day; '
      'health reminders can be turned off', (tester) async {
    final db = await seededFirestore();
    await seedEntry(db, 'e1', date: inDays(-355), nextDue: inDays(10));
    final notifications = FakeLocalNotifications();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
    );

    final due = inDays(10);
    expect(notifications.scheduled.map((n) => (n.title, n.at)), [
      (
        'Zbliża się: Wścieklizna',
        DateTime(due.year, due.month, due.day - 7, 18),
      ),
      ('Dziś termin: Wścieklizna', DateTime(due.year, due.month, due.day, 18)),
    ]);
    expect(find.text('1 termin wymaga uwagi'), findsOneWidget);

    await tester.tap(find.byTooltip('Ustawienia'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Przypomnienia'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('healthRemindersEnabled')));
    await tester.pumpAndSettle();
    expect(notifications.scheduled, isEmpty);
  });

  testWidgets('edit clears the next due; delete with undo', (tester) async {
    final db = await seededFirestore();
    await seedEntry(db, 'e1', date: inDays(-30), nextDue: inDays(335));
    await pumpApp(tester, signedIn(), firestore: db);

    await tapTab(tester, 'Zdrowie');
    await tester.tap(find.byKey(const Key('healthSection-vaccination')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('health-e1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Usuń termin'));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.byKey(const Key('healthSave')));
    final raw = (await db.doc('$health/e1').get()).data()!;
    expect(raw.containsKey('nextDue'), isFalse);
    expect(raw['templateId'], 'rabies');

    await tester.dragFrom(
      tester.getTopLeft(find.byKey(const ValueKey('health-e1'))) +
          const Offset(40, 20),
      const Offset(-600, 0),
    );
    await tester.pumpAndSettle();
    expect((await db.doc('$health/e1').get())['deleted'], isTrue);
    await tester.tap(find.text('Cofnij'));
    await tester.pumpAndSettle();
    expect((await db.doc('$health/e1').get())['deleted'], isFalse);
    expect(find.byKey(const ValueKey('health-e1')), findsOneWidget);
  });

  testWidgets('archived templates are not offered', (tester) async {
    final db = await seededFirestore();
    await db.doc('households/h1/healthTemplates/dhppi').set({
      'name': 'Szczepienie zakaźne (DHPPi+L)',
      'type': 'vaccination',
      'intervalMonths': 12,
      'mandatory': false,
      'active': false,
    });
    await pumpApp(tester, signedIn(), firestore: db);

    await tapTab(tester, 'Zdrowie');
    await tester.tap(find.text('Dodaj wpis'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ChoiceChip, 'Wścieklizna'), findsOneWidget);
    expect(
      find.widgetWithText(ChoiceChip, 'Szczepienie zakaźne (DHPPi+L)'),
      findsNothing,
    );
  });
}
