import '../../settings/domain/reminder_settings.dart';
import 'food.dart';
import 'stock_forecast.dart';

/// A planned "kup karmę" notification.
class FoodReminder {
  const FoodReminder({
    required this.foodId,
    required this.at,
    required this.remainingKg,
    required this.daysLeft,
  });

  final String foodId;
  final DateTime at;

  /// Predicted stock at [at].
  final double remainingKg;

  /// Predicted days of food left at [at]; null if the pace is unknown.
  final double? daysLeft;

  @override
  bool operator ==(Object other) =>
      other is FoodReminder &&
      other.foodId == foodId &&
      other.at == at &&
      other.remainingKg == remainingKg &&
      other.daysLeft == daysLeft;

  @override
  int get hashCode => Object.hash(foodId, at, remainingKg, daysLeft);

  @override
  String toString() => 'FoodReminder($foodId, $at, $remainingKg kg)';
}

/// Reminder for [food] at the settings' hour on the day its stock reaches
/// the threshold; if that moment has passed, at the next such hour.
FoodReminder? planFoodReminder({
  required Food food,
  required StockForecast stock,
  required ReminderSettings settings,
  required DateTime now,
}) {
  if (!settings.foodEnabled || !food.active) return null;
  final below = stock.whenBelow(settings.foodThresholdKg, now);
  if (below == null) return null;

  DateTime atHour(DateTime day) =>
      DateTime(day.year, day.month, day.day, settings.hour, settings.minute);
  var at = atHour(below);
  if (!at.isAfter(now)) at = atHour(now);
  if (!at.isAfter(now)) at = atHour(DateTime(now.year, now.month, now.day + 1));

  final remaining = stock.remainingAt(at, now);
  final avg = stock.avgGramsPerDay;
  return FoodReminder(
    foodId: food.id,
    at: at,
    remainingKg: remaining,
    daysLeft: (avg == null || avg <= 0) ? null : remaining * 1000 / avg,
  );
}
