import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/app/app_shell.dart';
import 'package:dog_app/app/router.dart';
import 'package:dog_app/features/events/presentation/event_edit_page.dart';
import 'package:dog_app/features/events/presentation/quick_add.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/pump_app.dart';

const events = 'households/h1/dogs/d1/events';
const foods = 'households/h1/dogs/d1/foods';

FakeAuthRepository signedIn() =>
    FakeAuthRepository(initialUser: FakeAuthRepository.testUser);

Future<void> seedEvent(
  FakeFirebaseFirestore db,
  String id,
  Map<String, Object?> data, {
  Duration ago = Duration.zero,
}) => db.doc('$events/$id').set({
  'at': Timestamp.fromDate(DateTime.now().subtract(ago)),
  'createdAt': Timestamp.now(),
  'by': 'u1',
  'deleted': false,
  ...data,
});

Future<List<Map<String, dynamic>>> allEvents(FakeFirebaseFirestore db) async =>
    [for (final d in (await db.collection(events).get()).docs) d.data()];

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('quick-add a meal with a new food', (tester) async {
    final db = await seededFirestore();
    await pumpApp(tester, signedIn(), firestore: db);
    expect(find.text('Nic jeszcze dziś nie zapisano.'), findsOneWidget);

    await tester.tap(find.byKey(const Key('quickAdd-meal')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dodaj karmę'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('foodName')), 'Adult');
    await tester.enterText(find.byKey(const Key('foodBrand')), 'Acana');
    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.widgetWithText(FilledButton, 'Zapisz'),
      ),
    );
    await tester.pumpAndSettle();

    // Grams are required.
    await tapVisible(tester, find.byKey(const Key('eventSave')));
    expect(find.text('Podaj porcję od 1 do 5000 g'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('mealGrams')), '120');
    await tapVisible(tester, find.byKey(const Key('eventSave')));

    expect(find.text('Posiłek · 120 g · Acana Adult'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const Key('last-meal')),
        matching: find.text('przed chwilą'),
      ),
      findsOneWidget,
    );

    final food = (await db.collection(foods).get()).docs.single;
    final meal = (await allEvents(db)).single;
    expect(meal['type'], 'meal');
    expect(meal['grams'], 120);
    expect(meal['foodId'], food.id);
    expect(meal['by'], 'u1');
  });

  testWidgets('new meal defaults to the last food and portion', (tester) async {
    final db = await seededFirestore();
    await db.doc('$foods/f1').set({
      'name': 'Adult',
      'brand': 'Acana',
      'active': true,
      'createdAt': Timestamp.now(),
    });
    await seedEvent(db, 'm1', {
      'type': 'meal',
      'grams': 150,
      'foodId': 'f1',
    }, ago: const Duration(hours: 2));
    await pumpApp(tester, signedIn(), firestore: db);

    expect(
      find.descendant(
        of: find.byKey(const Key('last-meal')),
        matching: find.text('2 h temu'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('quickAdd-meal')));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextFormField, '150'), findsOneWidget);
    await tapVisible(tester, find.byKey(const Key('eventSave')));

    final meals = await allEvents(db);
    expect(meals, hasLength(2));
    expect(meals.map((m) => m['foodId']), everyElement('f1'));
    expect(meals.map((m) => m['grams']), everyElement(150));
  });

  testWidgets('quick-add a poop with score and colour', (tester) async {
    final db = await seededFirestore();
    await pumpApp(tester, signedIn(), firestore: db);

    await tester.tap(find.byKey(const Key('quickAdd-poop')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('poopScore6')));
    await tester.pumpAndSettle();
    expect(find.text('papkowata'), findsOneWidget);
    await tester.tap(find.text('zielona'));
    await tapVisible(tester, find.byKey(const Key('eventSave')));

    final poop = (await allEvents(db)).single;
    expect(poop['poopScore'], 6);
    expect(poop['poopColor'], 'green');
    expect(find.text('Kupa · Bristol 6 · zielona'), findsOneWidget);
  });

  testWidgets('a note needs text', (tester) async {
    final db = await seededFirestore();
    await pumpApp(tester, signedIn(), firestore: db);

    await tester.tap(find.byKey(const Key('quickAdd-note')));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.byKey(const Key('eventSave')));
    expect(find.text('Wpisz treść notatki'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('eventNote')), 'Kichał');
    await tapVisible(tester, find.byKey(const Key('eventSave')));
    expect((await allEvents(db)).single['note'], 'Kichał');
  });

  testWidgets('swipe deletes an entry and undo restores it', (tester) async {
    final db = await seededFirestore();
    await seedEvent(db, 'p1', {'type': 'pee'});
    await pumpApp(tester, signedIn(), firestore: db);
    expect(find.text('Siku'), findsWidgets);

    await tester.drag(
      find.byKey(const ValueKey('event-p1')),
      const Offset(-600, 0),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('event-p1')), findsNothing);
    expect((await db.doc('$events/p1').get())['deleted'], isTrue);

    await tester.tap(find.text('Cofnij'));
    await tester.pumpAndSettle();
    expect((await db.doc('$events/p1').get())['deleted'], isFalse);
    expect(find.byKey(const ValueKey('event-p1')), findsOneWidget);
  });

  testWidgets("history: filter and edit a partner's entry", (tester) async {
    final db = await seededFirestore();
    await db.doc('households/h1').update({
      'members': ['u1', 'alice'],
      'memberNames.alice': 'Ala',
    });
    await seedEvent(db, 'w1', {
      'type': 'walk',
      'durationMin': 30,
      'by': 'alice',
    }, ago: const Duration(days: 1));
    await seedEvent(db, 'p1', {'type': 'pee'});
    await pumpApp(tester, signedIn(), firestore: db);

    await tapTab(tester, 'Historia');
    expect(find.text('Wczoraj'), findsOneWidget);
    expect(find.text('Spacer · 30 min'), findsOneWidget);
    expect(find.text('Siku'), findsWidgets);

    await tester.tap(find.byKey(const Key('filter-walk')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('event-p1')), findsNothing);
    expect(find.byKey(const ValueKey('event-w1')), findsOneWidget);

    await tester.tap(find.text('Spacer · 30 min'));
    await tester.pumpAndSettle();
    expect(find.byType(EventEditPage), findsOneWidget);
    expect(find.text('Ala'), findsOneWidget);

    await tester.tap(find.text('45 min'));
    await tester.pumpAndSettle();
    await tapVisible(tester, find.byKey(const Key('eventSave')));

    expect(find.text('Spacer · 45 min'), findsOneWidget);
    final walk = (await db.doc('$events/w1').get()).data()!;
    expect(walk['durationMin'], 45);
    expect(walk['by'], 'alice');
  });

  testWidgets('edit page deletes with undo', (tester) async {
    final db = await seededFirestore();
    await seedEvent(db, 'p1', {'type': 'pee'});
    await pumpApp(tester, signedIn(), firestore: db);

    await tester.tap(find.byKey(const ValueKey('event-p1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Usuń'));
    await tester.pumpAndSettle();

    expect(find.byType(AppShell), findsOneWidget);
    expect(find.byKey(const ValueKey('event-p1')), findsNothing);
    expect((await db.doc('$events/p1').get())['deleted'], isTrue);
    await tester.tap(find.text('Cofnij'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('event-p1')), findsOneWidget);
  });

  testWidgets('quick-add deep link opens the form for the type', (
    tester,
  ) async {
    final db = await seededFirestore();
    await pumpApp(tester, signedIn(), firestore: db);

    ProviderScope.containerOf(tester.element(find.byType(AppShell)))
        .read(routerProvider)
        .go('/quick-add?type=walk');
    await tester.pumpAndSettle();
    expect(find.byType(QuickAddPage), findsOneWidget);
    expect(find.byKey(const Key('walkDuration')), findsOneWidget);

    await tapVisible(tester, find.byKey(const Key('eventSave')));
    expect(find.byType(AppShell), findsOneWidget);
    expect((await allEvents(db)).single['durationMin'], 30);
  });

  testWidgets('food tab adds a food, then archives it from its page', (
    tester,
  ) async {
    final db = await seededFirestore();
    await pumpApp(tester, signedIn(), firestore: db);

    await tapTab(tester, 'Karma');
    expect(find.text('Nie dodano jeszcze żadnej karmy.'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Dodaj karmę'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('foodName')), 'Adult');
    await tester.tap(find.widgetWithText(FilledButton, 'Zapisz'));
    await tester.pumpAndSettle();
    expect(find.text('Adult'), findsOneWidget);
    expect(find.text('brak zakupów'), findsOneWidget);

    await tester.tap(find.text('Adult'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Edytuj karmę'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch));
    await tester.tap(find.widgetWithText(FilledButton, 'Zapisz'));
    await tester.pumpAndSettle();
    expect((await db.collection(foods).get()).docs.single['active'], isFalse);

    await tapBack(tester);
    expect(find.text('Nieużywane'), findsOneWidget);
  });
}
