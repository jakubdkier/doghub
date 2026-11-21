import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder_settings.freezed.dart';

/// Per-device reminder preferences (each device schedules its own).
@freezed
abstract class ReminderSettings with _$ReminderSettings {
  static const minThresholdKg = 0.5;
  static const maxThresholdKg = 10.0;

  const factory ReminderSettings({
    @Default(true) bool foodEnabled,

    /// Remind when a food's stock drops to this many kg.
    @Default(2.0) double foodThresholdKg,
    @Default(18) int hour,
    @Default(0) int minute,
  }) = _ReminderSettings;
}
