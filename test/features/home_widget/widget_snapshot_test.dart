import 'package:dog_app/features/home_widget/domain/widget_snapshot.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('widget data is all strings with stable keys', () {
    final meal = DateTime(2026, 11, 21, 8);
    final data = WidgetSnapshot(
      ready: true,
      dogName: 'Burek',
      lastMealAt: meal,
      foodText: 'Karma: ~9 dni',
      foodLow: true,
      healthText: '1 termin po terminie',
      healthOverdue: true,
      medsText: 'Leki: 0/1 dziś',
      medsMissed: true,
    ).toWidgetData();
    expect(data, {
      'dh_ready': '1',
      'dh_dog': 'Burek',
      'dh_meal_at': '${meal.millisecondsSinceEpoch}',
      'dh_poop_at': '',
      'dh_walk_at': '',
      'dh_food': 'Karma: ~9 dni',
      'dh_food_low': '1',
      'dh_health': '1 termin po terminie',
      'dh_health_alert': '1',
      'dh_meds': 'Leki: 0/1 dziś',
      'dh_meds_alert': '1',
    });
    expect(WidgetSnapshot.empty.toWidgetData()['dh_ready'], '0');
  });

  test('widget URIs map to app routes', () {
    expect(
      routeForWidgetUri(Uri.parse('doghub://quick-add?type=poop')),
      '/quick-add?type=poop',
    );
    expect(routeForWidgetUri(Uri.parse('doghub://today')), '/today');
    expect(routeForWidgetUri(Uri.parse('doghub://quick-add')), isNull);
    expect(routeForWidgetUri(Uri.parse('https://evil.example/x')), isNull);
    expect(routeForWidgetUri(Uri.parse('doghub://settings')), isNull);
    expect(routeForWidgetUri(null), isNull);
  });
}
