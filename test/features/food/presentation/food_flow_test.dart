import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/features/food/presentation/food_detail_page.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_notifications.dart';
import '../../../helpers/pump_app.dart';

const dog = 'households/h1/dogs/d1';

FakeAuthRepository signedIn() =>
    FakeAuthRepository(initialUser: FakeAuthRepository.testUser);

Timestamp ago(Duration d) => Timestamp.fromDate(DateTime.now().subtract(d));

Future<FakeFirebaseFirestore> withFood() async {
  final db = await seededFirestore();
  await db.doc('$dog/foods/f1').set({
    'name': 'Adult',
    'brand': 'Acana',
    'active': true,
    'createdAt': Timestamp.now(),
  });
  return db;
}

Future<void> seedPurchase(
  FakeFirebaseFirestore db,
  String id,
  double kg, {
  Duration age = const Duration(days: 10),
}) => db.doc('$dog/purchases/$id').set({
  'foodId': 'f1',
  'kg': kg,
  'at': ago(age),
  'by': 'u1',
  'createdAt': Timestamp.now(),
  'deleted': false,
});

/// [count] meals of [grams], one every 12 h, the latest 1 h ago.
Future<void> seedMeals(FakeFirebaseFirestore db, int count, int grams) async {
  for (var i = 0; i < count; i++) {
    await db.doc('$dog/events/m$i').set({
      'type': 'meal',
      'grams': grams,
      'foodId': 'f1',
      'at': ago(Duration(hours: 1 + 12 * i)),
      'by': 'u1',
      'createdAt': Timestamp.now(),
      'deleted': false,
    });
  }
}

Future<void> tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('add a purchase: stock, permission and reminder', (tester) async {
    final db = await withFood();
    final notifications = FakeLocalNotifications();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
    );

    await tapTab(tester, 'Karma');
    await tester.tap(find.text('Acana Adult'));
    await tester.pumpAndSettle();
    expect(find.byType(FoodDetailPage), findsOneWidget);
    expect(find.text('brak zakupów'), findsOneWidget);

    await tester.tap(find.text('Dodaj zakup'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('purchaseKg')), 'dużo');
    await tapVisible(tester, find.byKey(const Key('purchaseSave')));
    expect(find.text('Podaj ilość, np. 12 albo 1,5'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('purchaseKg')), '12');
    await tester.enterText(find.byKey(const Key('purchasePrice')), '249,99');
    await tapVisible(tester, find.byKey(const Key('purchaseSave')));

    expect(find.byType(FoodDetailPage), findsOneWidget);
    expect(find.text('12,0 kg'), findsWidgets);
    expect(find.textContaining('249,99'), findsOneWidget);
    expect(notifications.permissionRequests, 1);

    final purchase = (await db.collection('$dog/purchases').get()).docs.single;
    expect(purchase['kg'], 12);
    expect(purchase['price'], 249.99);
    expect(purchase['by'], 'u1');
    // No meals yet, so the pace (and the reminder date) is unknown.
    expect(notifications.scheduled, isEmpty);
  });

  testWidgets('low stock shows on Today and schedules the next reminder', (
    tester,
  ) async {
    final db = await withFood();
    await seedPurchase(db, 'p1', 3);
    await seedMeals(db, 10, 200); // 2 kg eaten, 400 g/day.
    final notifications = FakeLocalNotifications();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
    );

    final tile = find.byKey(const Key('foodStockTile'));
    expect(
      find.descendant(
        of: tile,
        matching: find.textContaining('zostało 1,0 kg'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: tile, matching: find.byIcon(Icons.warning_amber)),
      findsOneWidget,
    );

    final r = notifications.scheduled.single;
    expect(r.title, 'Kup karmę');
    expect(r.body, startsWith('Acana Adult: zostało ok.'));
    expect(r.route, '/food/f1');
    expect(r.at.hour, 18);
    expect(r.at.isAfter(DateTime.now()), isTrue);
    expect(r.at.difference(DateTime.now()).inHours, lessThan(25));
  });

  testWidgets('reminder settings: turning food reminders off unschedules', (
    tester,
  ) async {
    final db = await withFood();
    await seedPurchase(db, 'p1', 3);
    await seedMeals(db, 10, 200);
    final notifications = FakeLocalNotifications();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
    );
    expect(notifications.scheduled, hasLength(1));

    await tester.tap(find.byTooltip('Ustawienia'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Przypomnienia'));
    await tester.pumpAndSettle();
    expect(find.text('Gdy zostanie mniej niż 2,0 kg'), findsOneWidget);

    await tester.tap(find.byKey(const Key('foodRemindersEnabled')));
    await tester.pumpAndSettle();
    expect(notifications.scheduled, isEmpty);
  });

  testWidgets('saved threshold is used for the plan', (tester) async {
    final db = await withFood();
    await seedPurchase(db, 'p1', 10);
    await seedMeals(db, 10, 200); // 8 kg left, 400 g/day.
    final notifications = FakeLocalNotifications();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
      prefs: {'reminders.food.thresholdKg': 4.0, 'reminders.hour': 9},
    );

    final r = notifications.scheduled.single;
    // (8 - 4) kg at ~400-450 g/day ≈ 9-10 days, at 9:00 (so 8-10 whole
    // days from now depending on the time of day).
    expect(r.at.hour, 9);
    expect(r.at.difference(DateTime.now()).inDays, inInclusiveRange(8, 10));
  });

  testWidgets('tapping a notification opens the food', (tester) async {
    final db = await withFood();
    final notifications = FakeLocalNotifications();
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
    );

    notifications.tap('/food/f1');
    await tester.pumpAndSettle();
    expect(find.byType(FoodDetailPage), findsOneWidget);
  });

  testWidgets('a notification that launched the app opens after start', (
    tester,
  ) async {
    final db = await withFood();
    final notifications = FakeLocalNotifications()..launch = '/food/f1';
    await pumpApp(
      tester,
      signedIn(),
      firestore: db,
      notifications: notifications,
    );
    expect(find.byType(FoodDetailPage), findsOneWidget);
  });

  testWidgets('rate a food and delete a purchase with undo', (tester) async {
    final db = await withFood();
    await seedPurchase(db, 'p1', 12);
    await pumpApp(tester, signedIn(), firestore: db);

    await tapTab(tester, 'Karma');
    await tester.tap(find.text('Acana Adult'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Smakuje'));
    await tester.pumpAndSettle();
    expect((await db.doc('$dog/foods/f1').get())['rating'], 'good');

    await tester.ensureVisible(find.byKey(const ValueKey('purchase-p1')));
    await tester.pumpAndSettle();
    // Start at the row's left edge, clear of the floating action button.
    await tester.dragFrom(
      tester.getTopLeft(find.byKey(const ValueKey('purchase-p1'))) +
          const Offset(40, 20),
      const Offset(-600, 0),
    );
    await tester.pumpAndSettle();
    expect((await db.doc('$dog/purchases/p1').get())['deleted'], isTrue);
    expect(find.byKey(const ValueKey('purchase-p1')), findsNothing);
    // The stock card (scrolled out of view) no longer counts it.
    expect(find.text('brak zakupów', skipOffstage: false), findsOneWidget);

    await tester.tap(find.text('Cofnij'));
    await tester.pumpAndSettle();
    expect((await db.doc('$dog/purchases/p1').get())['deleted'], isFalse);
    expect(find.byKey(const ValueKey('purchase-p1')), findsOneWidget);
  });
}
