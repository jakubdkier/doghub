/// Noon of [d]'s calendar day, but never later than [now] (default: the
/// current time). Date-only values are stored at noon so they don't shift
/// across time zones; the rules reject future times for past events.
DateTime noonOf(DateTime d, {DateTime? now}) {
  final noon = DateTime(d.year, d.month, d.day, 12);
  final current = now ?? DateTime.now();
  return noon.isAfter(current) ? current : noon;
}

/// Noon of [d]'s day, allowed in the future (for due dates).
DateTime dueNoonOf(DateTime d) => DateTime(d.year, d.month, d.day, 12);

/// [d] plus [months], clamped to the target month's last day
/// (31 Jan + 1 month = 28/29 Feb).
DateTime addMonths(DateTime d, int months) {
  final firstOfTarget = DateTime(d.year, d.month + months);
  final lastDay = DateTime(firstOfTarget.year, firstOfTarget.month + 1, 0).day;
  return DateTime(
    firstOfTarget.year,
    firstOfTarget.month,
    d.day > lastDay ? lastDay : d.day,
    d.hour,
    d.minute,
  );
}
