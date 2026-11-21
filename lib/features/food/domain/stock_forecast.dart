import 'dart:math' as math;

import '../../events/domain/dog_event.dart';
import '../../events/domain/event_timeline.dart';
import 'purchase.dart';

/// Food stock computed on the device: purchases minus meals (no stock
/// document, no transactions; see CLAUDE.md).
class StockForecast {
  const StockForecast({
    required this.purchasedKg,
    required this.consumedKg,
    required this.avgGramsPerDay,
  });

  static const averageWindowDays = 14;

  final double purchasedKg;
  final double consumedKg;

  /// Average daily use over the last [averageWindowDays] days (or since the
  /// first meal of this food, if more recent). Null without recent meals.
  final double? avgGramsPerDay;

  bool get hasPurchases => purchasedKg > 0;

  double get remainingKg => math.max(0, purchasedKg - consumedKg);

  double? get daysLeft {
    final avg = avgGramsPerDay;
    if (!hasPurchases || avg == null || avg <= 0) return null;
    return remainingKg * 1000 / avg;
  }

  DateTime? endDate(DateTime now) => _after(now, daysLeft);

  /// When the stock drops to [thresholdKg] at the current pace: [now] if
  /// it already has, null if it can't be predicted.
  DateTime? whenBelow(double thresholdKg, DateTime now) {
    if (!hasPurchases) return null;
    if (remainingKg <= thresholdKg) return now;
    final avg = avgGramsPerDay;
    if (avg == null || avg <= 0) return null;
    return _after(now, (remainingKg - thresholdKg) * 1000 / avg);
  }

  /// Predicted stock at [at] (>= now).
  double remainingAt(DateTime at, DateTime now) {
    final avg = avgGramsPerDay ?? 0;
    final days = math.max(0, at.difference(now).inMinutes) / (24 * 60);
    return math.max(0, remainingKg - avg * days / 1000);
  }

  static DateTime? _after(DateTime now, double? days) => days == null
      ? null
      : now.add(Duration(minutes: (days * 24 * 60).round()));
}

bool _mealOf(DogEvent e, String foodId) =>
    !e.deleted &&
    e.type == EventType.meal &&
    e.foodId == foodId &&
    e.grams != null;

/// Stock of [foodId]. Meals count only from the first purchase on, so
/// meals logged before stock tracking started don't make it negative.
StockForecast computeStock({
  required String foodId,
  required Iterable<Purchase> purchases,
  required Iterable<DogEvent> meals,
  required DateTime now,
}) {
  final own = purchases.where((p) => !p.deleted && p.foodId == foodId);
  final purchasedKg = own.fold(0.0, (sum, p) => sum + p.kg);
  final since = own.isEmpty
      ? null
      : own.map((p) => p.at).reduce((a, b) => a.isBefore(b) ? a : b);

  final foodMeals = meals
      .where((e) => _mealOf(e, foodId) && !e.at.isAfter(now))
      .toList();
  final consumedGrams = since == null
      ? 0
      : foodMeals
            .where((e) => !e.at.isBefore(since))
            .fold(0, (sum, e) => sum + e.grams!);

  return StockForecast(
    purchasedKg: purchasedKg,
    consumedKg: consumedGrams / 1000,
    avgGramsPerDay: _averageGramsPerDay(foodMeals, now),
  );
}

double? _averageGramsPerDay(List<DogEvent> meals, DateTime now) {
  if (meals.isEmpty) return null;
  final windowStart = now.subtract(
    const Duration(days: StockForecast.averageWindowDays),
  );
  final recent = meals.where((e) => e.at.isAfter(windowStart)).toList();
  if (recent.isEmpty) return null;
  final first = meals.map((e) => e.at).reduce((a, b) => a.isBefore(b) ? a : b);
  final days = (now.difference(first).inMinutes / (24 * 60)).clamp(
    1.0,
    StockForecast.averageWindowDays.toDouble(),
  );
  return recent.fold(0, (sum, e) => sum + e.grams!) / days;
}

/// Grams of [foodId] eaten per calendar day, oldest first, ending today.
List<({DateTime day, int grams})> dailyConsumption({
  required String foodId,
  required Iterable<DogEvent> meals,
  required DateTime now,
  int days = 30,
}) {
  final today = startOfDay(now);
  final byDay = <DateTime, int>{};
  for (final e in meals.where((e) => _mealOf(e, foodId))) {
    final d = startOfDay(e.at);
    byDay[d] = (byDay[d] ?? 0) + e.grams!;
  }
  return [
    for (var i = days - 1; i >= 0; i--)
      () {
        final d = DateTime(today.year, today.month, today.day - i);
        return (day: d, grams: byDay[d] ?? 0);
      }(),
  ];
}
