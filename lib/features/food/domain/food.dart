import 'package:freezed_annotation/freezed_annotation.dart';

part 'food.freezed.dart';

@freezed
abstract class Food with _$Food {
  const factory Food({
    required String id,
    required String name,
    String? brand,
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
