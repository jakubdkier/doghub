import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder_settings.freezed.dart';

/// Per-device reminder preferences (each device schedules its own).
@freezed
abstract class ReminderSettings with _$ReminderSettings {
  static const minThresholdKg = 0.5;
  static const maxThresholdKg = 10.0;

  /// "Zważ psa" comes this long after the last measurement.
  static const weighIntervalDays = 30;

  static const minHealthDaysBefore = 1;
  static const maxHealthDaysBefore = 30;

  const factory ReminderSettings({
    @Default(true) bool foodEnabled,

    /// Remind when a food's stock drops to this many kg.
    @Default(2.0) double foodThresholdKg,
    @Default(true) bool weighEnabled,
    @Default(true) bool healthEnabled,
    @Default(true) bool medsEnabled,

    /// Health reminder this many days before the due date (vet: 1 day).
    @Default(7) int healthDaysBefore,
    @Default(18) int hour,
    @Default(0) int minute,
  }) = _ReminderSettings;
}
