import 'package:dog_app/features/events/domain/dog_event.dart';
import 'package:dog_app/features/food/domain/food.dart';
import 'package:dog_app/features/food/domain/food_reminder.dart';
import 'package:dog_app/features/food/domain/purchase.dart';
import 'package:dog_app/features/food/domain/stock_forecast.dart';
import 'package:dog_app/features/settings/domain/reminder_settings.dart';
import 'package:flutter_test/flutter_test.dart';

final now = DateTime(2026, 11, 21, 12);

Purchase buy(
  double kg, {
  int daysAgo = 10,
  String foodId = 'f1',
  bool deleted = false,
}) => Purchase(
  foodId: foodId,
  kg: kg,
  at: now.subtract(Duration(days: daysAgo)),
  by: 'u1',
  deleted: deleted,
);

DogEvent meal(
  int grams, {
  required double daysAgo,
  String? foodId = 'f1',
  bool deleted = false,
}) => DogEvent(
  type: EventType.meal,
  at: now.subtract(Duration(minutes: (daysAgo * 24 * 60).round())),
  by: 'u1',
  grams: grams,
  foodId: foodId,
  deleted: deleted,
);

/// Two 100 g meals a day for [days] days, the last one at [now].
List<DogEvent> twiceDaily(int days, {String foodId = 'f1'}) => [
  for (var d = 0; d < days; d++) ...[
    meal(100, daysAgo: d.toDouble(), foodId: foodId),
    meal(100, daysAgo: d + 0.5, foodId: foodId),
  ],
];

