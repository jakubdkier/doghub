import 'package:freezed_annotation/freezed_annotation.dart';

part 'widget_snapshot.freezed.dart';

/// What the home screen widgets show. Times are raw so the widget can
/// render "x h temu" itself on every refresh while the app is closed.
@freezed
abstract class WidgetSnapshot with _$WidgetSnapshot {
  /// Signed out or no dog yet: the widget asks to open the app.
  static const empty = WidgetSnapshot();

  const factory WidgetSnapshot({
    @Default(false) bool ready,
    @Default('') String dogName,
    DateTime? lastMealAt,
    DateTime? lastPoopAt,
    DateTime? lastWalkAt,

    /// E.g. "Karma: ~9 dni"; null hides the line.
    String? foodText,
    @Default(false) bool foodLow,

    /// E.g. "1 termin po terminie"; null hides the line.
    String? healthText,
    @Default(false) bool healthOverdue,

    /// E.g. "Leki: 0/1 dziś"; null when no doses are due today.
    String? medsText,

    /// A dose due earlier today hasn't been ticked.
    @Default(false) bool medsMissed,
  }) = _WidgetSnapshot;

  const WidgetSnapshot._();

  /// Key-value pairs stored for the Android widget (all strings, so the
  /// Kotlin side never has to guess Int vs Long).
  Map<String, String> toWidgetData() => {
    WidgetKeys.ready: ready ? '1' : '0',
    WidgetKeys.dogName: dogName,
    WidgetKeys.mealAt: _millis(lastMealAt),
    WidgetKeys.poopAt: _millis(lastPoopAt),
    WidgetKeys.walkAt: _millis(lastWalkAt),
    WidgetKeys.food: foodText ?? '',
    WidgetKeys.foodLow: foodLow ? '1' : '0',
    WidgetKeys.health: healthText ?? '',
    WidgetKeys.healthAlert: healthOverdue ? '1' : '0',
    WidgetKeys.meds: medsText ?? '',
    WidgetKeys.medsAlert: medsMissed ? '1' : '0',
  };

  static String _millis(DateTime? t) =>
      t == null ? '' : '${t.millisecondsSinceEpoch}';
}

/// Shared with DogHubWidgetProvider.kt.
abstract final class WidgetKeys {
  static const ready = 'dh_ready';
  static const dogName = 'dh_dog';
  static const mealAt = 'dh_meal_at';
  static const poopAt = 'dh_poop_at';
  static const walkAt = 'dh_walk_at';
  static const food = 'dh_food';
  static const foodLow = 'dh_food_low';
  static const health = 'dh_health';
  static const healthAlert = 'dh_health_alert';
  static const meds = 'dh_meds';
  static const medsAlert = 'dh_meds_alert';
}

/// Widget tap URIs (`doghub://quick-add?type=meal`, `doghub://today`) to
/// app routes; null for anything else.
String? routeForWidgetUri(Uri? uri) {
  if (uri == null || uri.scheme != 'doghub') return null;
  return switch (uri.host) {
    'quick-add' => switch (uri.queryParameters['type']) {
      final type? when type.isNotEmpty => '/quick-add?type=$type',
      _ => null,
    },
    'today' => '/today',
    _ => null,
  };
}
