import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/routes.dart';
import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../household/application/household_providers.dart';
import '../../settings/application/reminder_settings_provider.dart';
import '../application/food_providers.dart';
import '../application/purchase_providers.dart';
import '../domain/food.dart';
import '../domain/purchase.dart';
import '../domain/stock_forecast.dart';
import 'consumption_chart.dart';
import 'food_dialog.dart';
import 'stock_labels.dart';

/// `/food/:foodId`: stock, rating, consumption and purchases of a food.
class FoodDetailPage extends ConsumerWidget {
  const FoodDetailPage({super.key, required this.foodId});

  final String foodId;

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
    final foods = ref.watch(foodsProvider);
    final food = foods.value?.where((f) => f.id == foodId).firstOrNull;
    if (food == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: foods.isLoading
              ? const CircularProgressIndicator()
              : Text(l10n.foodNotFound),
        ),
      );
    }
    final stock = ref.watch(stockProvider)?[foodId];
    final purchases = (ref.watch(purchasesProvider).value ?? const [])
        .where((p) => p.foodId == foodId)
        .toList();
    final now = ref.watch(clockProvider)();
    final meals = ref.watch(mealsProvider).value ?? const [];
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(food.label),
        actions: [
          IconButton(
            tooltip: l10n.editFood,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _edit(context, ref, food),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.newPurchaseFor(foodId)),
        icon: const Icon(Icons.add_shopping_cart),
        label: Text(l10n.addPurchase),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
        children: [
          _StockCard(stock: stock, now: now),
          const SizedBox(height: 16),
          Text(l10n.ratingLabel, style: textTheme.titleSmall),
          const SizedBox(height: 8),
          SegmentedButton<FoodRating>(
            emptySelectionAllowed: true,
            showSelectedIcon: false,
            segments: [
              for (final r in FoodRating.values)
                ButtonSegment(
                  value: r,
                  icon: Icon(r.icon),
                  label: Text(r.label(l10n)),
                ),
            ],
            selected: {?food.rating},
            onSelectionChanged: (s) => ref
                .read(foodControllerProvider.notifier)
                .update(food.copyWith(rating: s.firstOrNull)),
          ),
          const SizedBox(height: 24),
          Text(l10n.consumptionChartTitle, style: textTheme.titleSmall),
          const SizedBox(height: 8),
          ConsumptionChart(
            days: dailyConsumption(foodId: foodId, meals: meals, now: now),
          ),
          const SizedBox(height: 24),
          Text(l10n.purchasesHeader, style: textTheme.titleSmall),
          if (purchases.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(l10n.purchasesEmpty),
            )
          else
            for (final p in purchases) _PurchaseTile(purchase: p),
        ],
      ),
    );
  }
}

class _StockCard extends ConsumerWidget {
  const _StockCard({required this.stock, required this.now});

  final StockForecast? stock;
  final DateTime now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final threshold = ref.watch(
      reminderSettingsControllerProvider.select((s) => s.foodThresholdKg),
    );
    final s = stock;
    final has = s != null && s.hasPurchases;
    final low = has && s.remainingKg <= threshold;
    final avg = s?.avgGramsPerDay;
    final end = s?.endDate(now);

    return Card(
      key: const Key('stockCard'),
      color: low ? scheme.errorContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    has ? l10n.kgValue(formatKg(s.remainingKg)) : '—',
                    style: textTheme.headlineMedium,
                  ),
                ),
                if (low)
                  Chip(
                    avatar: const Icon(Icons.warning_amber),
                    label: Text(l10n.stockLow),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            if (!has)
              Text(l10n.stockNoPurchases)
            else if (avg == null)
              Text(l10n.stockNoPace)
            else ...[
              Text(stockSummary(l10n, s)),
              Text(l10n.stockAverage(avg.round())),
              if (end != null)
                Text(l10n.stockEnds(DateFormat.MMMMd().format(end))),
            ],
          ],
        ),
      ),
    );
  }
}

class _PurchaseTile extends ConsumerWidget {
  const _PurchaseTile({required this.purchase});

  final Purchase purchase;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final author =
        ref.watch(currentHouseholdProvider).value?.nameOf(purchase.by) ?? '';
    final id = purchase.id!;
    final price = purchase.price;

    void delete() {
      final controller = ref.read(purchaseControllerProvider.notifier);
      controller.delete(id);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(l10n.purchaseDeleted),
            persist: false,
            action: SnackBarAction(
              label: l10n.undo,
              onPressed: () => controller.restore(id),
            ),
          ),
        );
    }

    return Dismissible(
      key: ValueKey('purchase-$id'),
      background: Container(
        color: scheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Icon(Icons.delete_outline, color: scheme.onErrorContainer),
      ),
      direction: DismissDirection.endToStart,
      // The list updates from the soft delete; don't remove the row twice.
      confirmDismiss: (_) async {
        delete();
        return false;
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.shopping_bag_outlined),
        title: Text(
          [
            l10n.kgValue(formatKg(purchase.kg)),
            if (price != null) formatPrice(price),
          ].join(' · '),
        ),
        subtitle: Text('${DateFormat.yMMMMd().format(purchase.at)} · $author'),
      ),
    );
  }
}
