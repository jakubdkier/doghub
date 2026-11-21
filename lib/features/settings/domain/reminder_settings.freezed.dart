// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReminderSettings {

 bool get foodEnabled;/// Remind when a food's stock drops to this many kg.
 double get foodThresholdKg; bool get weighEnabled; int get hour; int get minute;
/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReminderSettingsCopyWith<ReminderSettings> get copyWith => _$ReminderSettingsCopyWithImpl<ReminderSettings>(this as ReminderSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReminderSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReminderSettings&&(identical(other.foodEnabled, _this.foodEnabled) || other.foodEnabled == _this.foodEnabled)&&(identical(other.foodThresholdKg, _this.foodThresholdKg) || other.foodThresholdKg == _this.foodThresholdKg)&&(identical(other.weighEnabled, _this.weighEnabled) || other.weighEnabled == _this.weighEnabled)&&(identical(other.hour, _this.hour) || other.hour == _this.hour)&&(identical(other.minute, _this.minute) || other.minute == _this.minute));
}


@override
int get hashCode {
  final _this = this as ReminderSettings;
  return Object.hash(runtimeType,_this.foodEnabled,_this.foodThresholdKg,_this.weighEnabled,_this.hour,_this.minute);
}

@override
String toString() {
  final _this = this as ReminderSettings;
  return 'ReminderSettings(foodEnabled: ${_this.foodEnabled}, foodThresholdKg: ${_this.foodThresholdKg}, weighEnabled: ${_this.weighEnabled}, hour: ${_this.hour}, minute: ${_this.minute})';
}


}

/// @nodoc
abstract mixin class $ReminderSettingsCopyWith<$Res>  {
  factory $ReminderSettingsCopyWith(ReminderSettings value, $Res Function(ReminderSettings) _then) = _$ReminderSettingsCopyWithImpl;
@useResult
$Res call({
 bool foodEnabled, double foodThresholdKg, bool weighEnabled, int hour, int minute
});




}
/// @nodoc
class _$ReminderSettingsCopyWithImpl<$Res>
    implements $ReminderSettingsCopyWith<$Res> {
  _$ReminderSettingsCopyWithImpl(this._self, this._then);

  final ReminderSettings _self;
  final $Res Function(ReminderSettings) _then;

/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? foodEnabled = null,Object? foodThresholdKg = null,Object? weighEnabled = null,Object? hour = null,Object? minute = null,}) {
  return _then(ReminderSettings(
foodEnabled: null == foodEnabled ? _self.foodEnabled : foodEnabled // ignore: cast_nullable_to_non_nullable
as bool,foodThresholdKg: null == foodThresholdKg ? _self.foodThresholdKg : foodThresholdKg // ignore: cast_nullable_to_non_nullable
as double,weighEnabled: null == weighEnabled ? _self.weighEnabled : weighEnabled // ignore: cast_nullable_to_non_nullable
as bool,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReminderSettings].
extension ReminderSettingsPatterns on ReminderSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReminderSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReminderSettings value)  $default,){
final _that = this;
switch (_that) {
case _ReminderSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReminderSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool foodEnabled,  double foodThresholdKg,  bool weighEnabled,  int hour,  int minute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
return $default(_that.foodEnabled,_that.foodThresholdKg,_that.weighEnabled,_that.hour,_that.minute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool foodEnabled,  double foodThresholdKg,  bool weighEnabled,  int hour,  int minute)  $default,) {final _that = this;
switch (_that) {
case _ReminderSettings():
return $default(_that.foodEnabled,_that.foodThresholdKg,_that.weighEnabled,_that.hour,_that.minute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool foodEnabled,  double foodThresholdKg,  bool weighEnabled,  int hour,  int minute)?  $default,) {final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
return $default(_that.foodEnabled,_that.foodThresholdKg,_that.weighEnabled,_that.hour,_that.minute);case _:
  return null;

}
}

}

/// @nodoc


class _ReminderSettings implements ReminderSettings {
  const _ReminderSettings({this.foodEnabled = true, this.foodThresholdKg = 2.0, this.weighEnabled = true, this.hour = 18, this.minute = 0});
  

@override@JsonKey() final  bool foodEnabled;
/// Remind when a food's stock drops to this many kg.
@override@JsonKey() final  double foodThresholdKg;
@override@JsonKey() final  bool weighEnabled;
@override@JsonKey() final  int hour;
@override@JsonKey() final  int minute;

/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReminderSettingsCopyWith<_ReminderSettings> get copyWith => __$ReminderSettingsCopyWithImpl<_ReminderSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReminderSettings&&(identical(other.foodEnabled, foodEnabled) || other.foodEnabled == foodEnabled)&&(identical(other.foodThresholdKg, foodThresholdKg) || other.foodThresholdKg == foodThresholdKg)&&(identical(other.weighEnabled, weighEnabled) || other.weighEnabled == weighEnabled)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}


@override
int get hashCode {
    return Object.hash(runtimeType,foodEnabled,foodThresholdKg,weighEnabled,hour,minute);
}

@override
String toString() {
    return 'ReminderSettings(foodEnabled: $foodEnabled, foodThresholdKg: $foodThresholdKg, weighEnabled: $weighEnabled, hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class _$ReminderSettingsCopyWith<$Res> implements $ReminderSettingsCopyWith<$Res> {
  factory _$ReminderSettingsCopyWith(_ReminderSettings value, $Res Function(_ReminderSettings) _then) = __$ReminderSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool foodEnabled, double foodThresholdKg, bool weighEnabled, int hour, int minute
});




}
/// @nodoc
class __$ReminderSettingsCopyWithImpl<$Res>
    implements _$ReminderSettingsCopyWith<$Res> {
  __$ReminderSettingsCopyWithImpl(this._self, this._then);

  final _ReminderSettings _self;
  final $Res Function(_ReminderSettings) _then;

/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? foodEnabled = null,Object? foodThresholdKg = null,Object? weighEnabled = null,Object? hour = null,Object? minute = null,}) {
  return _then(_ReminderSettings(
foodEnabled: null == foodEnabled ? _self.foodEnabled : foodEnabled // ignore: cast_nullable_to_non_nullable
as bool,foodThresholdKg: null == foodThresholdKg ? _self.foodThresholdKg : foodThresholdKg // ignore: cast_nullable_to_non_nullable
as double,weighEnabled: null == weighEnabled ? _self.weighEnabled : weighEnabled // ignore: cast_nullable_to_non_nullable
as bool,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
