import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/features/auth/presentation/login_page.dart';
import 'package:dog_app/features/events/presentation/quick_add.dart';
import 'package:dog_app/features/home_widget/domain/widget_snapshot.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/fake_auth_repository.dart';
import '../../helpers/fake_home_widget.dart';
import '../../helpers/pump_app.dart';

FakeAuthRepository signedIn() =>
    FakeAuthRepository(initialUser: FakeAuthRepository.testUser);

const dog = 'households/h1/dogs/d1';

void main() {
  testWidgets('widget gets last entries, food stock and health alerts', (
    tester,
  ) async {
    final db = await seededFirestore();
    final mealAt = DateTime.now().subtract(const Duration(hours: 2));
    await db.doc('$dog/foods/f1').set({
      'name': 'Adult',
      'brand': 'Acana',
      'active': true,
      'createdAt': Timestamp.now(),
    });
    await db.doc('$dog/purchases/p1').set({
      'foodId': 'f1',
      'kg': 1.5,
      'at': Timestamp.fromDate(
        DateTime.now().subtract(const Duration(days: 3)),
      ),
      'by': 'u1',
      'createdAt': Timestamp.now(),
      'deleted': false,
    });
    await db.doc('$dog/events/m1').set({
      'type': 'meal',
      'grams': 200,
      'foodId': 'f1',
      'at': Timestamp.fromDate(mealAt),
      'by': 'u1',
      'createdAt': Timestamp.now(),
      'deleted': false,
    });
    await db.doc('$dog/health/h1').set({
      'type': 'vaccination',
      'templateId': 'rabies',
      'name': 'Wścieklizna',
      'date': Timestamp.fromDate(
        DateTime.now().subtract(const Duration(days: 400)),
      ),
      'nextDue': Timestamp.fromDate(
        DateTime.now().subtract(const Duration(days: 35)),
      ),
      'by': 'u1',
      'createdAt': Timestamp.now(),
      'deleted': false,
    });
    final widget = FakeHomeWidgetService();
    await pumpApp(tester, signedIn(), firestore: db, homeWidget: widget);

    final s = widget.last!;
    expect(s.ready, isTrue);
    expect(s.dogName, 'Burek');
    expect(s.lastMealAt, mealAt);
    expect(s.lastPoopAt, isNull);
    expect(s.foodText, startsWith('Karma: zostało 1,3 kg'));
    expect(s.foodLow, isTrue);
    expect(s.healthText, '1 termin po terminie');
    expect(s.healthOverdue, isTrue);
  });

  testWidgets('a new entry updates the widget', (tester) async {
    final widget = FakeHomeWidgetService();
    await pumpApp(
      tester,
      signedIn(),
      firestore: await seededFirestore(),
      homeWidget: widget,
    );
    expect(widget.last!.lastWalkAt, isNull);

    await tester.tap(find.byKey(const Key('quickAdd-walk')));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('eventSave')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('eventSave')));
    await tester.pumpAndSettle();
    expect(widget.last!.lastWalkAt, isNotNull);
  });

  testWidgets('signed out: the widget asks to open the app', (tester) async {
    final widget = FakeHomeWidgetService();
    await pumpApp(tester, FakeAuthRepository(), homeWidget: widget);
    expect(find.byType(LoginPage), findsOneWidget);
    expect(widget.last, WidgetSnapshot.empty);
  });

  testWidgets('widget button opens quick-add for its type', (tester) async {
    final widget = FakeHomeWidgetService();
    await pumpApp(
      tester,
      signedIn(),
      firestore: await seededFirestore(),
      homeWidget: widget,
    );
    widget.tap('/quick-add?type=poop');
    await tester.pumpAndSettle();
    expect(find.byType(QuickAddPage), findsOneWidget);
    expect(find.byKey(const Key('poopScore4')), findsOneWidget);
  });

  testWidgets('widget tap that cold-started the app opens after sign-in', (
    tester,
  ) async {
    final widget = FakeHomeWidgetService()..launch = '/quick-add?type=meal';
    final auth = FakeAuthRepository();
    await pumpApp(
      tester,
      auth,
      firestore: await seededFirestore(),
      homeWidget: widget,
    );
    expect(find.byType(LoginPage), findsOneWidget);

    await tester.tap(find.text('Zaloguj przez Google'));
    await tester.pumpAndSettle();
    expect(find.byType(QuickAddPage), findsOneWidget);
    expect(find.byKey(const Key('mealGrams')), findsOneWidget);
  });
}
