// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'widget_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WidgetSnapshot {

 bool get ready; String get dogName; DateTime? get lastMealAt; DateTime? get lastPoopAt; DateTime? get lastWalkAt;/// E.g. "Karma: ~9 dni"; null hides the line.
 String? get foodText; bool get foodLow;/// E.g. "1 termin po terminie"; null hides the line.
 String? get healthText; bool get healthOverdue;/// E.g. "Leki: 0/1 dziś"; null when no doses are due today.
 String? get medsText;/// A dose due earlier today hasn't been ticked.
 bool get medsMissed;
/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WidgetSnapshotCopyWith<WidgetSnapshot> get copyWith => _$WidgetSnapshotCopyWithImpl<WidgetSnapshot>(this as WidgetSnapshot, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WidgetSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WidgetSnapshot&&(identical(other.ready, _this.ready) || other.ready == _this.ready)&&(identical(other.dogName, _this.dogName) || other.dogName == _this.dogName)&&(identical(other.lastMealAt, _this.lastMealAt) || other.lastMealAt == _this.lastMealAt)&&(identical(other.lastPoopAt, _this.lastPoopAt) || other.lastPoopAt == _this.lastPoopAt)&&(identical(other.lastWalkAt, _this.lastWalkAt) || other.lastWalkAt == _this.lastWalkAt)&&(identical(other.foodText, _this.foodText) || other.foodText == _this.foodText)&&(identical(other.foodLow, _this.foodLow) || other.foodLow == _this.foodLow)&&(identical(other.healthText, _this.healthText) || other.healthText == _this.healthText)&&(identical(other.healthOverdue, _this.healthOverdue) || other.healthOverdue == _this.healthOverdue)&&(identical(other.medsText, _this.medsText) || other.medsText == _this.medsText)&&(identical(other.medsMissed, _this.medsMissed) || other.medsMissed == _this.medsMissed));
}


@override
int get hashCode {
  final _this = this as WidgetSnapshot;
  return Object.hash(runtimeType,_this.ready,_this.dogName,_this.lastMealAt,_this.lastPoopAt,_this.lastWalkAt,_this.foodText,_this.foodLow,_this.healthText,_this.healthOverdue,_this.medsText,_this.medsMissed);
}

@override
String toString() {
  final _this = this as WidgetSnapshot;
  return 'WidgetSnapshot(ready: ${_this.ready}, dogName: ${_this.dogName}, lastMealAt: ${_this.lastMealAt}, lastPoopAt: ${_this.lastPoopAt}, lastWalkAt: ${_this.lastWalkAt}, foodText: ${_this.foodText}, foodLow: ${_this.foodLow}, healthText: ${_this.healthText}, healthOverdue: ${_this.healthOverdue}, medsText: ${_this.medsText}, medsMissed: ${_this.medsMissed})';
}


}

