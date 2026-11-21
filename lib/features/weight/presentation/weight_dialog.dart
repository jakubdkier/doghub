import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/formatting.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/weight_entry.dart';

typedef WeightDraft = ({double kg, DateTime day});

/// Asks for kg and day; [initial] pre-fills for editing.
Future<WeightDraft?> showWeightDialog(
  BuildContext context, {
  WeightEntry? initial,
  required DateTime now,
}) => showDialog<WeightDraft>(
  context: context,
  builder: (_) => _WeightDialog(initial: initial, now: now),
);

class _WeightDialog extends StatefulWidget {
  const _WeightDialog({this.initial, required this.now});

  final WeightEntry? initial;
  final DateTime now;

  @override
  State<_WeightDialog> createState() => _WeightDialogState();
}

class _WeightDialogState extends State<_WeightDialog> {
  final _form = GlobalKey<FormState>();
  late final _kg = TextEditingController(
    text: widget.initial == null ? null : formatKg(widget.initial!.kg),
  );
  late DateTime _day = widget.initial?.at ?? widget.now;

  @override
  void dispose() {
    _kg.dispose();
    super.dispose();
  }

  Future<void> _pickDay() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _day,
      firstDate: DateTime(widget.now.year - 30),
      lastDate: widget.now,
    );
    if (picked != null) setState(() => _day = picked);
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    Navigator.of(context)
        .pop<WeightDraft>((kg: parseWeightKg(_kg.text)!, day: weighDay(_day)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      scrollable: true,
      title: Text(widget.initial == null ? l10n.weightAdd : l10n.weightEdit),
      content: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              key: const Key('weightKg'),
              controller: _kg,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.weightKgLabel,
                suffixText: 'kg',
              ),
              validator: (v) =>
                  parseWeightKg(v ?? '') == null ? l10n.dogWeightInvalid : null,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event),
              title: Text(l10n.weightDayLabel),
              trailing: Text(DateFormat.yMMMd().format(_day)),
              onTap: _pickDay,
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
