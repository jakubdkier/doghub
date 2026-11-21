import 'package:freezed_annotation/freezed_annotation.dart';

part 'med_dose.freezed.dart';

/// A ticked (or unticked = [deleted]) dose of a med at a scheduled slot.
@freezed
abstract class MedDose with _$MedDose {
  const factory MedDose({
    required String medId,
    required DateTime slot,
    required DateTime givenAt,
    required String by,
    @Default(false) bool deleted,
  }) = _MedDose;

  const MedDose._();

  String get id => doseId(medId, slot);
}

/// Deterministic id: both partners ticking the same slot hit one doc.
String doseId(String medId, DateTime slot) {
  String two(int v) => v.toString().padLeft(2, '0');
  return '${medId}_${slot.year}${two(slot.month)}${two(slot.day)}'
      '_${two(slot.hour)}${two(slot.minute)}';
}
