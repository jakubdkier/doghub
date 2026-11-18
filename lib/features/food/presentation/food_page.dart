import 'package:material_ui/material_ui.dart';

import '../../../core/widgets/placeholder_page.dart';
import '../../../l10n/app_localizations.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) =>
      PlaceholderPage(title: AppLocalizations.of(context).navFood);
}