void main() {
  group('computeStock', () {
    test('remaining = purchases - meals of that food since first purchase', () {
      final s = computeStock(
        foodId: 'f1',
        purchases: [
          buy(10),
          buy(2, daysAgo: 3),
          buy(5, foodId: 'f2'),
          buy(4, deleted: true),
        ],
        meals: [
          meal(500, daysAgo: 2),
          meal(300, daysAgo: 1, foodId: 'f2'),
          meal(200, daysAgo: 1, foodId: null),
          meal(400, daysAgo: 1, deleted: true),
          // Before the first purchase: not counted.
          meal(1000, daysAgo: 20),
        ],
        now: now,
      );
      expect(s.purchasedKg, 12);
      expect(s.consumedKg, 0.5);
      expect(s.remainingKg, closeTo(11.5, 1e-9));
    });

    test('never negative; no purchases means no forecast', () {
      final s = computeStock(
        foodId: 'f1',
        purchases: [buy(1)],
        meals: [meal(3000, daysAgo: 1)],
        now: now,
      );
      expect(s.remainingKg, 0);
      final none = computeStock(
        foodId: 'f1',
        purchases: [],
        meals: twiceDaily(5),
        now: now,
      );
      expect(none.hasPurchases, isFalse);
      expect(none.daysLeft, isNull);
      expect(none.whenBelow(2, now), isNull);
    });

    test('average over 14 days when there is enough history', () {
      final s = computeStock(
        foodId: 'f1',
        purchases: [buy(12, daysAgo: 30)],
        meals: twiceDaily(30),
        now: now,
      );
      expect(s.avgGramsPerDay, closeTo(200, 15));
    });

    test('average over the shorter history of a new food', () {
      final s = computeStock(
        foodId: 'f1',
        purchases: [buy(12, daysAgo: 3)],
        meals: [
          meal(150, daysAgo: 3),
          meal(150, daysAgo: 2),
          meal(150, daysAgo: 1),
        ],
        now: now,
      );
      expect(s.avgGramsPerDay, closeTo(150, 1e-9));
    });

    test('no meals in the window means no pace', () {
      final s = computeStock(
        foodId: 'f1',
        purchases: [buy(12, daysAgo: 40)],
        meals: [meal(150, daysAgo: 20)],
        now: now,
      );
      expect(s.avgGramsPerDay, isNull);
      expect(s.daysLeft, isNull);
    });

    test('days left, end date and threshold date follow the pace', () {
      const s = StockForecast(
        purchasedKg: 10,
        consumedKg: 4,
        avgGramsPerDay: 200,
      );
      expect(s.daysLeft, 30);
      expect(s.endDate(now), now.add(const Duration(days: 30)));
      expect(s.whenBelow(2, now), now.add(const Duration(days: 20)));
      expect(s.whenBelow(6, now), now);
      expect(
        s.remainingAt(now.add(const Duration(days: 5)), now),
        closeTo(5, 1e-9),
      );
    });
  });

  test('dailyConsumption sums grams per day, oldest first', () {
    final days = dailyConsumption(
      foodId: 'f1',
      meals: [
        meal(100, daysAgo: 0),
        meal(50, daysAgo: 0.1),
        meal(80, daysAgo: 2),
      ],
      now: now,
      days: 3,
    );
    expect(days.map((d) => d.day), [
      DateTime(2026, 11, 19),
      DateTime(2026, 11, 20),
      DateTime(2026, 11, 21),
    ]);
    expect(days.map((d) => d.grams), [80, 0, 150]);
  });

  group('planFoodReminder', () {
    const food = Food(id: 'f1', name: 'Adult');
    const settings = ReminderSettings();
    const stock = StockForecast(
      purchasedKg: 10,
      consumedKg: 4,
      avgGramsPerDay: 200,
    );

    test('at the reminder hour on the day the stock hits the threshold', () {
      final r = planFoodReminder(
        food: food,
        stock: stock,
        settings: settings,
        now: now,
      )!;
      // 4 kg above 2 kg at 200 g/day = 20 days.
      expect(r.at, DateTime(2026, 12, 11, 18));
      expect(r.remainingKg, closeTo(2 - 0.2 * 6 / 24, 1e-6));
      expect(r.daysLeft, closeTo(r.remainingKg * 5, 1e-6));
    });

    test('already below: today at the hour, or tomorrow if it has passed', () {
      const low = StockForecast(
        purchasedKg: 2,
        consumedKg: 0.5,
        avgGramsPerDay: 200,
      );
      expect(
        planFoodReminder(
          food: food,
          stock: low,
          settings: settings,
          now: now,
        )!.at,
        DateTime(2026, 11, 21, 18),
      );
      final evening = DateTime(2026, 11, 21, 19);
      expect(
        planFoodReminder(
          food: food,
          stock: low,
          settings: settings,
          now: evening,
        )!.at,
        DateTime(2026, 11, 22, 18),
      );
    });

    test('respects threshold and hour settings', () {
      final r = planFoodReminder(
        food: food,
        stock: stock,
        settings: const ReminderSettings(
          foodThresholdKg: 4,
          hour: 8,
          minute: 30,
        ),
        now: now,
      )!;
      // (6 - 4) kg at 200 g/day = 10 days.
      expect(r.at, DateTime(2026, 12, 1, 8, 30));
    });

    test('nothing when disabled, archived, or not predictable', () {
      expect(
        planFoodReminder(
          food: food,
          stock: stock,
          settings: const ReminderSettings(foodEnabled: false),
          now: now,
        ),
        isNull,
      );
      expect(
        planFoodReminder(
          food: food.copyWith(active: false),
          stock: stock,
          settings: settings,
          now: now,
        ),
        isNull,
      );
      expect(
        planFoodReminder(
          food: food,
          stock: const StockForecast(
            purchasedKg: 10,
            consumedKg: 0,
            avgGramsPerDay: null,
          ),
          settings: settings,
          now: now,
        ),
        isNull,
      );
    });
  });

  test('parsePurchaseKg and parsePrice', () {
    expect(parsePurchaseKg('12'), 12);
    expect(parsePurchaseKg('1,5 kg'), 1.5);
    expect(parsePurchaseKg('0'), isNull);
    expect(parsePurchaseKg('101'), isNull);
    expect(parsePrice('249,99 zł'), 249.99);
    expect(parsePrice('0'), 0);
    expect(parsePrice('-1'), isNull);
    expect(parsePrice('abc'), isNull);
  });
}
