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

  test('weighDay stores noon, but never in the future', () {
    final evening = DateTime(2026, 11, 21, 20);
    final morning = DateTime(2026, 11, 21, 8, 56);
    expect(
      weighDay(DateTime(2026, 11, 20, 23, 59), now: evening),
      DateTime(2026, 11, 20, 12),
    );
    expect(weighDay(morning, now: evening), DateTime(2026, 11, 21, 12));
    // Before noon today: the current time (rules reject future times).
    expect(weighDay(morning, now: morning), morning);
  });
}
