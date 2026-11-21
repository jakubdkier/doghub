import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../application/health_providers.dart';
import '../domain/health_entry.dart';
import '../domain/health_schedule.dart';
import '../domain/health_template.dart';
import 'health_labels.dart';
import 'health_section_page.dart';

/// `/health/new?type=…` and `/health/entry/:id`.
class HealthEntryFormPage extends ConsumerWidget {
  const HealthEntryFormPage({super.key, this.type, this.entryId});

  final HealthType? type;
  final String? entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = entryId;
    if (id == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.healthAdd)),
        body: _HealthForm(type: type),
      );
    }
    final entries = ref.watch(healthEntriesProvider);
    final entry = entries.value?.where((e) => e.id == id).firstOrNull;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.healthEdit),
        actions: [
          if (entry != null)
            IconButton(
              tooltip: l10n.delete,
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                deleteHealthWithUndo(context, ref, id);
                context.pop();
              },
            ),
        ],
      ),
      body: entry != null
          ? _HealthForm(key: ValueKey(id), initial: entry)
          : Center(
              child: entries.isLoading
                  ? const CircularProgressIndicator()
                  : Text(l10n.healthEntryNotFound),
            ),
    );
  }
}

class _HealthForm extends ConsumerStatefulWidget {
  const _HealthForm({super.key, this.type, this.initial});

  final HealthType? type;
  final HealthEntry? initial;

  @override
  ConsumerState<_HealthForm> createState() => _HealthFormState();
}

class _HealthFormState extends ConsumerState<_HealthForm> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _note = TextEditingController();
  HealthTemplate? _template;
  late HealthType _type;
  late DateTime _date;
  DateTime? _nextDue;

  /// Once the user picks or clears the due date, stop recomputing it.
  bool _nextDueTouched = false;

  bool get _editing => widget.initial != null;

  @override
  void initState() {
    super.initState();
    final e = widget.initial;
    // Built-ins until the household's templates load (see build()).
    final templates =
        ref.read(healthTemplatesProvider).value ?? defaultHealthTemplates;
    _date = e?.date ?? ref.read(clockProvider)();
    if (e != null) {
      _type = e.type;
      _template = templates.where((t) => t.id == e.templateId).firstOrNull;
      _name.text = e.name;
      _note.text = e.note ?? '';
      _nextDue = e.nextDue;
      _nextDueTouched = true;
    } else {
      _type = widget.type ?? HealthType.vaccination;
      // Preselect the first template of the type.
      _selectTemplate(
        templates.where((t) => t.active && t.type == _type).firstOrNull,
      );
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _note.dispose();
    super.dispose();
  }

  void _selectTemplate(HealthTemplate? t) {
    _template = t;
    if (t != null) {
      _type = t.type;
      _name.text = t.name;
    } else {
      _name.clear();
    }
    _recomputeNextDue();
  }

  void _recomputeNextDue() {
    if (!_nextDueTouched) {
      _nextDue = nextDueFor(_date, _template?.intervalMonths);
    }
  }

  Future<void> _pickDate() async {
    final now = ref.read(clockProvider)();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(now.year - 20),
      lastDate: now,
    );
    if (picked == null) return;
    setState(() {
      _date = picked;
      _recomputeNextDue();
    });
  }

  Future<void> _pickNextDue() async {
    final initial = _nextDue ?? _date.add(const Duration(days: 30));
    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(_date) ? _date : initial,
      firstDate: _date,
      lastDate: DateTime(_date.year + 10),
    );
    if (picked == null) return;
    setState(() {
      _nextDue = picked;
      _nextDueTouched = true;
    });
  }

  void _save() {
    if (!_form.currentState!.validate()) return;
    final note = _note.text.trim();
    final controller = ref.read(healthControllerProvider.notifier);
    final e = widget.initial;
    if (e == null) {
      controller.add(
        HealthEntry(
          type: _type,
          templateId: _template?.id,
          name: _name.text.trim(),
          date: _date,
          nextDue: _nextDue,
          note: note.isEmpty ? null : note,
          by: '',
        ),
      );
    } else {
      controller.update(
        e.copyWith(
          name: _name.text.trim(),
          date: _date,
          nextDue: _nextDue,
          note: note.isEmpty ? null : note,
        ),
      );
    }
    context.pop();
  }

  /// When the household's version of the selected template arrives
  /// (e.g. a changed interval), use it for the computed due date.
  void _refreshTemplate(List<HealthTemplate>? loaded) {
    final current = _template;
    if (_editing || loaded == null || current == null) return;
    final fresh = loaded.where((t) => t.id == current.id).firstOrNull;
    if (fresh != null && fresh != current) {
      _template = fresh;
      _recomputeNextDue();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    _refreshTemplate(ref.watch(healthTemplatesProvider).value);
    final templates = [
      for (final t
          in ref.watch(healthTemplatesProvider).value ??
              const <HealthTemplate>[])
        if (t.active && (widget.type == null || t.type == widget.type)) t,
    ];
    final custom = _template == null;

    return Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          if (!_editing) ...[
            Text(l10n.healthTemplateLabel, style: textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final t in templates)
                  ChoiceChip(
                    label: Text(t.name),
                    avatar: Icon(t.type.icon, size: 18),
                    selected: _template?.id == t.id,
                    onSelected: (_) => setState(() => _selectTemplate(t)),
                  ),
                ChoiceChip(
                  key: const Key('healthOther'),
                  label: Text(l10n.healthOther),
                  selected: custom,
                  onSelected: (_) => setState(() => _selectTemplate(null)),
                ),
              ],
            ),
            if (custom && widget.type == null) ...[
              const SizedBox(height: 16),
              Text(l10n.healthTypeLabel, style: textTheme.labelLarge),
              const SizedBox(height: 8),
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
            ],
            const SizedBox(height: 8),
          ],
          if (custom || _editing)
            TextFormField(
              key: const Key('healthName'),
              controller: _name,
              maxLength: HealthLimits.maxNameLength,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: l10n.healthNameLabel),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null,
            ),
          ListTile(
            key: const Key('healthDate'),
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event),
            title: Text(l10n.healthDateLabel),
            trailing: Text(DateFormat.yMMMd().format(_date)),
            onTap: _pickDate,
          ),
          ListTile(
            key: const Key('healthNextDue'),
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event_repeat),
            title: Text(l10n.healthNextDueLabel),
            subtitle: Text(
              _nextDue == null
                  ? l10n.healthNextDueNone
                  : DateFormat.yMMMMd().format(_nextDue!),
            ),
            trailing: _nextDue == null
                ? null
                : IconButton(
                    tooltip: l10n.healthNextDueClear,
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() {
                      _nextDue = null;
                      _nextDueTouched = true;
                    }),
                  ),
            onTap: _pickNextDue,
          ),
          TextFormField(
            key: const Key('healthNote'),
            controller: _note,
            maxLength: HealthLimits.maxNoteLength,
            minLines: 1,
            maxLines: 4,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: l10n.eventNoteLabel),
          ),
          const SizedBox(height: 16),
          FilledButton(
            key: const Key('healthSave'),
            onPressed: _save,
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
