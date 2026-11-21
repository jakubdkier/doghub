import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/application/reminder_settings_provider.dart';
import '../application/food_providers.dart';
import '../application/purchase_providers.dart';
import '../domain/food.dart';
import 'food_dialog.dart';
import 'stock_labels.dart';

class FoodPage extends ConsumerWidget {
  const FoodPage({super.key});

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final draft = await showFoodDialog(context);
    if (draft == null) return;
    ref
        .read(foodControllerProvider.notifier)
        .add(name: draft.name, brand: draft.brand);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final foods = ref.watch(foodsProvider).value ?? const <Food>[];
    final stock = ref.watch(stockProvider);
    final threshold = ref.watch(
      reminderSettingsControllerProvider.select((s) => s.foodThresholdKg),
    );
    final active = foods.where((f) => f.active).toList();
    final archived = foods.where((f) => !f.active).toList();
    final scheme = Theme.of(context).colorScheme;

    Widget tile(Food f) {
      final s = stock?[f.id];
      final low =
          f.active && s != null && s.hasPurchases && s.remainingKg <= threshold;
      return ListTile(
        key: Key('food-${f.id}'),
        leading: Icon(foodIcon(f)),
        title: Text(f.label),
        subtitle: Text(
          stockSummary(l10n, s),
          style: low ? TextStyle(color: scheme.error) : null,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(Routes.foodDetail(f.id)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navFood),
        actions: [
          IconButton(
            tooltip: l10n.addFood,
            icon: const Icon(Icons.add),
            onPressed: () => _add(context, ref),
          ),
        ],
      ),
      floatingActionButton: active.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.push(Routes.newPurchase),
              icon: const Icon(Icons.add_shopping_cart),
              label: Text(l10n.addPurchase),
            ),
      body: foods.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.foodsEmpty),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => _add(context, ref),
                    icon: const Icon(Icons.add),
                    label: Text(l10n.addFood),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.only(bottom: 88),
              children: [
                ...active.map(tile),
                if (archived.isNotEmpty) ...[
                  ListTile(
                    title: Text(
                      l10n.foodArchivedHeader,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  ...archived.map(tile),
                ],
              ],
            ),
    );
  }
}
