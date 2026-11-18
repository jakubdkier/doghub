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
  });
}
