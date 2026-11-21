import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart' show Locale;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/routes.dart';
import '../../features/food/application/food_providers.dart';
import '../../features/food/application/purchase_providers.dart';
import '../../features/food/domain/food.dart';
import '../../features/food/domain/food_reminder.dart';
import '../../features/settings/application/reminder_settings_provider.dart';
import '../../l10n/app_localizations.dart';
import '../utils/clock.dart';
import 'local_notifications.dart';

part 'reminder_scheduler.g.dart';

/// Replaces all scheduled notifications with the given plan.
/// Always recomputes from scratch (see CLAUDE.md).
class ReminderScheduler {
  ReminderScheduler(this._notifications);

  static const _foodIdBase = 1000;

  final LocalNotifications _notifications;
  final _l10n = lookupAppLocalizations(const Locale('pl'));
  Future<void> _queue = Future.value();

  /// Serialized so overlapping resyncs can't interleave cancel/schedule.
  Future<void> resync({
    required List<FoodReminder> food,
    required Map<String, Food> foods,
  }) => _queue = _queue.then((_) async {
    try {
      await _notifications.cancelAll();
      for (final (i, r) in food.indexed) {
        final label = foods[r.foodId]?.label ?? '';
        final kg = NumberFormat.decimalPatternDigits(decimalDigits: 1)
            .format(r.remainingKg);
        final days = r.daysLeft;
        await _notifications.schedule(
          id: _foodIdBase + i,
          title: _l10n.reminderFoodTitle,
          body: days == null
              ? _l10n.reminderFoodBody(label, kg)
              : _l10n.reminderFoodBodyDays(label, kg, days.floor()),
          at: r.at,
          route: Routes.foodDetail(r.foodId),
        );
      }
    } catch (e, st) {
      debugPrint('Reminder resync failed: $e\n$st');
    }
  });
}

@Riverpod(keepAlive: true)
ReminderScheduler reminderScheduler(Ref ref) =>
    ReminderScheduler(ref.watch(localNotificationsProvider));

/// Planned food reminders for the current dog (empty when signed out).
@Riverpod(keepAlive: true)
List<FoodReminder> foodReminderPlan(Ref ref) {
  final foods = ref.watch(foodsProvider).value ?? const <Food>[];
  final stock = ref.watch(stockProvider);
  final settings = ref.watch(reminderSettingsControllerProvider);
  if (stock == null) return const [];
  final now = ref.read(clockProvider)();
  return [
    for (final f in foods)
      if (stock[f.id] case final s?)
        ?planFoodReminder(food: f, stock: s, settings: settings, now: now),
  ];
}

/// Keeps scheduled notifications in sync with the data. Watched by the
/// app root, so it runs on start and after every relevant change.
@Riverpod(keepAlive: true)
void reminderSync(Ref ref) {
  final plan = ref.watch(foodReminderPlanProvider);
  // Until data has loaded, keep what is scheduled instead of wiping it.
  if (ref.read(stockProvider) == null) return;
  final foods = {
    for (final f in ref.read(foodsProvider).value ?? const <Food>[]) f.id: f,
  };
  unawaited(
    ref.read(reminderSchedulerProvider).resync(food: plan, foods: foods),
  );
}
