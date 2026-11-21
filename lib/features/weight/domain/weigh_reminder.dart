import '../../settings/domain/reminder_settings.dart';
import 'weight_entry.dart';

/// Next "zważ psa" reminder: [ReminderSettings.weighIntervalDays] after
/// the last measurement, at the settings' hour; if that has passed, at the
/// next such hour. Null when disabled or there is nothing to compare with.
DateTime? planWeighReminder({
  required WeightEntry? latest,
  required ReminderSettings settings,
  required DateTime now,
}) {
  if (!settings.weighEnabled || latest == null) return null;
  final due = latest.at.add(
    const Duration(days: ReminderSettings.weighIntervalDays),
  );
  DateTime atHour(DateTime d) =>
      DateTime(d.year, d.month, d.day, settings.hour, settings.minute);
  var at = atHour(due);
  if (!at.isAfter(now)) at = atHour(now);
  if (!at.isAfter(now)) at = atHour(DateTime(now.year, now.month, now.day + 1));
  return at;
}
