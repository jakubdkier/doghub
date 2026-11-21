import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../core/config/app_config_provider.dart';
import '../core/notifications/reminder_scheduler.dart';
import '../l10n/app_localizations.dart';
import 'router.dart';
import 'theme.dart';

class DogHubApp extends ConsumerWidget {
  const DogHubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    // Reschedules local reminders whenever their inputs change.
    ref.watch(reminderSyncProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: config.isDev,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      locale: const Locale('pl', 'PL'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      routerConfig: ref.watch(routerProvider),
    );
  }
}
