import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../food/application/food_providers.dart';
import '../../food/domain/food.dart';
import '../../food/presentation/food_dialog.dart';
import '../application/event_providers.dart';
import '../domain/dog_event.dart';
import '../domain/event_timeline.dart';
import 'event_labels.dart';

/// Form for a new event of [type], or for editing [initial].
/// Calls [onSaved] after the (offline-safe) write was issued.
class EventForm extends ConsumerStatefulWidget {
  const EventForm({
    super.key,
    required this.type,
    this.initial,
    required this.onSaved,
  });

  final EventType type;
  final DogEvent? initial;
  final VoidCallback onSaved;

  @override
  ConsumerState<EventForm> createState() => _EventFormState();
}

class _EventFormState extends ConsumerState<EventForm> {
  final _form = GlobalKey<FormState>();
  late DateTime _at;
  late final TextEditingController _grams;
  late final TextEditingController _duration;
  late final TextEditingController _note;
  String? _foodId;
  late int _poopScore;
  late PoopColor _poopColor;

  EventType get _type => widget.type;

  @override
  void initState() {
    super.initState();
    final now = ref.read(clockProvider)();
    final e = widget.initial;
    final defaults = mealDefaults(ref.read(recentEventsProvider).value ?? []);
    _at = e?.at ?? now;
    _grams = TextEditingController(
      text: (e?.grams ?? (e == null ? defaults.grams : null))?.toString(),
    );
    _foodId = e == null ? _defaultFoodId(defaults.foodId) : e.foodId;
    _duration = TextEditingController(text: (e?.durationMin ?? 30).toString());
    _note = TextEditingController(text: e?.note);
    _poopScore = e?.poopScore ?? 4;
    _poopColor = e?.poopColor ?? PoopColor.brown;
  }

  /// Last meal's food if still in use, else the only food in use.
  String? _defaultFoodId(String? lastFoodId) {
    final active = (ref.read(foodsProvider).value ?? const <Food>[])
        .where((f) => f.active)
        .toList();
    if (active.any((f) => f.id == lastFoodId)) return lastFoodId;
    return active.length == 1 ? active.single.id : null;
  }

