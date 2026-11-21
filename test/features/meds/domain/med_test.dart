import 'package:dog_app/features/meds/domain/med.dart';
import 'package:dog_app/features/meds/domain/med_dose.dart';
import 'package:dog_app/features/meds/domain/med_schedule.dart';
import 'package:dog_app/features/settings/domain/reminder_settings.dart';
import 'package:flutter_test/flutter_test.dart';

final now = DateTime(2026, 11, 21, 12);

Med magnesium({
  List<MedTime> times = const [MedTime(8, 0)],
  MedScheduleType type = MedScheduleType.daily,
  int? every,
  DateTime? start,
  DateTime? end,
  bool active = true,
}) => Med(
  id: 'm1',
  name: 'Magnez',
  times: times,
  scheduleType: type,
  intervalDays: every,
  startDate: start ?? DateTime(2026, 11, 1, 12),
  endDate: end,
  active: active,
);

MedDose given(DateTime slot, {bool deleted = false, String by = 'u1'}) =>
    MedDose(medId: 'm1', slot: slot, givenAt: slot, by: by, deleted: deleted);

void main() {
  test('MedTime parses, labels and sorts', () {
    expect(MedTime.parse('08:05'), const MedTime(8, 5));
    expect(MedTime.parse('8:05'), isNull);
    expect(MedTime.parse('24:00'), isNull);
    expect(const MedTime(7, 0).label, '07:00');
    expect([const MedTime(20, 0), const MedTime(8, 0)]..sort(), [
      const MedTime(8, 0),
      const MedTime(20, 0),
    ]);
  });

  test('doseId is deterministic per med and slot', () {
    expect(doseId('m1', DateTime(2026, 11, 21, 8, 5)), 'm1_20261121_0805');
  });

  group('slotsOn', () {
    test('daily: every time, sorted, within the course', () {
      final m = magnesium(
        times: const [MedTime(20, 0), MedTime(8, 0)],
        end: DateTime(2026, 11, 25, 12),
      );
      expect(m.slotsOn(now), [
        DateTime(2026, 11, 21, 8),
        DateTime(2026, 11, 21, 20),
      ]);
      expect(m.slotsOn(DateTime(2026, 10, 31)), isEmpty);
      expect(m.slotsOn(DateTime(2026, 11, 25)), hasLength(2));
      expect(m.slotsOn(DateTime(2026, 11, 26)), isEmpty);
      expect(magnesium(active: false).slotsOn(now), isEmpty);
    });

    test('every N days from the start date', () {
      final m = magnesium(type: MedScheduleType.interval, every: 3);
      expect(m.slotsOn(DateTime(2026, 11, 1)), [DateTime(2026, 11, 1, 8)]);
      expect(m.slotsOn(DateTime(2026, 11, 2)), isEmpty);
      expect(m.slotsOn(DateTime(2026, 11, 4)), [DateTime(2026, 11, 4, 8)]);
      // Across the end of October DST change (25 Oct 2026 in Poland).
      final dst = magnesium(
        type: MedScheduleType.interval,
        every: 2,
        start: DateTime(2026, 10, 24, 12),
      );
      expect(dst.slotsOn(DateTime(2026, 10, 26)), hasLength(1));
      expect(dst.slotsOn(DateTime(2026, 10, 27)), isEmpty);
    });
  });

  test('dosesOn marks given doses; unticked ones count as not given', () {
    final m = magnesium(times: const [MedTime(8, 0), MedTime(20, 0)]);
    final slots = dosesOn(
      [m],
      [
        given(DateTime(2026, 11, 21, 8), by: 'alice'),
        given(DateTime(2026, 11, 21, 20), deleted: true),
      ],
      now,
    );
    expect(slots.map((s) => (s.slot.hour, s.given)), [(8, true), (20, false)]);
    expect(slots.first.dose!.by, 'alice');
  });

  test('adherence over 7 days ignores doses not yet due', () {
    final m = magnesium(times: const [MedTime(8, 0), MedTime(20, 0)]);
    final doses = [
      for (var d = 15; d <= 21; d++) given(DateTime(2026, 11, d, 8)),
      given(DateTime(2026, 11, 20, 20)),
    ];
    // 7 mornings + 6 past evenings (today's 20:00 is still ahead).
    expect(adherence(m, doses, now), (given: 8, expected: 13));
  });

  test('reminders for not-given doses in the next 7 days', () {
    final m = magnesium(times: const [MedTime(8, 0), MedTime(20, 0)]);
    final plan = planMedReminders(
      meds: [m],
      doses: [given(DateTime(2026, 11, 22, 8))],
      settings: const ReminderSettings(),
      now: now,
    );
    expect(plan.first.slot, DateTime(2026, 11, 21, 20));
    expect(plan.map((s) => s.slot), isNot(contains(DateTime(2026, 11, 22, 8))));
    expect(plan.map((s) => s.slot), isNot(contains(DateTime(2026, 11, 21, 8))));
    expect(plan, hasLength(12));
    expect(
      planMedReminders(
        meds: [m],
        doses: const [],
        settings: const ReminderSettings(medsEnabled: false),
        now: now,
      ),
      isEmpty,
    );
  });
}
