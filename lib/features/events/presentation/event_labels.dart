import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../l10n/app_localizations.dart';
import '../../food/domain/food.dart';
import '../domain/dog_event.dart';
import '../domain/event_timeline.dart';

extension EventTypeUi on EventType {
  String label(AppLocalizations l10n) => switch (this) {
    EventType.meal => l10n.eventMeal,
    EventType.poop => l10n.eventPoop,
    EventType.pee => l10n.eventPee,
    EventType.walk => l10n.eventWalk,
    EventType.note => l10n.eventNote,
  };

  IconData get icon => switch (this) {
    EventType.meal => Icons.restaurant,
    EventType.poop => Icons.pets,
    EventType.pee => Icons.water_drop_outlined,
    EventType.walk => Icons.directions_walk,
    EventType.note => Icons.sticky_note_2_outlined,
  };
}

extension PoopColorUi on PoopColor {
  String label(AppLocalizations l10n) => switch (this) {
    PoopColor.brown => l10n.poopColorBrown,
    PoopColor.dark => l10n.poopColorDark,
    PoopColor.yellow => l10n.poopColorYellow,
    PoopColor.green => l10n.poopColorGreen,
    PoopColor.grey => l10n.poopColorGrey,
    PoopColor.bloody => l10n.poopColorBloody,
  };
}

String bristolDescription(AppLocalizations l10n, int score) => switch (score) {
  1 => l10n.bristol1,
  2 => l10n.bristol2,
  3 => l10n.bristol3,
  4 => l10n.bristol4,
  5 => l10n.bristol5,
  6 => l10n.bristol6,
  _ => l10n.bristol7,
};

/// "przed chwilą", "25 min temu", "3 h temu" (under 24 h), then calendar
/// days: "wczoraj", "4 dni temu".
String formatAgo(AppLocalizations l10n, DateTime at, DateTime now) {
  final diff = now.difference(at);
  if (diff.inMinutes < 1) return l10n.agoJustNow;
  if (diff.inMinutes < 60) return l10n.agoMinutes(diff.inMinutes);
  if (diff.inHours < 24) return l10n.agoHours(diff.inHours);
  final days = startOfDay(now).difference(startOfDay(at)).inDays;
  return l10n.agoDays(days < 1 ? 1 : days);
}

/// Day header in history: "Dziś", "Wczoraj" or "poniedziałek, 16 listopada".
String formatDay(AppLocalizations l10n, DateTime day, DateTime now) {
  final days = startOfDay(now).difference(startOfDay(day)).inDays;
  if (days == 0) return l10n.dayToday;
  if (days == 1) return l10n.dayYesterday;
  final pattern = day.year == now.year
      ? DateFormat.MMMMEEEEd()
      : DateFormat.yMMMMEEEEd();
  return pattern.format(day);
}

/// Event time for forms: "dziś, 14:32" style via [formatDay] + HH:mm.
String formatDayTime(AppLocalizations l10n, DateTime at, DateTime now) =>
    '${formatDay(l10n, at, now)}, ${DateFormat.Hm().format(at)}';

/// Title line: type plus its key values, e.g. "Posiłek · 120 g · Acana".
String eventSummary(
  AppLocalizations l10n,
  DogEvent e, {
  Map<String, Food> foods = const {},
}) {
  final parts = <String>[
    e.type.label(l10n),
    if (e.grams != null) l10n.gramsValue(e.grams!),
    if (foods[e.foodId] case final food?) food.label,
    if (e.poopScore != null) l10n.bristolValue(e.poopScore!),
    if (e.poopColor != null) e.poopColor!.label(l10n),
    if (e.durationMin != null) l10n.minutesValue(e.durationMin!),
  ];
  return parts.join(' · ');
}