  @override
  void dispose() {
    _grams.dispose();
    _duration.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final now = ref.read(clockProvider)();
    final date = await showDatePicker(
      context: context,
      initialDate: _at,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now,
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_at),
    );
    if (time == null) return;
    final picked = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    // Events can't be in the future (also enforced by the rules).
    setState(() => _at = picked.isAfter(now) ? now : picked);
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
    if (!_form.currentState!.validate()) return;
    final note = _note.text.trim();
    final draft = DogEvent(
      id: widget.initial?.id,
      type: _type,
      at: _at,
      by: widget.initial?.by ?? '',
      createdAt: widget.initial?.createdAt,
      deleted: widget.initial?.deleted ?? false,
      note: note.isEmpty ? null : note,
      grams: _type == EventType.meal ? int.tryParse(_grams.text) : null,
      foodId: _type == EventType.meal ? _foodId : null,
      poopScore: _type == EventType.poop ? _poopScore : null,
      poopColor: _type == EventType.poop ? _poopColor : null,
      durationMin: _type == EventType.walk
          ? int.tryParse(_duration.text)
          : null,
    );
    final controller = ref.read(eventControllerProvider.notifier);
    if (widget.initial == null) {
      controller.add(draft);
    } else {
      controller.update(draft);
    }
    widget.onSaved();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final now = ref.watch(clockProvider)();
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...switch (_type) {
            EventType.meal => _mealFields(l10n),
            EventType.poop => _poopFields(l10n),
            EventType.walk => _walkFields(l10n),
            EventType.pee || EventType.note => const <Widget>[],
          },
          ListTile(
            key: const Key('eventTime'),
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: Text(l10n.eventTimeLabel),
            trailing: Text(formatDayTime(l10n, _at, now)),
            onTap: _pickTime,
          ),
          TextFormField(
            key: const Key('eventNote'),
            controller: _note,
            maxLength: EventLimits.maxNoteLength,
            minLines: 1,
            maxLines: 4,
            autofocus: _type == EventType.note,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: _type == EventType.note
                  ? l10n.eventNote
                  : l10n.eventNoteLabel,
            ),
            validator: (v) =>
                _type == EventType.note && (v == null || v.trim().isEmpty)
                ? l10n.eventNoteRequired
                : null,
          ),
          const SizedBox(height: 16),
          FilledButton(
            key: const Key('eventSave'),
            onPressed: _save,
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  List<Widget> _mealFields(AppLocalizations l10n) {
    final foods = ref.watch(foodsProvider).value ?? const <Food>[];
    final visible = foods.where((f) => f.active || f.id == _foodId);
    return [
      Text(l10n.mealFoodLabel, style: Theme.of(context).textTheme.labelLarge),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          for (final food in visible)
            ChoiceChip(
              label: Text(food.label),
              selected: food.id == _foodId,
              onSelected: (selected) =>
                  setState(() => _foodId = selected ? food.id : null),
            ),
          ActionChip(
            avatar: const Icon(Icons.add),
            label: Text(l10n.addFood),
            onPressed: _addFood,
          ),
        ],
      ),
      const SizedBox(height: 8),
      TextFormField(
        key: const Key('mealGrams'),
        controller: _grams,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: l10n.mealGramsLabel,
          suffixText: 'g',
        ),
        validator: (v) {
          final g = int.tryParse(v ?? '');
          return (g == null || g < 1 || g > EventLimits.maxGrams)
              ? l10n.mealGramsInvalid
              : null;
        },
      ),
    ];
  }

  List<Widget> _poopFields(AppLocalizations l10n) {
    final textTheme = Theme.of(context).textTheme;
    return [
      Text(l10n.poopScoreLabel, style: textTheme.labelLarge),
      const SizedBox(height: 8),
      Row(
        children: [
          for (
            var s = EventLimits.minPoopScore;
            s <= EventLimits.maxPoopScore;
            s++
          )
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _ScoreButton(
                  score: s,
                  selected: s == _poopScore,
                  onPressed: () => setState(() => _poopScore = s),
                ),
              ),
            ),
        ],
      ),
      const SizedBox(height: 4),
      Text(
        bristolDescription(l10n, _poopScore),
        textAlign: TextAlign.center,
        style: textTheme.bodySmall,
      ),
      const SizedBox(height: 16),
      Text(l10n.poopColorLabel, style: textTheme.labelLarge),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          for (final c in PoopColor.values)
            ChoiceChip(
              label: Text(c.label(l10n)),
              selected: c == _poopColor,
              onSelected: (_) => setState(() => _poopColor = c),
            ),
        ],
      ),
    ];
  }

  List<Widget> _walkFields(AppLocalizations l10n) => [
    Wrap(
      spacing: 8,
      children: [
        for (final m in EventLimits.walkPresetsMin)
          ChoiceChip(
            label: Text(l10n.minutesValue(m)),
            selected: _duration.text == '$m',
            onSelected: (_) => setState(() => _duration.text = '$m'),
          ),
      ],
    ),
    TextFormField(
      key: const Key('walkDuration'),
      controller: _duration,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        labelText: l10n.walkDurationLabel,
        suffixText: 'min',
      ),
      validator: (v) {
        final m = int.tryParse(v ?? '');
        return (m == null || m < 1 || m > EventLimits.maxDurationMin)
            ? l10n.walkDurationInvalid
            : null;
      },
    ),
  ];
}

class _ScoreButton extends StatelessWidget {
  const _ScoreButton({
    required this.score,
    required this.selected,
    required this.onPressed,
  });

  final int score;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(0, 52)),
      padding: WidgetStatePropertyAll(EdgeInsets.zero),
    );
    final child = Text(
      '$score',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    );
    return selected
        ? FilledButton(
            key: Key('poopScore$score'),
            style: style,
            onPressed: onPressed,
            child: child,
          )
        : OutlinedButton(
            key: Key('poopScore$score'),
            style: style,
            onPressed: onPressed,
            child: child,
          );
  }
}
