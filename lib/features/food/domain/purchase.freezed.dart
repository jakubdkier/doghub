// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Purchase {

 String? get id; String get foodId; double get kg;/// Optional, e.g. for an already opened bag entered as starting stock.
 double? get price; DateTime get at; String get by; DateTime? get createdAt; bool get deleted;
/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseCopyWith<Purchase> get copyWith => _$PurchaseCopyWithImpl<Purchase>(this as Purchase, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Purchase;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Purchase&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.foodId, _this.foodId) || other.foodId == _this.foodId)&&(identical(other.kg, _this.kg) || other.kg == _this.kg)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.by, _this.by) || other.by == _this.by)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.deleted, _this.deleted) || other.deleted == _this.deleted));
}


@override
int get hashCode {
  final _this = this as Purchase;
  return Object.hash(runtimeType,_this.id,_this.foodId,_this.kg,_this.price,_this.at,_this.by,_this.createdAt,_this.deleted);
}

@override
String toString() {
  final _this = this as Purchase;
  return 'Purchase(id: ${_this.id}, foodId: ${_this.foodId}, kg: ${_this.kg}, price: ${_this.price}, at: ${_this.at}, by: ${_this.by}, createdAt: ${_this.createdAt}, deleted: ${_this.deleted})';
}


}

/// @nodoc
abstract mixin class $PurchaseCopyWith<$Res>  {
  factory $PurchaseCopyWith(Purchase value, $Res Function(Purchase) _then) = _$PurchaseCopyWithImpl;
@useResult
$Res call({
 String? id, String foodId, double kg, double? price, DateTime at, String by, DateTime? createdAt, bool deleted
});




}
/// @nodoc
class _$PurchaseCopyWithImpl<$Res>
    implements $PurchaseCopyWith<$Res> {
  _$PurchaseCopyWithImpl(this._self, this._then);

  final Purchase _self;
  final $Res Function(Purchase) _then;

/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? foodId = null,Object? kg = null,Object? price = freezed,Object? at = null,Object? by = null,Object? createdAt = freezed,Object? deleted = null,}) {
  return _then(Purchase(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,foodId: null == foodId ? _self.foodId : foodId // ignore: cast_nullable_to_non_nullable
as String,kg: null == kg ? _self.kg : kg // ignore: cast_nullable_to_non_nullable
as double,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,by: null == by ? _self.by : by // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Purchase].
extension PurchasePatterns on Purchase {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Purchase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Purchase() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Purchase value)  $default,){
final _that = this;
switch (_that) {
case _Purchase():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Purchase value)?  $default,){
final _that = this;
switch (_that) {
case _Purchase() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String foodId,  double kg,  double? price,  DateTime at,  String by,  DateTime? createdAt,  bool deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Purchase() when $default != null:
return $default(_that.id,_that.foodId,_that.kg,_that.price,_that.at,_that.by,_that.createdAt,_that.deleted);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String foodId,  double kg,  double? price,  DateTime at,  String by,  DateTime? createdAt,  bool deleted)  $default,) {final _that = this;
switch (_that) {
case _Purchase():
return $default(_that.id,_that.foodId,_that.kg,_that.price,_that.at,_that.by,_that.createdAt,_that.deleted);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String foodId,  double kg,  double? price,  DateTime at,  String by,  DateTime? createdAt,  bool deleted)?  $default,) {final _that = this;
switch (_that) {
case _Purchase() when $default != null:
return $default(_that.id,_that.foodId,_that.kg,_that.price,_that.at,_that.by,_that.createdAt,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc


class _Purchase extends Purchase {
  const _Purchase({this.id, required this.foodId, required this.kg, this.price, required this.at, required this.by, this.createdAt, this.deleted = false}): super._();
  

@override final  String? id;
@override final  String foodId;
@override final  double kg;
/// Optional, e.g. for an already opened bag entered as starting stock.
@override final  double? price;
@override final  DateTime at;
@override final  String by;
@override final  DateTime? createdAt;
@override@JsonKey() final  bool deleted;

/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseCopyWith<_Purchase> get copyWith => __$PurchaseCopyWithImpl<_Purchase>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Purchase&&(identical(other.id, id) || other.id == id)&&(identical(other.foodId, foodId) || other.foodId == foodId)&&(identical(other.kg, kg) || other.kg == kg)&&(identical(other.price, price) || other.price == price)&&(identical(other.at, at) || other.at == at)&&(identical(other.by, by) || other.by == by)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,foodId,kg,price,at,by,createdAt,deleted);
}

@override
String toString() {
    return 'Purchase(id: $id, foodId: $foodId, kg: $kg, price: $price, at: $at, by: $by, createdAt: $createdAt, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$PurchaseCopyWith<$Res> implements $PurchaseCopyWith<$Res> {
  factory _$PurchaseCopyWith(_Purchase value, $Res Function(_Purchase) _then) = __$PurchaseCopyWithImpl;
@override @useResult
$Res call({
 String? id, String foodId, double kg, double? price, DateTime at, String by, DateTime? createdAt, bool deleted
});




}
/// @nodoc
class __$PurchaseCopyWithImpl<$Res>
    implements _$PurchaseCopyWith<$Res> {
  __$PurchaseCopyWithImpl(this._self, this._then);

  final _Purchase _self;
  final $Res Function(_Purchase) _then;

/// Create a copy of Purchase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? foodId = null,Object? kg = null,Object? price = freezed,Object? at = null,Object? by = null,Object? createdAt = freezed,Object? deleted = null,}) {
  return _then(_Purchase(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,foodId: null == foodId ? _self.foodId : foodId // ignore: cast_nullable_to_non_nullable
as String,kg: null == kg ? _self.kg : kg // ignore: cast_nullable_to_non_nullable
as double,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,by: null == by ? _self.by : by // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
