import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../events/domain/event_timeline.dart';
import '../../household/application/household_providers.dart';
import '../../settings/application/reminder_settings_provider.dart';
import '../application/med_providers.dart';
import '../domain/med.dart';
import '../domain/med_dose.dart';
import '../domain/med_schedule.dart';

/// `/health/meds/new` and `/health/meds/:id` (with 30-day history).
class MedFormPage extends ConsumerWidget {
  const MedFormPage({super.key, this.medId});

  final String? medId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = medId;
    if (id == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.medAdd)),
        body: const _MedForm(),
      );
    }
    final meds = ref.watch(medsProvider);
    final med = meds.value?.where((m) => m.id == id).firstOrNull;
    return Scaffold(
      appBar: AppBar(title: Text(med?.name ?? l10n.medEdit)),
      body: med != null
          ? _MedForm(key: ValueKey(id), initial: med)
          : Center(
              child: meds.isLoading
                  ? const CircularProgressIndicator()
                  : Text(l10n.medNotFound),
            ),
    );
  }
}

class _MedForm extends ConsumerStatefulWidget {
  const _MedForm({super.key, this.initial});

  final Med? initial;

  @override
  ConsumerState<_MedForm> createState() => _MedFormState();
}

class _MedFormState extends ConsumerState<_MedForm> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.initial?.name);
  late final _dose = TextEditingController(text: widget.initial?.dose);
  late final _note = TextEditingController(text: widget.initial?.note);
  late final _interval = TextEditingController(
    text: '${widget.initial?.intervalDays ?? MedLimits.minIntervalDays}',
  );
  late MedScheduleType _type =
      widget.initial?.scheduleType ?? MedScheduleType.daily;
  late List<MedTime> _times = [...?widget.initial?.sortedTimes]
      .ifEmpty(const [MedTime(8, 0)]);
  late DateTime _start = widget.initial?.startDate ?? ref.read(clockProvider)();
  late DateTime? _end = widget.initial?.endDate;
  late bool _active = widget.initial?.active ?? true;

  @override
  void dispose() {
    _name.dispose();
    _dose.dispose();
    _note.dispose();
    _interval.dispose();
    super.dispose();
  }

  Future<MedTime?> _pickTime(MedTime initial) async {
    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initial.hour, minute: initial.minute),
    );
    return t == null ? null : MedTime(t.hour, t.minute);
  }

  Future<DateTime?> _pickDate(DateTime initial, DateTime first) =>
      showDatePicker(
        context: context,
        initialDate: initial.isBefore(first) ? first : initial,
        firstDate: first,
        lastDate: DateTime(first.year + 5),
      );

  void _save() {
    if (!_form.currentState!.validate()) return;
    final dose = _dose.text.trim();
    final note = _note.text.trim();
    final times = _type == MedScheduleType.interval
        ? [_times.first]
        : (_times.toSet().toList()..sort());
    ref
        .read(medControllerProvider.notifier)
        .save(
          Med(
            id: widget.initial?.id ?? '',
            name: _name.text.trim(),
            dose: dose.isEmpty ? null : dose,
            scheduleType: _type,
            times: times,
            intervalDays: _type == MedScheduleType.interval
                ? int.parse(_interval.text)
                : null,
            startDate: _start,
            endDate: _end,
            active: _active,
            note: note.isEmpty ? null : note,
          ),
        );
    // Dose reminders need exact times; ask for both permissions once.
    final settings = ref.read(reminderSettingsControllerProvider.notifier);
    settings.ensurePermission().then((_) => settings.ensureExactPermission());
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final daily = _type == MedScheduleType.daily;
    final shownTimes = daily ? _times : _times.take(1).toList();

    return Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextFormField(
            key: const Key('medName'),
            controller: _name,
            maxLength: MedLimits.maxNameLength,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: l10n.medNameLabel),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? l10n.fieldRequired : null,
          ),
          TextFormField(
            key: const Key('medDose'),
            controller: _dose,
            maxLength: MedLimits.maxDoseLength,
            decoration: InputDecoration(labelText: l10n.medDoseLabel),
          ),
          SegmentedButton<MedScheduleType>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: MedScheduleType.daily,
                label: Text(l10n.medScheduleDaily),
              ),
              ButtonSegment(
                value: MedScheduleType.interval,
                label: Text(l10n.medScheduleInterval),
              ),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() => _type = s.single),
          ),
          if (!daily)
            TextFormField(
              key: const Key('medInterval'),
              controller: _interval,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: l10n.medIntervalLabel),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                return (n == null ||
                        n < MedLimits.minIntervalDays ||
                        n > MedLimits.maxIntervalDays)
                    ? l10n.medIntervalInvalid
                    : null;
              },
            ),
          const SizedBox(height: 16),
          Text(l10n.medTimesLabel, style: textTheme.labelLarge),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (final (i, t) in shownTimes.indexed)
                InputChip(
                  key: Key('medTime-$i'),
                  label: Text(t.label),
                  onPressed: () async {
                    final picked = await _pickTime(t);
                    if (picked != null) {
                      setState(() => _times = [..._times]..[i] = picked);
                    }
                  },
                  onDeleted: shownTimes.length > 1
                      ? () => setState(() => _times = [..._times]..removeAt(i))
                      : null,
                  deleteButtonTooltipMessage: l10n.medRemoveTime,
                ),
              if (daily && _times.length < MedLimits.maxTimes)
                ActionChip(
                  key: const Key('medAddTime'),
                  avatar: const Icon(Icons.add),
                  label: Text(l10n.medAddTime),
                  onPressed: () async {
                    final picked = await _pickTime(const MedTime(20, 0));
                    if (picked != null) {
                      setState(() => _times = [..._times, picked]..sort());
                    }
                  },
                ),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event),
            title: Text(l10n.medStartLabel),
            trailing: Text(DateFormat.yMMMd().format(_start)),
            onTap: () async {
              final now = ref.read(clockProvider)();
              final picked = await _pickDate(_start, DateTime(now.year - 2));
              if (picked != null) {
                setState(() {
                  _start = picked;
                  if (_end != null && _end!.isBefore(picked)) _end = picked;
                });
              }
            },
          ),
          ListTile(
            key: const Key('medEnd'),
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event_busy),
            title: Text(l10n.medEndLabel),
            subtitle: Text(
              _end == null
                  ? l10n.medEndNone
                  : DateFormat.yMMMMd().format(_end!),
            ),
            trailing: _end == null
                ? null
                : IconButton(
                    tooltip: l10n.medEndClear,
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() => _end = null),
                  ),
            onTap: () async {
              final picked = await _pickDate(
                _end ?? _start.add(const Duration(days: 7)),
                startOfDay(_start),
              );
              if (picked != null) setState(() => _end = picked);
            },
          ),
          TextFormField(
            controller: _note,
            maxLength: MedLimits.maxNoteLength,
            minLines: 1,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: l10n.eventNoteLabel),
          ),
          if (widget.initial != null)
            SwitchListTile(
              key: const Key('medActive'),
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.medActive),
              value: _active,
              onChanged: (v) => setState(() => _active = v),
            ),
          const SizedBox(height: 16),
          FilledButton(
            key: const Key('medSave'),
            onPressed: _save,
            child: Text(l10n.save),
          ),
          if (widget.initial case final med?) _History(med: med),
        ],
      ),
    );
  }
}

