import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_app/app/app_shell.dart';
import 'package:dog_app/app/router.dart';
import 'package:dog_app/features/events/application/event_providers.dart';
import 'package:dog_app/features/food/application/food_providers.dart';
import 'package:dog_app/features/food/application/purchase_providers.dart';
import 'package:dog_app/features/health/application/health_providers.dart';
import 'package:dog_app/features/weight/application/weight_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_auth_repository.dart';
import '../helpers/pump_app.dart';

/// What Firestore reports when the phone has no DNS/connection.
final offline = FirebaseException(
  plugin: 'cloud_firestore',
  code: 'unavailable',
  message: 'Unable to resolve host firestore.googleapis.com',
);

Stream<T> failing<T>() => Stream<T>.error(offline);

void main() {
  testWidgets('every screen survives failing data streams', (tester) async {
    await pumpApp(
      tester,
      FakeAuthRepository(initialUser: FakeAuthRepository.testUser),
      firestore: await seededFirestore(),
      extraOverrides: [
        recentEventsProvider.overrideWith((ref) => failing()),
        historyProvider.overrideWith((ref) => failing()),
        eventProvider.overrideWith((ref, id) => failing()),
        foodsProvider.overrideWith((ref) => failing()),
        purchasesProvider.overrideWith((ref) => failing()),
        mealsProvider.overrideWith((ref) => failing()),
        weightsProvider.overrideWith((ref) => failing()),
        healthEntriesProvider.overrideWith((ref) => failing()),
        healthTemplatesProvider.overrideWith((ref) => failing()),
      ],
    );
    expect(find.byType(AppShell), findsOneWidget);
    expect(tester.takeException(), isNull);

    final router = ProviderScope.containerOf(
      tester.element(find.byType(AppShell)),
    ).read(routerProvider);
    for (final route in [
      '/quick-add?type=walk',
      '/quick-add?type=meal',
      '/quick-add?type=poop',
      '/history',
      '/event/x',
      '/food',
      '/food/f1',
      '/food/purchase/new',
      '/health',
      '/health/weight',
      '/health/new',
      '/health/type/vaccination',
      '/health/entry/x',
      '/settings/templates',
      '/settings/reminders',
      '/today',
    ]) {
      router.go(route);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: route);
    }
  });
}
