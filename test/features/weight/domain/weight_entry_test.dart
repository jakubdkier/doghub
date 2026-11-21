import 'package:dog_app/features/weight/domain/weight_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parseWeightKg accepts comma, dot and unit', () {
    expect(parseWeightKg('12,5'), 12.5);
    expect(parseWeightKg(' 12.5 kg '), 12.5);
    expect(parseWeightKg('8KG'), 8);
  });

  test('parseWeightKg rejects garbage and implausible values', () {
    expect(parseWeightKg(''), isNull);
    expect(parseWeightKg('abc'), isNull);
    expect(parseWeightKg('0'), isNull);
    expect(parseWeightKg('-3'), isNull);
    expect(parseWeightKg('150'), isNull);
    expect(parseWeightKg('0,04'), isNull);
  });

  test('parseWeightKg rounds to 0.1 kg', () {
    expect(parseWeightKg('12,46'), 12.5);
    expect(parseWeightKg('12,44'), 12.4);
  });

  test('weighDay keeps the date at noon', () {
    expect(
      weighDay(DateTime(2026, 11, 21, 23, 59)),
      DateTime(2026, 11, 21, 12),
    );
  });
}