/// Last 30 days of scheduled doses, newest first.
class _History extends ConsumerWidget {
  const _History({required this.med});

  final Med med;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final now = ref.watch(clockProvider)();
    final doses = ref.watch(medDosesProvider).value ?? const <MedDose>[];
    final household = ref.watch(currentHouseholdProvider).value;
    final today = startOfDay(now);
    final slots = [
      for (var i = 0; i < 30; i++)
        ...dosesOn(
          [med],
          doses,
          DateTime(today.year, today.month, today.day - i),
        ).reversed.where((s) => !s.slot.isAfter(now)),
    ];
    if (slots.isEmpty) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(l10n.medHistory, style: Theme.of(context).textTheme.titleSmall),
        for (final s in slots)
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              s.given ? Icons.check_circle : Icons.cancel_outlined,
              color: s.given ? scheme.primary : scheme.error,
            ),
            title: Text(DateFormat.MMMEd().add_Hm().format(s.slot)),
            subtitle: Text(switch (s.dose) {
              final d? => l10n.medGivenBy(
                household?.nameOf(d.by) ?? '',
                DateFormat.Hm().format(d.givenAt),
              ),
              null => l10n.medNotGiven,
            }),
          ),
      ],
    );
  }
}

extension<T> on List<T> {
  List<T> ifEmpty(List<T> fallback) => isEmpty ? fallback : this;
}
