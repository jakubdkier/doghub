import 'package:freezed_annotation/freezed_annotation.dart';

import '../../events/domain/event_timeline.dart';

part 'med.freezed.dart';

/// Stored as [name]; must match firestore.rules.
enum MedScheduleType { daily, interval }

/// Time of day of a dose; stored as "HH:mm".
@freezed
abstract class MedTime with _$MedTime implements Comparable<MedTime> {
  const factory MedTime(int hour, int minute) = _MedTime;

  const MedTime._();

  static MedTime? parse(String s) {
    final m = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$').firstMatch(s);
    return m == null ? null : MedTime(int.parse(m[1]!), int.parse(m[2]!));
  }

  String get label =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  DateTime on(DateTime day) =>
      DateTime(day.year, day.month, day.day, hour, minute);

  @override
  int compareTo(MedTime other) =>
      (hour * 60 + minute).compareTo(other.hour * 60 + other.minute);
}

/// Bounds shared with `validMed()` in firestore.rules.
abstract final class MedLimits {
  static const maxTimes = 3;
  static const minIntervalDays = 2;
  static const maxIntervalDays = 60;
  static const maxNameLength = 50;
  static const maxDoseLength = 50;
  static const maxNoteLength = 500;
}

@freezed
abstract class Med with _$Med {
  const factory Med({
    required String id,
    required String name,

    /// E.g. "1 tabletka".
    String? dose,
    @Default(MedScheduleType.daily) MedScheduleType scheduleType,

    /// Daily: 1-3 times. Interval: the first time is used.
    required List<MedTime> times,

    /// Every N days (interval schedules only).
    int? intervalDays,

    /// First day of the course.
    required DateTime startDate,

    /// Last day of the course; null = open-ended.
    DateTime? endDate,
    @Default(true) bool active,
    String? note,
    DateTime? createdAt,
  }) = _Med;

  const Med._();

  List<MedTime> get sortedTimes => [...times]..sort();

  /// Scheduled doses on [day] (empty when not a dosing day).
  List<DateTime> slotsOn(DateTime day) {
    final d = startOfDay(day);
    if (!active) return const [];
    if (d.isBefore(startOfDay(startDate))) return const [];
    if (endDate != null && d.isAfter(startOfDay(endDate!))) return const [];
    switch (scheduleType) {
      case MedScheduleType.daily:
        return [for (final t in sortedTimes) t.on(d)];
      case MedScheduleType.interval:
        final every = intervalDays ?? MedLimits.minIntervalDays;
        // Whole days since the start; rounding absorbs DST hours.
        final days = (d.difference(startOfDay(startDate)).inMinutes / 1440)
            .round();
        if (days % every != 0) return const [];
        return [sortedTimes.first.on(d)];
    }
  }
}
