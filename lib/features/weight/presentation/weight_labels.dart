import 'package:intl/intl.dart';

import '../../../core/utils/formatting.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/weight_stats.dart';

String weightRangeLabel(AppLocalizations l10n, WeightRange r) => switch (r) {
  WeightRange.threeMonths => l10n.weightRange3m,
  WeightRange.sixMonths => l10n.weightRange6m,
  WeightRange.year => l10n.weightRange1y,
  WeightRange.all => l10n.weightRangeAll,
};

/// "+0,3 kg od 3 lis", or null without a previous measurement.
String? weightChangeText(AppLocalizations l10n, WeightSummary s) {
  final change = s.change;
  final previous = s.previous;
  if (change == null || previous == null) return null;
  return l10n.weightChange(
    formatKgChange(change),
    DateFormat.MMMd().format(previous.at),
  );
}
