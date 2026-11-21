import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/app_localizations.dart';
import '../application/health_providers.dart';
import '../domain/health_entry.dart';
import '../domain/health_template.dart';
import 'health_labels.dart';

/// `/settings/templates`: household health templates.
class TemplateSettingsPage extends ConsumerWidget {
  const TemplateSettingsPage({super.key});

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, [
    HealthTemplate? template,
  ]) async {
    final result = await showDialog<HealthTemplate>(
      context: context,
      builder: (_) => _TemplateDialog(initial: template),
    );
    if (result != null) {
      ref.read(healthControllerProvider.notifier).saveTemplate(result);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final templates =
        ref.watch(healthTemplatesProvider).value ?? defaultHealthTemplates;
    final active = templates.where((t) => t.active);
    final archived = templates.where((t) => !t.active);

    Widget tile(HealthTemplate t) => ListTile(
      key: Key('template-${t.id}'),
      leading: Icon(t.type.icon),
      title: Text(t.name),
      subtitle: Text(
        [
          t.type.label(l10n),
          t.intervalMonths == null
              ? l10n.templateNoInterval
              : l10n.templateInterval(t.intervalMonths!),
          if (t.mandatory) l10n.healthMandatory,
        ].join(' · '),
      ),
      onTap: () => _edit(context, ref, t),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTemplates)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _edit(context, ref),
        icon: const Icon(Icons.add),
        label: Text(l10n.templateAdd),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 88),
        children: [
          ...active.map(tile),
          if (archived.isNotEmpty) ...[
            ListTile(
              title: Text(
                l10n.templateArchived,
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

class _TemplateDialog extends StatefulWidget {
  const _TemplateDialog({this.initial});

  final HealthTemplate? initial;

  @override
  State<_TemplateDialog> createState() => _TemplateDialogState();
}

class _TemplateDialogState extends State<_TemplateDialog> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.initial?.name);
  late final _interval = TextEditingController(
    text: widget.initial?.intervalMonths?.toString(),
  );
  late HealthType _type = widget.initial?.type ?? HealthType.vaccination;
  late bool _mandatory = widget.initial?.mandatory ?? false;
  late bool _active = widget.initial?.active ?? true;

  @override
  void dispose() {
    _name.dispose();
    _interval.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    final interval = _interval.text.trim();
    Navigator.of(context).pop(
      HealthTemplate(
        // Empty id = new custom template (assigned on save).
        id: widget.initial?.id ?? '',
        name: _name.text.trim(),
        type: _type,
        intervalMonths: interval.isEmpty ? null : int.parse(interval),
        mandatory: _mandatory,
        active: _active,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      scrollable: true,
      title: Text(
        widget.initial == null ? l10n.templateAdd : l10n.templateEdit,
      ),
      content: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              key: const Key('templateName'),
              controller: _name,
              maxLength: HealthLimits.maxNameLength,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: l10n.healthNameLabel),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final t in HealthType.values)
                  ChoiceChip(
                    label: Text(t.label(l10n)),
                    selected: _type == t,
                    onSelected: (_) => setState(() => _type = t),
                  ),
              ],
            ),
            TextFormField(
              key: const Key('templateInterval'),
              controller: _interval,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: l10n.templateIntervalLabel,
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                final m = int.tryParse(v);
                return (m == null ||
                        m < 1 ||
                        m > HealthTemplate.maxIntervalMonths)
                    ? l10n.templateIntervalInvalid
                    : null;
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.templateMandatory),
              value: _mandatory,
              onChanged: (v) => setState(() => _mandatory = v),
            ),
            if (widget.initial != null)
              SwitchListTile(
                key: const Key('templateActive'),
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.templateActive),
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
