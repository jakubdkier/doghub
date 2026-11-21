import '../../events/domain/event_timeline.dart';
import '../../settings/domain/reminder_settings.dart';
import 'med.dart';
import 'med_dose.dart';

/// One scheduled dose and whether (and by whom) it was given.
class DoseSlot {
  const DoseSlot({required this.med, required this.slot, this.dose});

  final Med med;
  final DateTime slot;

  /// The non-deleted check-off, if given.
  final MedDose? dose;

  bool get given => dose != null;
}

Map<String, MedDose> _givenById(Iterable<MedDose> doses) => {
  for (final d in doses)
    if (!d.deleted) d.id: d,
};

/// All doses due on [day] across [meds], by time then name.
List<DoseSlot> dosesOn(
  Iterable<Med> meds,
  Iterable<MedDose> doses,
  DateTime day,
) {
  final given = _givenById(doses);
  return [
    for (final m in meds)
      for (final slot in m.slotsOn(day))
        DoseSlot(med: m, slot: slot, dose: given[doseId(m.id, slot)]),
  ]..sort((a, b) {
    final c = a.slot.compareTo(b.slot);
    return c != 0 ? c : a.med.name.compareTo(b.med.name);
  });
}

/// Given vs expected doses of [med] over the last [days] days incl. today
/// (today's not-yet-due doses don't count as expected).
({int given, int expected}) adherence(
  Med med,
  Iterable<MedDose> doses,
  DateTime now, {
  int days = 7,
}) {
  final given = _givenById(doses);
  var g = 0, e = 0;
  final today = startOfDay(now);
  for (var i = 0; i < days; i++) {
    final day = DateTime(today.year, today.month, today.day - i);
    for (final slot in med.slotsOn(day)) {
      final isGiven = given.containsKey(doseId(med.id, slot));
      if (slot.isAfter(now) && !isGiven) continue;
      e++;
      if (isGiven) g++;
    }
  }
  return (given: g, expected: e);
}

/// Reminders at each not-yet-given dose in the next [days] days.
List<DoseSlot> planMedReminders({
  required Iterable<Med> meds,
  required Iterable<MedDose> doses,
  required ReminderSettings settings,
  required DateTime now,
  int days = 7,
}) {
  if (!settings.medsEnabled) return const [];
  final today = startOfDay(now);
  return [
    for (var i = 0; i < days; i++)
      for (final s in dosesOn(
        meds,
        doses,
        DateTime(today.year, today.month, today.day + i),
      ))
        if (!s.given && s.slot.isAfter(now)) s,
  ];
}
