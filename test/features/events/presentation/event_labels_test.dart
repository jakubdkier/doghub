import 'package:dog_app/features/events/presentation/event_labels.dart';
import 'package:dog_app/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('pl'));
  final now = DateTime(2026, 11, 18, 9, 30);

  setUpAll(() async {
    Intl.defaultLocale = 'pl_PL';
    await initializeDateFormatting('pl_PL');
  });

  test('formatAgo', () {
    String ago(Duration d) => formatAgo(l10n, now.subtract(d), now);
    expect(ago(const Duration(seconds: 20)), 'przed chwilą');
    expect(ago(const Duration(minutes: 25)), '25 min temu');
    expect(ago(const Duration(hours: 2, minutes: 59)), '2 h temu');
    // Late yesterday evening is still counted in hours.
    expect(ago(const Duration(hours: 11)), '11 h temu');
    expect(ago(const Duration(hours: 30)), 'wczoraj');
    expect(ago(const Duration(days: 4)), '4 dni temu');
  });

  test('formatDay', () {
    expect(formatDay(l10n, DateTime(2026, 11, 18), now), 'Dziś');
    expect(formatDay(l10n, DateTime(2026, 11, 17), now), 'Wczoraj');
    expect(
      formatDay(l10n, DateTime(2026, 11, 16), now),
      'poniedziałek, 16 listopada',
    );
    expect(formatDay(l10n, DateTime(2025, 12, 1), now), contains('2025'));
  });
}
