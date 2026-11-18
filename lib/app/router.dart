import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/presentation/login_page.dart';
import '../features/dogs/presentation/onboarding_dog_page.dart';
import '../features/events/presentation/history_page.dart';
import '../features/events/presentation/today_page.dart';
import '../features/food/presentation/food_page.dart';
import '../features/health/presentation/health_page.dart';
import '../features/household/presentation/household_settings_page.dart';
import '../features/household/presentation/onboarding_household_page.dart';
import '../features/settings/presentation/settings_page.dart';
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

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) =>
        onboardingRedirect(refresh.value, state.matchedLocation),
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
        ],
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
              GoRoute(path: Routes.food, builder: (_, _) => const FoodPage()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.health,
                builder: (_, _) => const HealthPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
}
