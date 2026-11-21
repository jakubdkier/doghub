import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../events/domain/event_timeline.dart';
import '../../settings/application/reminder_settings_provider.dart';
import '../application/food_providers.dart';
import '../application/purchase_providers.dart';
import '../domain/food.dart';
import '../domain/purchase.dart';
import 'food_dialog.dart';

/// `/food/purchase/new?foodId=…`
class PurchaseFormPage extends ConsumerStatefulWidget {
  const PurchaseFormPage({super.key, this.foodId});

  final String? foodId;

  @override
  ConsumerState<PurchaseFormPage> createState() => _PurchaseFormPageState();
}

class _PurchaseFormPageState extends ConsumerState<PurchaseFormPage> {
  final _form = GlobalKey<FormState>();
  final _kg = TextEditingController();
  final _price = TextEditingController();
  String? _foodId;
  late DateTime _at;
  bool _foodMissing = false;

  @override
  void initState() {
    super.initState();
    _at = ref.read(clockProvider)();
    final active = (ref.read(foodsProvider).value ?? const <Food>[])
        .where((f) => f.active)
        .toList();
    _foodId = widget.foodId ?? (active.length == 1 ? active.single.id : null);
  }

  @override
  void dispose() {
    _kg.dispose();
    _price.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = ref.read(clockProvider)();
    final picked = await showDatePicker(
      context: context,
      initialDate: _at,
      firstDate: DateTime(now.year - 2),
      lastDate: now,
    );
    if (picked == null) return;
    // Today keeps the current time; past days count from noon.
    setState(
      () => _at = startOfDay(picked) == startOfDay(now)
          ? now
          : DateTime(picked.year, picked.month, picked.day, 12),
    );
  }

  Future<void> _addFood() async {
    final draft = await showFoodDialog(context);
    if (draft == null) return;
    final id = ref
        .read(foodControllerProvider.notifier)
        .add(name: draft.name, brand: draft.brand);
    setState(() => _foodId = id);
  }

  void _save() {
    final formOk = _form.currentState!.validate();
    setState(() => _foodMissing = _foodId == null);
    if (!formOk || _foodId == null) return;
    ref
        .read(purchaseControllerProvider.notifier)
        .add(
          foodId: _foodId!,
          kg: parsePurchaseKg(_kg.text)!,
          price: _price.text.trim().isEmpty ? null : parsePrice(_price.text),
          at: _at,
        );
    // First purchase is when a "buy food" reminder starts to make sense.
    ref.read(reminderSettingsControllerProvider.notifier).ensurePermission();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final foods = ref.watch(foodsProvider).value ?? const <Food>[];
    final visible = foods.where((f) => f.active || f.id == _foodId);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addPurchase)),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final f in visible)
                  ChoiceChip(
                    label: Text(f.label),
                    selected: f.id == _foodId,
                    onSelected: (_) => setState(() {
                      _foodId = f.id;
                      _foodMissing = false;
                    }),
                  ),
                ActionChip(
                  avatar: const Icon(Icons.add),
                  label: Text(l10n.addFood),
                  onPressed: _addFood,
                ),
              ],
            ),
            if (_foodMissing)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  l10n.purchaseFoodRequired,
                  style: TextStyle(color: scheme.error),
                ),
              ),
            const SizedBox(height: 8),
            TextFormField(
              key: const Key('purchaseKg'),
              controller: _kg,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.purchaseKgLabel,
                suffixText: 'kg',
              ),
              validator: (v) => parsePurchaseKg(v ?? '') == null
                  ? l10n.purchaseKgInvalid
                  : null,
            ),
            TextFormField(
              key: const Key('purchasePrice'),
              controller: _price,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.purchasePriceLabel,
                suffixText: 'zł',
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                return parsePrice(v) == null ? l10n.purchasePriceInvalid : null;
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event),
              title: Text(l10n.purchaseDateLabel),
              trailing: Text(DateFormat.yMMMMd().format(_at)),
              onTap: _pickDate,
            ),
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('purchaseSave'),
              onPressed: _save,
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }
}
