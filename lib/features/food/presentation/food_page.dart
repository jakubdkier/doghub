import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/app_localizations.dart';
import '../application/food_providers.dart';
import '../domain/food.dart';
import 'food_dialog.dart';

/// Minimal food list (stage 3); stock and purchases come in stage 4.
class FoodPage extends ConsumerWidget {
  const FoodPage({super.key});

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final draft = await showFoodDialog(context);
    if (draft == null) return;
    ref
        .read(foodControllerProvider.notifier)
        .add(name: draft.name, brand: draft.brand);
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, Food food) async {
    final draft = await showFoodDialog(context, initial: food);
    if (draft == null) return;
    ref
        .read(foodControllerProvider.notifier)
        .update(
          food.copyWith(
            name: draft.name,
            brand: draft.brand,
            active: draft.active,
          ),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final foods = ref.watch(foodsProvider).value ?? const <Food>[];
    final active = foods.where((f) => f.active).toList();
    final archived = foods.where((f) => !f.active).toList();

    Widget tile(Food f) => ListTile(
      leading: const Icon(Icons.set_meal_outlined),
      title: Text(f.name),
      subtitle: f.brand == null ? null : Text(f.brand!),
      onTap: () => _edit(context, ref, f),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navFood)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _add(context, ref),
        icon: const Icon(Icons.add),
        label: Text(l10n.addFood),
      ),
      body: foods.isEmpty
          ? Center(child: Text(l10n.foodsEmpty))
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
