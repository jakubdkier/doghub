import 'package:freezed_annotation/freezed_annotation.dart';

part 'weight_entry.freezed.dart';

/// Bounds shared with `validWeight()` in firestore.rules.
abstract final class WeightLimits {
  static const maxKg = 150.0;
}

@freezed
abstract class WeightEntry with _$WeightEntry {
  const factory WeightEntry({
    String? id,
    required double kg,

    /// Day of the measurement (stored at noon, time is not shown).
    required DateTime at,
    required String by,
    DateTime? createdAt,
    @Default(false) bool deleted,
  }) = _WeightEntry;

  const WeightEntry._();

  static int newestFirst(WeightEntry a, WeightEntry b) {
    final c = b.at.compareTo(a.at);
    return c != 0 ? c : (b.createdAt ?? b.at).compareTo(a.createdAt ?? a.at);
  }
}

/// Measurements are per day; noon keeps the date stable across time zones.
/// Never later than [now] (default: the current time), since the rules
/// reject future times: a measurement today before noon keeps [now].
DateTime weighDay(DateTime d, {DateTime? now}) {
  final noon = DateTime(d.year, d.month, d.day, 12);
  final current = now ?? DateTime.now();
  return noon.isAfter(current) ? current : noon;
}

/// Parses user input like "12,5" or "12.5 kg". Returns null if not a
/// plausible dog weight (0 < kg < 150, same bounds as firestore.rules).
/// Rounded to 0.1 kg.
double? parseWeightKg(String input) {
  final cleaned = input
      .trim()
      .toLowerCase()
      .replaceAll('kg', '')
      .replaceAll(',', '.')
      .trim();
  final kg = double.tryParse(cleaned);
  if (kg == null || kg <= 0 || kg >= WeightLimits.maxKg) return null;
  final rounded = (kg * 10).round() / 10;
  return rounded <= 0 ? null : rounded;
}
