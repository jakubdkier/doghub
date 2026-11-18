// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dog_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DogEvent {

/// Null until assigned by the repository.
 String? get id; EventType get type;/// When it happened (device time, user-editable). Used for sorting.
 DateTime get at;/// Uid of the creator; never changes.
 String get by;/// Server time of creation; null until synced.
 DateTime? get createdAt; String? get foodId; int? get grams; int? get poopScore; PoopColor? get poopColor; int? get durationMin; String? get note; bool get deleted;
/// Create a copy of DogEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DogEventCopyWith<DogEvent> get copyWith => _$DogEventCopyWithImpl<DogEvent>(this as DogEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DogEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DogEvent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.by, _this.by) || other.by == _this.by)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.foodId, _this.foodId) || other.foodId == _this.foodId)&&(identical(other.grams, _this.grams) || other.grams == _this.grams)&&(identical(other.poopScore, _this.poopScore) || other.poopScore == _this.poopScore)&&(identical(other.poopColor, _this.poopColor) || other.poopColor == _this.poopColor)&&(identical(other.durationMin, _this.durationMin) || other.durationMin == _this.durationMin)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.deleted, _this.deleted) || other.deleted == _this.deleted));
}


@override
int get hashCode {
  final _this = this as DogEvent;
  return Object.hash(runtimeType,_this.id,_this.type,_this.at,_this.by,_this.createdAt,_this.foodId,_this.grams,_this.poopScore,_this.poopColor,_this.durationMin,_this.note,_this.deleted);
}

@override
String toString() {
  final _this = this as DogEvent;
  return 'DogEvent(id: ${_this.id}, type: ${_this.type}, at: ${_this.at}, by: ${_this.by}, createdAt: ${_this.createdAt}, foodId: ${_this.foodId}, grams: ${_this.grams}, poopScore: ${_this.poopScore}, poopColor: ${_this.poopColor}, durationMin: ${_this.durationMin}, note: ${_this.note}, deleted: ${_this.deleted})';
}


}

