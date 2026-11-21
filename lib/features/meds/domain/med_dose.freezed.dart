// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'med_dose.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MedDose {

 String get medId; DateTime get slot; DateTime get givenAt; String get by; bool get deleted;
/// Create a copy of MedDose
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedDoseCopyWith<MedDose> get copyWith => _$MedDoseCopyWithImpl<MedDose>(this as MedDose, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MedDose;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedDose&&(identical(other.medId, _this.medId) || other.medId == _this.medId)&&(identical(other.slot, _this.slot) || other.slot == _this.slot)&&(identical(other.givenAt, _this.givenAt) || other.givenAt == _this.givenAt)&&(identical(other.by, _this.by) || other.by == _this.by)&&(identical(other.deleted, _this.deleted) || other.deleted == _this.deleted));
}


@override
int get hashCode {
  final _this = this as MedDose;
  return Object.hash(runtimeType,_this.medId,_this.slot,_this.givenAt,_this.by,_this.deleted);
}

@override
String toString() {
  final _this = this as MedDose;
  return 'MedDose(medId: ${_this.medId}, slot: ${_this.slot}, givenAt: ${_this.givenAt}, by: ${_this.by}, deleted: ${_this.deleted})';
}


}

/// @nodoc
abstract mixin class $MedDoseCopyWith<$Res>  {
  factory $MedDoseCopyWith(MedDose value, $Res Function(MedDose) _then) = _$MedDoseCopyWithImpl;
@useResult
$Res call({
 String medId, DateTime slot, DateTime givenAt, String by, bool deleted
});




}
/// @nodoc
class _$MedDoseCopyWithImpl<$Res>
    implements $MedDoseCopyWith<$Res> {
  _$MedDoseCopyWithImpl(this._self, this._then);

  final MedDose _self;
  final $Res Function(MedDose) _then;

/// Create a copy of MedDose
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? medId = null,Object? slot = null,Object? givenAt = null,Object? by = null,Object? deleted = null,}) {
  return _then(MedDose(
medId: null == medId ? _self.medId : medId // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as DateTime,givenAt: null == givenAt ? _self.givenAt : givenAt // ignore: cast_nullable_to_non_nullable
as DateTime,by: null == by ? _self.by : by // ignore: cast_nullable_to_non_nullable
as String,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MedDose].
extension MedDosePatterns on MedDose {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedDose value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedDose() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedDose value)  $default,){
final _that = this;
switch (_that) {
case _MedDose():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedDose value)?  $default,){
final _that = this;
switch (_that) {
case _MedDose() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String medId,  DateTime slot,  DateTime givenAt,  String by,  bool deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedDose() when $default != null:
return $default(_that.medId,_that.slot,_that.givenAt,_that.by,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String medId,  DateTime slot,  DateTime givenAt,  String by,  bool deleted)  $default,) {final _that = this;
switch (_that) {
case _MedDose():
return $default(_that.medId,_that.slot,_that.givenAt,_that.by,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String medId,  DateTime slot,  DateTime givenAt,  String by,  bool deleted)?  $default,) {final _that = this;
switch (_that) {
case _MedDose() when $default != null:
return $default(_that.medId,_that.slot,_that.givenAt,_that.by,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc


class _MedDose extends MedDose {
  const _MedDose({required this.medId, required this.slot, required this.givenAt, required this.by, this.deleted = false}): super._();
  

@override final  String medId;
@override final  DateTime slot;
@override final  DateTime givenAt;
@override final  String by;
@override@JsonKey() final  bool deleted;

/// Create a copy of MedDose
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedDoseCopyWith<_MedDose> get copyWith => __$MedDoseCopyWithImpl<_MedDose>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedDose&&(identical(other.medId, medId) || other.medId == medId)&&(identical(other.slot, slot) || other.slot == slot)&&(identical(other.givenAt, givenAt) || other.givenAt == givenAt)&&(identical(other.by, by) || other.by == by)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}


@override
int get hashCode {
    return Object.hash(runtimeType,medId,slot,givenAt,by,deleted);
}

@override
String toString() {
    return 'MedDose(medId: $medId, slot: $slot, givenAt: $givenAt, by: $by, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$MedDoseCopyWith<$Res> implements $MedDoseCopyWith<$Res> {
  factory _$MedDoseCopyWith(_MedDose value, $Res Function(_MedDose) _then) = __$MedDoseCopyWithImpl;
@override @useResult
$Res call({
 String medId, DateTime slot, DateTime givenAt, String by, bool deleted
});




}
/// @nodoc
class __$MedDoseCopyWithImpl<$Res>
    implements _$MedDoseCopyWith<$Res> {
  __$MedDoseCopyWithImpl(this._self, this._then);

  final _MedDose _self;
  final $Res Function(_MedDose) _then;

/// Create a copy of MedDose
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? medId = null,Object? slot = null,Object? givenAt = null,Object? by = null,Object? deleted = null,}) {
  return _then(_MedDose(
medId: null == medId ? _self.medId : medId // ignore: cast_nullable_to_non_nullable
as String,slot: null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as DateTime,givenAt: null == givenAt ? _self.givenAt : givenAt // ignore: cast_nullable_to_non_nullable
as DateTime,by: null == by ? _self.by : by // ignore: cast_nullable_to_non_nullable
as String,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
