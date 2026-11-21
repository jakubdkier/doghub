import 'package:intl/intl.dart';

/// "3,2" (one decimal, Polish locale).
String formatKg(double kg) =>
    NumberFormat.decimalPatternDigits(decimalDigits: 1).format(kg);

/// "+0,3" / "−0,3" / "0,0".
String formatKgChange(double kg) {
  final abs = formatKg(kg.abs());
  if (kg > 0) return '+$abs';
  if (kg < 0) return '−$abs';
  return abs;
}

String formatPrice(double price) =>
    NumberFormat.currency(symbol: 'zł', decimalDigits: 2).format(price);
