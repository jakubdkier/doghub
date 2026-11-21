import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/features/meds/presentation/med_form_page.dart';
import 'package:dog_app/features/meds/presentation/meds_page.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_home_widget.dart';
import '../../../helpers/fake_notifications.dart';
import '../../../helpers/pump_app.dart';

const dog = 'households/h1/dogs/d1';

FakeAuthRepository signedIn() =>
    FakeAuthRepository(initialUser: FakeAuthRepository.testUser);

DateTime todayAt(int hour, [int minute = 0]) {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day, hour, minute);
}

String two(int v) => v.toString().padLeft(2, '0');

String slotId(String medId, DateTime s) =>
    '${medId}_${s.year}${two(s.month)}${two(s.day)}_${two(s.hour)}${two(s.minute)}';

/// Magnesium at 00:01 (already due) and 23:59 (still ahead) every day.
Future<FakeFirebaseFirestore> withMagnesium() async {
  final db = await seededFirestore();
  await db.doc('$dog/meds/m1').set({
    'name': 'Magnez',
    'dose': '1 tabletka',
    'scheduleType': 'daily',
    'times': ['00:01', '23:59'],
    'startDate': Timestamp.fromDate(
      DateTime.now().subtract(const Duration(days: 10)),
    ),
    'active': true,
    'createdAt': Timestamp.now(),
  });
  return db;
}

/// Scrolls the (lazy) list until [finder] is built, then taps it.
Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  if (finder.evaluate().isEmpty) {
    // The page's list is the first Scrollable (text fields have their own).
    await tester.scrollUntilVisible(
      finder,
      200,
      scrollable: find.byType(Scrollable).first,
    );
  }
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('add a med from Health; it shows up on Today', (tester) async {
    final db = await seededFirestore();
    await pumpApp(tester, signedIn(), firestore: db);

    await tapTab(tester, 'Zdrowie');
    await tester.scrollUntilVisible(
      find.byKey(const Key('medsCard')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byKey(const Key('medsCard')));
    await tester.pumpAndSettle();
    expect(find.byType(MedsPage), findsOneWidget);

    await tester.tap(find.text('Dodaj lek'));
    await tester.pumpAndSettle();
    expect(find.byType(MedFormPage), findsOneWidget);
    await tapVisible(tester, find.byKey(const Key('medSave')));
    // The name field (scrolled away) shows the error.
    expect(
      find.text('To pole jest wymagane', skipOffstage: false),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(
      find.byKey(const Key('medName')),
      -200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.enterText(find.byKey(const Key('medName')), 'Magnez');
    await tester.enterText(find.byKey(const Key('medDose')), '1 tabletka');
    await tapVisible(tester, find.byKey(const Key('medSave')));

    final med = (await db.collection('$dog/meds').get()).docs.single.data();
    expect(med['name'], 'Magnez');
    expect(med['times'], ['08:00']);
    expect(med['scheduleType'], 'daily');
    expect(find.text('Magnez · 1 tabletka'), findsOneWidget);
    expect(find.textContaining('codziennie o 08:00'), findsOneWidget);

    await tapTab(tester, 'Dziś');
    expect(find.text('Leki na dziś'), findsOneWidget);
  });

  testWidgets('tick and untick a dose on Today; reminders follow', (
    tester,
  ) async {
    final db = await withMagnesium();
    final notifications = FakeLocalNotifications();
    final widget = FakeHomeWidgetService();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
      homeWidget: widget,
    );

    final evening = todayAt(23, 59);
    final morning = todayAt(0, 1);
    List<DateTime> medTimes() => [
      for (final n in notifications.scheduled)
        if (n.title == 'Czas na lek: Magnez') n.at,
    ];
    expect(medTimes(), contains(evening));
    expect(notifications.scheduled.first.body, contains('1 tabletka'));
    expect(widget.last!.medsText, 'Leki: 0/2 dziś');
    expect(widget.last!.medsMissed, isTrue);

    final eveningTile = find.byKey(Key('dose-${slotId('m1', evening)}'));
    await tapVisible(tester, eveningTile);
    final dose = (await db.doc('$dog/medDoses/${slotId('m1', evening)}').get())
        .data()!;
    expect(dose['by'], 'u1');
    expect(dose['deleted'], false);
    expect(medTimes(), isNot(contains(evening)));
    expect(find.textContaining('podał(a) Jakub'), findsOneWidget);

    await tapVisible(tester, find.byKey(Key('dose-${slotId('m1', morning)}')));
    expect(widget.last!.medsText, 'Leki: 2/2 dziś');
    expect(widget.last!.medsMissed, isFalse);

    await tapVisible(tester, eveningTile);
    expect(
      (await db.doc('$dog/medDoses/${slotId('m1', evening)}').get())['deleted'],
      isTrue,
    );
    expect(medTimes(), contains(evening));
  });

  testWidgets("a partner's dose shows who gave it", (tester) async {
    final db = await withMagnesium();
    await db.doc('households/h1').update({
      'members': ['u1', 'alice'],
      'memberNames.alice': 'Ala',
    });
    final morning = todayAt(0, 1);
    await db.doc('$dog/medDoses/${slotId('m1', morning)}').set({
      'medId': 'm1',
      'slot': Timestamp.fromDate(morning),
      'givenAt': Timestamp.fromDate(todayAt(0, 5)),
      'by': 'alice',
      'deleted': false,
    });
    await pumpApp(tester, signedIn(), firestore: db);

    await tester.scrollUntilVisible(
      find.textContaining('podał(a) Ala o 00:05'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.textContaining('podał(a) Ala o 00:05'), findsOneWidget);
  });

  testWidgets('ending a med removes it from Today and its reminders', (
    tester,
  ) async {
    final db = await withMagnesium();
    final notifications = FakeLocalNotifications();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
    );
    expect(notifications.scheduled, isNotEmpty);

    await tapTab(tester, 'Zdrowie');
    await tester.scrollUntilVisible(
      find.byKey(const Key('medsCard')),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byKey(const Key('medsCard')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('med-m1')));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.byKey(const Key('medActive')));
    await tapVisible(tester, find.byKey(const Key('medSave')));

    expect((await db.doc('$dog/meds/m1').get())['active'], isFalse);
    expect(find.text('Zakończone'), findsOneWidget);
    expect(notifications.scheduled, isEmpty);
    await tapTab(tester, 'Dziś');
    expect(find.text('Leki na dziś'), findsNothing);
  });

  testWidgets('med reminders can be turned off', (tester) async {
    final db = await withMagnesium();
    final notifications = FakeLocalNotifications();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
      prefs: {'reminders.meds.enabled': false},
    );
    expect(notifications.scheduled, isEmpty);
  });
}
