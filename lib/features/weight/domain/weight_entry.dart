import 'package:freezed_annotation/freezed_annotation.dart';

part 'weight_entry.freezed.dart';

@freezed
abstract class WeightEntry with _$WeightEntry {
  const factory WeightEntry({
    String? id,
    required double kg,
    required DateTime at,
    required String by,
  }) = _WeightEntry;
}

/// Parses user input like "12,5" or "12.5 kg". Returns null if not a
/// plausible dog weight (0 < kg < 150, same bounds as firestore.rules).
double? parseWeightKg(String input) {
  final cleaned = input
      .trim()
      .toLowerCase()
      .replaceAll('kg', '')
      .replaceAll(',', '.')
      .trim();
  final kg = double.tryParse(cleaned);
  if (kg == null || kg <= 0 || kg >= 150) return null;
  return kg;
}