/// @nodoc
abstract mixin class $DogEventCopyWith<$Res>  {
  factory $DogEventCopyWith(DogEvent value, $Res Function(DogEvent) _then) = _$DogEventCopyWithImpl;
@useResult
$Res call({
 String? id, EventType type, DateTime at, String by, DateTime? createdAt, String? foodId, int? grams, int? poopScore, PoopColor? poopColor, int? durationMin, String? note, bool deleted
});




}
/// @nodoc
class _$DogEventCopyWithImpl<$Res>
    implements $DogEventCopyWith<$Res> {
  _$DogEventCopyWithImpl(this._self, this._then);

  final DogEvent _self;
  final $Res Function(DogEvent) _then;

/// Create a copy of DogEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? type = null,Object? at = null,Object? by = null,Object? createdAt = freezed,Object? foodId = freezed,Object? grams = freezed,Object? poopScore = freezed,Object? poopColor = freezed,Object? durationMin = freezed,Object? note = freezed,Object? deleted = null,}) {
  return _then(DogEvent(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,by: null == by ? _self.by : by // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,foodId: freezed == foodId ? _self.foodId : foodId // ignore: cast_nullable_to_non_nullable
as String?,grams: freezed == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as int?,poopScore: freezed == poopScore ? _self.poopScore : poopScore // ignore: cast_nullable_to_non_nullable
as int?,poopColor: freezed == poopColor ? _self.poopColor : poopColor // ignore: cast_nullable_to_non_nullable
as PoopColor?,durationMin: freezed == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DogEvent].
extension DogEventPatterns on DogEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DogEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DogEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DogEvent value)  $default,){
final _that = this;
switch (_that) {
case _DogEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DogEvent value)?  $default,){
final _that = this;
switch (_that) {
case _DogEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  EventType type,  DateTime at,  String by,  DateTime? createdAt,  String? foodId,  int? grams,  int? poopScore,  PoopColor? poopColor,  int? durationMin,  String? note,  bool deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DogEvent() when $default != null:
return $default(_that.id,_that.type,_that.at,_that.by,_that.createdAt,_that.foodId,_that.grams,_that.poopScore,_that.poopColor,_that.durationMin,_that.note,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  EventType type,  DateTime at,  String by,  DateTime? createdAt,  String? foodId,  int? grams,  int? poopScore,  PoopColor? poopColor,  int? durationMin,  String? note,  bool deleted)  $default,) {final _that = this;
switch (_that) {
case _DogEvent():
return $default(_that.id,_that.type,_that.at,_that.by,_that.createdAt,_that.foodId,_that.grams,_that.poopScore,_that.poopColor,_that.durationMin,_that.note,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  EventType type,  DateTime at,  String by,  DateTime? createdAt,  String? foodId,  int? grams,  int? poopScore,  PoopColor? poopColor,  int? durationMin,  String? note,  bool deleted)?  $default,) {final _that = this;
switch (_that) {
case _DogEvent() when $default != null:
return $default(_that.id,_that.type,_that.at,_that.by,_that.createdAt,_that.foodId,_that.grams,_that.poopScore,_that.poopColor,_that.durationMin,_that.note,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc


class _DogEvent extends DogEvent {
  const _DogEvent({this.id, required this.type, required this.at, required this.by, this.createdAt, this.foodId, this.grams, this.poopScore, this.poopColor, this.durationMin, this.note, this.deleted = false}): super._();
  

/// Null until assigned by the repository.
@override final  String? id;
@override final  EventType type;
/// When it happened (device time, user-editable). Used for sorting.
@override final  DateTime at;
/// Uid of the creator; never changes.
@override final  String by;
/// Server time of creation; null until synced.
@override final  DateTime? createdAt;
@override final  String? foodId;
@override final  int? grams;
@override final  int? poopScore;
@override final  PoopColor? poopColor;
@override final  int? durationMin;
@override final  String? note;
@override@JsonKey() final  bool deleted;

/// Create a copy of DogEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DogEventCopyWith<_DogEvent> get copyWith => __$DogEventCopyWithImpl<_DogEvent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DogEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.at, at) || other.at == at)&&(identical(other.by, by) || other.by == by)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.foodId, foodId) || other.foodId == foodId)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.poopScore, poopScore) || other.poopScore == poopScore)&&(identical(other.poopColor, poopColor) || other.poopColor == poopColor)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.note, note) || other.note == note)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,type,at,by,createdAt,foodId,grams,poopScore,poopColor,durationMin,note,deleted);
}

@override
String toString() {
    return 'DogEvent(id: $id, type: $type, at: $at, by: $by, createdAt: $createdAt, foodId: $foodId, grams: $grams, poopScore: $poopScore, poopColor: $poopColor, durationMin: $durationMin, note: $note, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$DogEventCopyWith<$Res> implements $DogEventCopyWith<$Res> {
  factory _$DogEventCopyWith(_DogEvent value, $Res Function(_DogEvent) _then) = __$DogEventCopyWithImpl;
@override @useResult
$Res call({
 String? id, EventType type, DateTime at, String by, DateTime? createdAt, String? foodId, int? grams, int? poopScore, PoopColor? poopColor, int? durationMin, String? note, bool deleted
});




}
/// @nodoc
class __$DogEventCopyWithImpl<$Res>
    implements _$DogEventCopyWith<$Res> {
  __$DogEventCopyWithImpl(this._self, this._then);

  final _DogEvent _self;
  final $Res Function(_DogEvent) _then;

/// Create a copy of DogEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? type = null,Object? at = null,Object? by = null,Object? createdAt = freezed,Object? foodId = freezed,Object? grams = freezed,Object? poopScore = freezed,Object? poopColor = freezed,Object? durationMin = freezed,Object? note = freezed,Object? deleted = null,}) {
  return _then(_DogEvent(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,by: null == by ? _self.by : by // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,foodId: freezed == foodId ? _self.foodId : foodId // ignore: cast_nullable_to_non_nullable
as String?,grams: freezed == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as int?,poopScore: freezed == poopScore ? _self.poopScore : poopScore // ignore: cast_nullable_to_non_nullable
as int?,poopColor: freezed == poopColor ? _self.poopColor : poopColor // ignore: cast_nullable_to_non_nullable
as PoopColor?,durationMin: freezed == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