/// @nodoc
abstract mixin class $WidgetSnapshotCopyWith<$Res>  {
  factory $WidgetSnapshotCopyWith(WidgetSnapshot value, $Res Function(WidgetSnapshot) _then) = _$WidgetSnapshotCopyWithImpl;
@useResult
$Res call({
 bool ready, String dogName, DateTime? lastMealAt, DateTime? lastPoopAt, DateTime? lastWalkAt, String? foodText, bool foodLow, String? healthText, bool healthOverdue, String? medsText, bool medsMissed
});




}
/// @nodoc
class _$WidgetSnapshotCopyWithImpl<$Res>
    implements $WidgetSnapshotCopyWith<$Res> {
  _$WidgetSnapshotCopyWithImpl(this._self, this._then);

  final WidgetSnapshot _self;
  final $Res Function(WidgetSnapshot) _then;

/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ready = null,Object? dogName = null,Object? lastMealAt = freezed,Object? lastPoopAt = freezed,Object? lastWalkAt = freezed,Object? foodText = freezed,Object? foodLow = null,Object? healthText = freezed,Object? healthOverdue = null,Object? medsText = freezed,Object? medsMissed = null,}) {
  return _then(WidgetSnapshot(
ready: null == ready ? _self.ready : ready // ignore: cast_nullable_to_non_nullable
as bool,dogName: null == dogName ? _self.dogName : dogName // ignore: cast_nullable_to_non_nullable
as String,lastMealAt: freezed == lastMealAt ? _self.lastMealAt : lastMealAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastPoopAt: freezed == lastPoopAt ? _self.lastPoopAt : lastPoopAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastWalkAt: freezed == lastWalkAt ? _self.lastWalkAt : lastWalkAt // ignore: cast_nullable_to_non_nullable
as DateTime?,foodText: freezed == foodText ? _self.foodText : foodText // ignore: cast_nullable_to_non_nullable
as String?,foodLow: null == foodLow ? _self.foodLow : foodLow // ignore: cast_nullable_to_non_nullable
as bool,healthText: freezed == healthText ? _self.healthText : healthText // ignore: cast_nullable_to_non_nullable
as String?,healthOverdue: null == healthOverdue ? _self.healthOverdue : healthOverdue // ignore: cast_nullable_to_non_nullable
as bool,medsText: freezed == medsText ? _self.medsText : medsText // ignore: cast_nullable_to_non_nullable
as String?,medsMissed: null == medsMissed ? _self.medsMissed : medsMissed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WidgetSnapshot].
extension WidgetSnapshotPatterns on WidgetSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WidgetSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WidgetSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _WidgetSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WidgetSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool ready,  String dogName,  DateTime? lastMealAt,  DateTime? lastPoopAt,  DateTime? lastWalkAt,  String? foodText,  bool foodLow,  String? healthText,  bool healthOverdue,  String? medsText,  bool medsMissed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
return $default(_that.ready,_that.dogName,_that.lastMealAt,_that.lastPoopAt,_that.lastWalkAt,_that.foodText,_that.foodLow,_that.healthText,_that.healthOverdue,_that.medsText,_that.medsMissed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool ready,  String dogName,  DateTime? lastMealAt,  DateTime? lastPoopAt,  DateTime? lastWalkAt,  String? foodText,  bool foodLow,  String? healthText,  bool healthOverdue,  String? medsText,  bool medsMissed)  $default,) {final _that = this;
switch (_that) {
case _WidgetSnapshot():
return $default(_that.ready,_that.dogName,_that.lastMealAt,_that.lastPoopAt,_that.lastWalkAt,_that.foodText,_that.foodLow,_that.healthText,_that.healthOverdue,_that.medsText,_that.medsMissed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool ready,  String dogName,  DateTime? lastMealAt,  DateTime? lastPoopAt,  DateTime? lastWalkAt,  String? foodText,  bool foodLow,  String? healthText,  bool healthOverdue,  String? medsText,  bool medsMissed)?  $default,) {final _that = this;
switch (_that) {
case _WidgetSnapshot() when $default != null:
return $default(_that.ready,_that.dogName,_that.lastMealAt,_that.lastPoopAt,_that.lastWalkAt,_that.foodText,_that.foodLow,_that.healthText,_that.healthOverdue,_that.medsText,_that.medsMissed);case _:
  return null;

}
}

}

/// @nodoc


class _WidgetSnapshot extends WidgetSnapshot {
  const _WidgetSnapshot({this.ready = false, this.dogName = '', this.lastMealAt, this.lastPoopAt, this.lastWalkAt, this.foodText, this.foodLow = false, this.healthText, this.healthOverdue = false, this.medsText, this.medsMissed = false}): super._();
  

@override@JsonKey() final  bool ready;
@override@JsonKey() final  String dogName;
@override final  DateTime? lastMealAt;
@override final  DateTime? lastPoopAt;
@override final  DateTime? lastWalkAt;
/// E.g. "Karma: ~9 dni"; null hides the line.
@override final  String? foodText;
@override@JsonKey() final  bool foodLow;
/// E.g. "1 termin po terminie"; null hides the line.
@override final  String? healthText;
@override@JsonKey() final  bool healthOverdue;
/// E.g. "Leki: 0/1 dziś"; null when no doses are due today.
@override final  String? medsText;
/// A dose due earlier today hasn't been ticked.
@override@JsonKey() final  bool medsMissed;

/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WidgetSnapshotCopyWith<_WidgetSnapshot> get copyWith => __$WidgetSnapshotCopyWithImpl<_WidgetSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WidgetSnapshot&&(identical(other.ready, ready) || other.ready == ready)&&(identical(other.dogName, dogName) || other.dogName == dogName)&&(identical(other.lastMealAt, lastMealAt) || other.lastMealAt == lastMealAt)&&(identical(other.lastPoopAt, lastPoopAt) || other.lastPoopAt == lastPoopAt)&&(identical(other.lastWalkAt, lastWalkAt) || other.lastWalkAt == lastWalkAt)&&(identical(other.foodText, foodText) || other.foodText == foodText)&&(identical(other.foodLow, foodLow) || other.foodLow == foodLow)&&(identical(other.healthText, healthText) || other.healthText == healthText)&&(identical(other.healthOverdue, healthOverdue) || other.healthOverdue == healthOverdue)&&(identical(other.medsText, medsText) || other.medsText == medsText)&&(identical(other.medsMissed, medsMissed) || other.medsMissed == medsMissed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ready,dogName,lastMealAt,lastPoopAt,lastWalkAt,foodText,foodLow,healthText,healthOverdue,medsText,medsMissed);
}

@override
String toString() {
    return 'WidgetSnapshot(ready: $ready, dogName: $dogName, lastMealAt: $lastMealAt, lastPoopAt: $lastPoopAt, lastWalkAt: $lastWalkAt, foodText: $foodText, foodLow: $foodLow, healthText: $healthText, healthOverdue: $healthOverdue, medsText: $medsText, medsMissed: $medsMissed)';
}


}

