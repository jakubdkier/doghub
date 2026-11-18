import 'package:material_ui/material_ui.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/food.dart';

/// Values entered in [showFoodDialog].
typedef FoodDraft = ({String name, String? brand, bool active});

/// Asks for a food's name and brand; with [initial] also whether it is in use.
Future<FoodDraft?> showFoodDialog(BuildContext context, {Food? initial}) =>
    showDialog<FoodDraft>(
      context: context,
      builder: (_) => _FoodDialog(initial: initial),
    );

class _FoodDialog extends StatefulWidget {
  const _FoodDialog({this.initial});

  final Food? initial;

  @override
  State<_FoodDialog> createState() => _FoodDialogState();
}

class _FoodDialogState extends State<_FoodDialog> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.initial?.name);
  late final _brand = TextEditingController(text: widget.initial?.brand);
  late bool _active = widget.initial?.active ?? true;

  @override
  void dispose() {
    _name.dispose();
    _brand.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    final brand = _brand.text.trim();
    Navigator.of(context).pop<FoodDraft>((
      name: _name.text.trim(),
      brand: brand.isEmpty ? null : brand,
      active: _active,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.initial == null ? l10n.addFood : l10n.editFood),
      content: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              key: const Key('foodName'),
              controller: _name,
              autofocus: true,
              maxLength: 50,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: l10n.foodNameLabel),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null,
            ),
            TextFormField(
              key: const Key('foodBrand'),
              controller: _brand,
              maxLength: 50,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(labelText: l10n.foodBrandLabel),
            ),
            if (widget.initial != null)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.foodActive),
                value: _active,
                onChanged: (v) => setState(() => _active = v),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(l10n.save)),
      ],
    );
  }
}
