import '../../../l10n/app_localizations.dart';
import '../domain/med.dart';

/// "codziennie o 08:00, 20:00" / "co 3 dni o 09:00".
String scheduleText(AppLocalizations l10n, Med med) =>
    switch (med.scheduleType) {
      MedScheduleType.daily => l10n.medDailyAt(
        med.sortedTimes.map((t) => t.label).join(', '),
      ),
      MedScheduleType.interval => l10n.medEveryDays(
        med.intervalDays ?? MedLimits.minIntervalDays,
        med.sortedTimes.first.label,
      ),
    };

/// "Magnez · 1 tabletka"
String medTitle(Med med) => [
  med.name,
  if (med.dose case final dose? when dose.isNotEmpty) dose,
].join(' · ');
