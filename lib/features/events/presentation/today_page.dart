import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/widgets/placeholder_page.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/auth_providers.dart';

class TodayPage extends ConsumerWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return PlaceholderPage(
      title: l10n.navToday,
      actions: [
        // Temporary until the settings screen exists.
        IconButton(
          tooltip: l10n.signOut,
          icon: const Icon(Icons.logout),
          onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
        ),
      ],
    );
  }
}
