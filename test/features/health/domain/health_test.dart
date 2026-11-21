import 'package:dog_app/features/health/domain/health_entry.dart';
import 'package:dog_app/features/health/domain/health_reminder.dart';
import 'package:dog_app/features/health/domain/health_schedule.dart';
import 'package:dog_app/features/health/domain/health_template.dart';
import 'package:dog_app/features/settings/domain/reminder_settings.dart';
import 'package:flutter_test/flutter_test.dart';

final now = DateTime(2026, 11, 21, 10);

HealthEntry entry(
  String name, {
  HealthType type = HealthType.vaccination,
  String? templateId,
  required DateTime date,
  DateTime? nextDue,
  bool deleted = false,
}) => HealthEntry(
  type: type,
  templateId: templateId,
  name: name,
  date: date,
  nextDue: nextDue,
  by: 'u1',
  deleted: deleted,
);

void main() {
  test('nextDueFor adds the interval at noon; no interval, no due date', () {
    expect(nextDueFor(DateTime(2026, 11, 21, 9), 6), DateTime(2027, 5, 21, 12));
    expect(nextDueFor(DateTime(2026, 11, 21), null), isNull);
  });

  test('statusOf: overdue, soon (14 days), ok, none', () {
    expect(statusOf(DateTime(2026, 11, 20, 12), now), HealthStatus.overdue);
    expect(statusOf(DateTime(2026, 11, 21, 12), now), HealthStatus.soon);
    expect(statusOf(DateTime(2026, 12, 5, 12), now), HealthStatus.soon);
    expect(statusOf(DateTime(2026, 12, 6, 12), now), HealthStatus.ok);
    expect(statusOf(null, now), HealthStatus.none);
  });

  test('series keep the latest entry and sort by urgency', () {
    final series = healthSeries([
      entry(
        'Wścieklizna',
        templateId: 'rabies',
        date: DateTime(2025, 11, 1),
        nextDue: DateTime(2026, 11, 1),
      ),
      entry(
        'Wścieklizna',
        templateId: 'rabies',
        date: DateTime(2026, 11, 1),
        nextDue: DateTime(2027, 11, 1),
      ),
      entry(
        'Odrobaczanie',
        type: HealthType.deworming,
        templateId: 'deworming',
        date: DateTime(2026, 8, 1),
        nextDue: DateTime(2026, 11, 1),
      ),
      entry(
        'Lepto',
        date: DateTime(2026, 1, 1),
        nextDue: DateTime(2026, 12, 1),
      ),
      entry(
        'lepto ',
        date: DateTime(2025, 1, 1),
        nextDue: DateTime(2025, 12, 1),
      ),
      entry('Wizyta', type: HealthType.vet, date: DateTime(2026, 10, 1)),
      entry(
        'Usunięte',
        date: DateTime(2026, 1, 1),
        nextDue: DateTime(2026, 1, 2),
        deleted: true,
      ),
    ], now);

    expect(series.map((s) => s.latest.name), [
      'Odrobaczanie',
      'Lepto',
      'Wścieklizna',
      'Wizyta',
    ]);
    expect(series.map((s) => s.status), [
      HealthStatus.overdue,
      HealthStatus.soon, // 1 Dec is 10 days away.
      HealthStatus.ok,
      HealthStatus.none,
    ]);
    expect(attentionNeeded(series).map((s) => s.latest.name), [
      'Odrobaczanie',
      'Lepto',
    ]);
  });

  test('stored templates override defaults by id and add custom ones', () {
    final merged = mergeTemplates(const [
      HealthTemplate(
        id: 'tick_collar',
        name: 'Seresto',
        type: HealthType.ticks,
        intervalMonths: 8,
      ),
      HealthTemplate(id: 'c2', name: 'Zęby', type: HealthType.vet),
      HealthTemplate(
        id: 'c1',
        name: 'Borelioza',
        type: HealthType.vaccination,
        intervalMonths: 12,
      ),
    ]);
    expect(merged.map((t) => t.id), [
      'rabies',
      'dhppi',
      'deworming',
      'tick_collar',
      'vet_checkup',
      'c1',
      'c2',
    ]);
    expect(merged[3].name, 'Seresto');
    expect(merged[3].intervalMonths, 8);
    expect(merged.first.mandatory, isTrue);
    expect(
      defaultHealthTemplates
          .firstWhere((t) => t.id == 'tick_collar')
          .intervalMonths,
      6,
    );
  });

  group('planHealthReminders', () {
    const settings = ReminderSettings();
    List<HealthReminder> plan(
      List<HealthEntry> entries, {
      DateTime? at,
      ReminderSettings s = settings,
    }) => planHealthReminders(
      series: healthSeries(entries, at ?? now),
      settings: s,
      now: at ?? now,
    );

    test('7 days before and on the day at the reminder hour', () {
      final r = plan([
        entry(
          'Wścieklizna',
          templateId: 'rabies',
          date: DateTime(2025, 12, 10),
          nextDue: DateTime(2026, 12, 10, 12),
        ),
      ]);
      expect(r.map((x) => (x.kind, x.at)), [
        (HealthReminderKind.before, DateTime(2026, 12, 3, 18)),
        (HealthReminderKind.due, DateTime(2026, 12, 10, 18)),
      ]);
    });

    test('vet visits remind one day before', () {
      final r = plan([
        entry(
          'Kontrola',
          type: HealthType.vet,
          date: DateTime(2026, 1, 1),
          nextDue: DateTime(2026, 12, 10, 12),
        ),
      ]);
      expect(r.first.at, DateTime(2026, 12, 9, 18));
    });

    test('inside the "before" window only the due reminder remains', () {
      final r = plan([
        entry(
          'X',
          date: DateTime(2026, 1, 1),
          nextDue: DateTime(2026, 11, 25, 12),
        ),
      ]);
      expect(r.map((x) => x.kind), [HealthReminderKind.due]);
    });

    test('overdue: next reminder hour, today or tomorrow', () {
      final overdue = [
        entry(
          'X',
          date: DateTime(2026, 1, 1),
          nextDue: DateTime(2026, 11, 1, 12),
        ),
      ];
      expect(plan(overdue).single.at, DateTime(2026, 11, 21, 18));
      expect(plan(overdue).single.kind, HealthReminderKind.overdue);
      expect(
        plan(overdue, at: DateTime(2026, 11, 21, 19)).single.at,
        DateTime(2026, 11, 22, 18),
      );
    });

    test('custom days before, disabled, and undated series', () {
      final e = [
        entry(
          'X',
          date: DateTime(2026, 1, 1),
          nextDue: DateTime(2026, 12, 31, 12),
        ),
      ];
      expect(
        plan(e, s: const ReminderSettings(healthDaysBefore: 14)).first.at,
        DateTime(2026, 12, 17, 18),
      );
      expect(plan(e, s: const ReminderSettings(healthEnabled: false)), isEmpty);
      expect(
        plan([
          entry('Wizyta', type: HealthType.vet, date: DateTime(2026, 1, 1)),
        ]),
        isEmpty,
      );
    });
  });
}
