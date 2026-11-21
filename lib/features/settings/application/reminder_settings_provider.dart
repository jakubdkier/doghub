import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/notifications/local_notifications.dart';
import '../../../core/storage/preferences.dart';
import '../domain/reminder_settings.dart';

part 'reminder_settings_provider.g.dart';

abstract final class _Keys {
  static const foodEnabled = 'reminders.food.enabled';
  static const foodThresholdKg = 'reminders.food.thresholdKg';
  static const weighEnabled = 'reminders.weigh.enabled';
  static const healthEnabled = 'reminders.health.enabled';
  static const healthDaysBefore = 'reminders.health.daysBefore';
  static const medsEnabled = 'reminders.meds.enabled';
  static const hour = 'reminders.hour';
  static const minute = 'reminders.minute';
  static const permissionAsked = 'reminders.permissionAsked';
}

/// Per-device reminder settings stored in shared preferences.
@Riverpod(keepAlive: true)
class ReminderSettingsController extends _$ReminderSettingsController {
  @override
  ReminderSettings build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    const d = ReminderSettings();
    return ReminderSettings(
      foodEnabled: prefs.getBool(_Keys.foodEnabled) ?? d.foodEnabled,
      foodThresholdKg:
          prefs.getDouble(_Keys.foodThresholdKg) ?? d.foodThresholdKg,
      weighEnabled: prefs.getBool(_Keys.weighEnabled) ?? d.weighEnabled,
      healthEnabled: prefs.getBool(_Keys.healthEnabled) ?? d.healthEnabled,
      medsEnabled: prefs.getBool(_Keys.medsEnabled) ?? d.medsEnabled,
      healthDaysBefore:
          prefs.getInt(_Keys.healthDaysBefore) ?? d.healthDaysBefore,
      hour: prefs.getInt(_Keys.hour) ?? d.hour,
      minute: prefs.getInt(_Keys.minute) ?? d.minute,
    );
  }

  void setFoodEnabled(bool enabled) {
    state = state.copyWith(foodEnabled: enabled);
    ref.read(sharedPreferencesProvider).setBool(_Keys.foodEnabled, enabled);
    if (enabled) ensurePermission(force: true);
  }

  void setWeighEnabled(bool enabled) {
    state = state.copyWith(weighEnabled: enabled);
    ref.read(sharedPreferencesProvider).setBool(_Keys.weighEnabled, enabled);
    if (enabled) ensurePermission(force: true);
  }

  void setHealthEnabled(bool enabled) {
    state = state.copyWith(healthEnabled: enabled);
    ref.read(sharedPreferencesProvider).setBool(_Keys.healthEnabled, enabled);
    if (enabled) ensurePermission(force: true);
  }

  void setMedsEnabled(bool enabled) {
    state = state.copyWith(medsEnabled: enabled);
    ref.read(sharedPreferencesProvider).setBool(_Keys.medsEnabled, enabled);
    if (enabled) ensurePermission(force: true);
  }

  void setHealthDaysBefore(int days) {
    final clamped = days.clamp(
      ReminderSettings.minHealthDaysBefore,
      ReminderSettings.maxHealthDaysBefore,
    );
    state = state.copyWith(healthDaysBefore: clamped);
    ref.read(sharedPreferencesProvider).setInt(_Keys.healthDaysBefore, clamped);
  }

  void setFoodThresholdKg(double kg) {
    final clamped = kg.clamp(
      ReminderSettings.minThresholdKg,
      ReminderSettings.maxThresholdKg,
    );
    state = state.copyWith(foodThresholdKg: clamped);
    ref
        .read(sharedPreferencesProvider)
        .setDouble(_Keys.foodThresholdKg, clamped);
  }

  void setTime(int hour, int minute) {
    state = state.copyWith(hour: hour, minute: minute);
    ref.read(sharedPreferencesProvider)
      ..setInt(_Keys.hour, hour)
      ..setInt(_Keys.minute, minute);
  }

  /// Asks for the notification permission once (e.g. at the first
  /// purchase), or again when [force]d by enabling reminders.
  Future<void> ensurePermission({bool force = false}) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (!force && (prefs.getBool(_Keys.permissionAsked) ?? false)) return;
    await prefs.setBool(_Keys.permissionAsked, true);
    await ref.read(localNotificationsProvider).requestPermission();
  }
}