/// @nodoc
abstract mixin class _$WidgetSnapshotCopyWith<$Res> implements $WidgetSnapshotCopyWith<$Res> {
  factory _$WidgetSnapshotCopyWith(_WidgetSnapshot value, $Res Function(_WidgetSnapshot) _then) = __$WidgetSnapshotCopyWithImpl;
@override @useResult
$Res call({
 bool ready, String dogName, DateTime? lastMealAt, DateTime? lastPoopAt, DateTime? lastWalkAt, String? foodText, bool foodLow, String? healthText, bool healthOverdue, String? medsText, bool medsMissed
});




}
/// @nodoc
class __$WidgetSnapshotCopyWithImpl<$Res>
    implements _$WidgetSnapshotCopyWith<$Res> {
  __$WidgetSnapshotCopyWithImpl(this._self, this._then);

  final _WidgetSnapshot _self;
  final $Res Function(_WidgetSnapshot) _then;

/// Create a copy of WidgetSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ready = null,Object? dogName = null,Object? lastMealAt = freezed,Object? lastPoopAt = freezed,Object? lastWalkAt = freezed,Object? foodText = freezed,Object? foodLow = null,Object? healthText = freezed,Object? healthOverdue = null,Object? medsText = freezed,Object? medsMissed = null,}) {
  return _then(_WidgetSnapshot(
ready: null == ready ? _self.ready : ready // ignore: cast_nullable_to_non_nullable
as bool,dogName: null == dogName ? _self.dogName : dogName // ignore: cast_nullable_to_non_nullable
as String,lastMealAt: freezed == lastMealAt ? _self.lastMealAt : lastMealAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastPoopAt: freezed == lastPoopAt ? _self.lastPoopAt : lastPoopAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastWalkAt: freezed == lastWalkAt ? _self.lastWalkAt : lastWalkAt // ignore: cast_nullable_to_non_nullable
as DateTime?,foodText: freezed == foodText ? _self.foodText : foodText // ignore: cast_nullable_to_non_nullable
as String?,foodLow: null == foodLow ? _self.foodLow : foodLow // ignore: cast_nullable_to_non_nullable
as bool,healthText: freezed == healthText ? _self.healthText : healthText // ignore: cast_nullable_to_non_nullable
as String?,healthOverdue: null == healthOverdue ? _self.healthOverdue : healthOverdue // ignore: cast_nullable_to_non_nullable
as bool,medsText: freezed == medsText ? _self.medsText : medsText // ignore: cast_nullable_to_non_nullable
as String?,medsMissed: null == medsMissed ? _self.medsMissed : medsMissed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
