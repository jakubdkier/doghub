import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/food.dart';
import '../domain/stock_forecast.dart';

String formatKg(double kg) =>
    NumberFormat.decimalPatternDigits(decimalDigits: 1).format(kg);

String formatPrice(double price) =>
    NumberFormat.currency(symbol: 'zł', decimalDigits: 2).format(price);

/// "zostało 3,2 kg · ~9 dni" or "brak zakupów".
String stockSummary(AppLocalizations l10n, StockForecast? stock) {
  if (stock == null || !stock.hasPurchases) return l10n.stockNoPurchases;
  final days = stock.daysLeft;
  return [
    l10n.stockRemaining(formatKg(stock.remainingKg)),
    if (days != null) l10n.stockDaysLeft(days.floor()),
  ].join(' · ');
}

extension FoodRatingUi on FoodRating {
  String label(AppLocalizations l10n) => switch (this) {
    FoodRating.good => l10n.ratingGood,
    FoodRating.neutral => l10n.ratingNeutral,
    FoodRating.bad => l10n.ratingBad,
  };

  IconData get icon => switch (this) {
    FoodRating.good => Icons.sentiment_satisfied_alt,
    FoodRating.neutral => Icons.sentiment_neutral,
    FoodRating.bad => Icons.sentiment_dissatisfied,
  };
}

IconData foodIcon(Food food) => food.rating?.icon ?? Icons.set_meal_outlined;
