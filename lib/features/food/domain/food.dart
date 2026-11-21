import 'package:freezed_annotation/freezed_annotation.dart';

part 'food.freezed.dart';

/// How the dog takes to a food. Stored as [name] (see firestore.rules).
enum FoodRating { good, neutral, bad }

@freezed
abstract class Food with _$Food {
  const factory Food({
    required String id,
    required String name,
    String? brand,
    FoodRating? rating,
    @Default(true) bool active,

    /// Null until the server timestamp is synced.
    DateTime? createdAt,
  }) = _Food;

  const Food._();

  /// "Brand Name", or just the name when no brand is set.
  String get label => (brand == null || brand!.isEmpty) ? name : '$brand $name';

  /// Alphabetical by label, case-insensitive.
  static int byLabel(Food a, Food b) =>
      a.label.toLowerCase().compareTo(b.label.toLowerCase());
}

/// Food shown on Today and the widget: the last meal's, else the only one
/// in use.
Food? currentFood(List<Food> foods, String? lastMealFoodId) {
  final last = foods.where((f) => f.id == lastMealFoodId).firstOrNull;
  if (last != null) return last;
  final active = foods.where((f) => f.active).toList();
  return active.length == 1 ? active.single : null;
}
