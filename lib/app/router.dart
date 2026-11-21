import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/presentation/login_page.dart';
import '../features/dogs/presentation/onboarding_dog_page.dart';
import '../features/events/presentation/event_edit_page.dart';
import '../features/events/presentation/history_page.dart';
import '../features/events/presentation/quick_add.dart';
import '../features/events/presentation/today_page.dart';
import '../core/notifications/local_notifications.dart';
import '../features/food/presentation/food_detail_page.dart';
import '../features/food/presentation/food_page.dart';
import '../features/food/presentation/purchase_form_page.dart';
import '../features/health/presentation/health_page.dart';
import '../features/household/presentation/household_settings_page.dart';
import '../features/household/presentation/onboarding_household_page.dart';
import '../features/settings/presentation/reminder_settings_page.dart';
import '../features/settings/presentation/settings_page.dart';
import '../features/weight/presentation/weight_page.dart';
import 'app_shell.dart';
import 'onboarding_provider.dart';
import 'onboarding_step.dart';
import 'routes.dart';
import 'splash_page.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // Re-run redirects whenever sign-in / household / dog state changes.
  final refresh = ValueNotifier<OnboardingStep>(
    ref.read(onboardingStepProvider),
  );
  ref.listen(onboardingStepProvider, (_, step) => refresh.value = step);
  ref.onDispose(refresh.dispose);

  // Notification route waiting for onboarding to finish (cold start).
  String? pendingRoute;

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final target = onboardingRedirect(refresh.value, state.matchedLocation);
      if (target == Routes.today && pendingRoute != null) {
        final route = pendingRoute;
        pendingRoute = null;
        return route;
      }
      return target;
    },
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashPage()),
      GoRoute(path: Routes.login, builder: (_, _) => const LoginPage()),
      GoRoute(
        path: Routes.onboardingHousehold,
        builder: (_, _) => const OnboardingHouseholdPage(),
      ),
      GoRoute(
        path: Routes.onboardingDog,
        builder: (_, _) => const OnboardingDogPage(),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (_, _) => const SettingsPage(),
        routes: [
          GoRoute(
            path: 'household',
            builder: (_, _) => const HouseholdSettingsPage(),
          ),
          GoRoute(
            path: 'reminders',
            builder: (_, _) => const ReminderSettingsPage(),
          ),
        ],
      ),
      GoRoute(
        path: Routes.eventPattern,
        builder: (_, state) => EventEditPage(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: Routes.quickAdd,
        builder: (_, state) => QuickAddPage(
          type: QuickAddPage.parseType(state.uri.queryParameters['type']),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => AppShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: Routes.today, builder: (_, _) => const TodayPage()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.history,
                builder: (_, _) => const HistoryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.food,
                builder: (_, _) => const FoodPage(),
                routes: [
                  // Before ':foodId' so "purchase" isn't taken as an id.
                  GoRoute(
                    path: 'purchase/new',
                    builder: (_, state) => PurchaseFormPage(
                      foodId: state.uri.queryParameters['foodId'],
                    ),
                  ),
                  GoRoute(
                    path: ':foodId',
                    builder: (_, state) =>
                        FoodDetailPage(foodId: state.pathParameters['foodId']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.health,
                builder: (_, _) => const HealthPage(),
                routes: [
                  GoRoute(
                    path: 'weight',
                    builder: (_, _) => const WeightPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);

  // Notification taps open their route once the user is set up.
  void open(String route) {
    if (refresh.value == OnboardingStep.ready) {
      router.push(route);
    } else {
      pendingRoute = route;
    }
  }

  final notifications = ref.read(localNotificationsProvider);
  final taps = notifications.taps.listen(open);
  ref.onDispose(taps.cancel);
  unawaited(
    notifications.launchRoute().then((route) {
      if (route != null) open(route);
    }),
  );
  return router;
}
