import 'package:dog_app/core/utils/dates.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('addMonths clamps to the last day of the month', () {
    expect(addMonths(DateTime(2026, 1, 31), 1), DateTime(2026, 2, 28));
    expect(addMonths(DateTime(2028, 1, 31), 1), DateTime(2028, 2, 29));
    expect(addMonths(DateTime(2026, 11, 21, 12), 6), DateTime(2027, 5, 21, 12));
    expect(addMonths(DateTime(2026, 11, 21), 12), DateTime(2027, 11, 21));
  });

  test('noonOf never returns a future time; dueNoonOf may', () {
    final morning = DateTime(2026, 11, 21, 9);
    expect(noonOf(morning, now: morning), morning);
    expect(
      noonOf(DateTime(2026, 11, 20), now: morning),
      DateTime(2026, 11, 20, 12),
    );
    expect(dueNoonOf(DateTime(2027, 5, 21)), DateTime(2027, 5, 21, 12));
  });
}
