import 'package:dog_app/features/settings/domain/reminder_settings.dart';
import 'package:dog_app/features/weight/domain/weigh_reminder.dart';
import 'package:dog_app/features/weight/domain/weight_entry.dart';
import 'package:dog_app/features/weight/domain/weight_stats.dart';
import 'package:flutter_test/flutter_test.dart';

final now = DateTime(2026, 11, 21, 10);

WeightEntry w(double kg, DateTime at, {bool deleted = false}) =>
    WeightEntry(kg: kg, at: weighDay(at), by: 'u1', deleted: deleted);

void main() {
  final entries = [
    w(10, DateTime(2025, 6, 1)),
    w(11, DateTime(2026, 3, 1)),
    w(12, DateTime(2026, 9, 1)),
    w(99, DateTime(2026, 10, 1), deleted: true),
    w(12.4, DateTime(2026, 11, 3)),
    w(12.7, DateTime(2026, 11, 20)),
  ];

  test('weightsInRange filters by range, oldest first, drops deleted', () {
    List<double> kgs(WeightRange r) =>
        weightsInRange(entries, r, now).map((e) => e.kg).toList();
    expect(kgs(WeightRange.threeMonths), [12, 12.4, 12.7]);
    expect(kgs(WeightRange.sixMonths), [12, 12.4, 12.7]);
    expect(kgs(WeightRange.year), [11, 12, 12.4, 12.7]);
    expect(kgs(WeightRange.all), [10, 11, 12, 12.4, 12.7]);
  });

  test('summary compares the latest with the previous measurement', () {
    final s = summarizeWeights(entries)!;
    expect(s.latest.kg, 12.7);
    expect(s.previous!.kg, 12.4);
    expect(s.change, 0.3);
    expect(summarizeWeights([w(5, now)])!.change, isNull);
    expect(summarizeWeights(const []), isNull);
  });

  group('planWeighReminder', () {
    const settings = ReminderSettings();

    test('30 days after the last measurement at the reminder hour', () {
      final at = planWeighReminder(
        latest: w(12, DateTime(2026, 11, 20)),
        settings: settings,
        now: now,
      );
      expect(at, DateTime(2026, 12, 20, 18));
    });

    test('overdue: today at the hour, or tomorrow once it has passed', () {
      final old = w(12, DateTime(2026, 9, 1));
      expect(
        planWeighReminder(latest: old, settings: settings, now: now),
        DateTime(2026, 11, 21, 18),
      );
      expect(
        planWeighReminder(
          latest: old,
          settings: settings,
          now: DateTime(2026, 11, 21, 20),
        ),
        DateTime(2026, 11, 22, 18),
      );
    });

    test('nothing when disabled or never weighed', () {
      expect(
        planWeighReminder(
          latest: w(12, now),
          settings: const ReminderSettings(weighEnabled: false),
          now: now,
        ),
        isNull,
      );
      expect(
        planWeighReminder(latest: null, settings: settings, now: now),
        isNull,
      );
    });
  });
}
