import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase.freezed.dart';

/// Bounds shared with `validPurchase()` in firestore.rules.
abstract final class PurchaseLimits {
  static const maxKg = 100.0;
  static const maxPrice = 100000.0;
}

@freezed
abstract class Purchase with _$Purchase {
  const factory Purchase({
    String? id,
    required String foodId,
    required double kg,

    /// Optional, e.g. for an already opened bag entered as starting stock.
    double? price,
    required DateTime at,
    required String by,
    DateTime? createdAt,
    @Default(false) bool deleted,
  }) = _Purchase;

  const Purchase._();

  static int newestFirst(Purchase a, Purchase b) => b.at.compareTo(a.at);
}

/// Parses "12", "1,5", "1.5 kg". Null unless 0 < kg <= [PurchaseLimits.maxKg].
double? parsePurchaseKg(String input) {
  final v = _parseDecimal(input, unit: 'kg');
  return (v == null || v <= 0 || v > PurchaseLimits.maxKg) ? null : v;
}

/// Parses "249,99", "250 zł". Null unless 0 <= price <= max.
double? parsePrice(String input) {
  final v = _parseDecimal(input, unit: 'zł');
  return (v == null || v < 0 || v > PurchaseLimits.maxPrice) ? null : v;
}

double? _parseDecimal(String input, {required String unit}) => double.tryParse(
  input
      .trim()
      .toLowerCase()
      .replaceAll(unit, '')
      .replaceAll(' ', '')
      .replaceAll(',', '.'),
);
