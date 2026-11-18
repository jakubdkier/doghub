import 'package:material_ui/material_ui.dart';

import '../../l10n/app_localizations.dart';

/// Empty tab body used until a feature is implemented.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title), actions: actions),
    body: Center(child: Text(AppLocalizations.of(context).comingSoon)),
  );
}
