// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'med.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MedTime {

 int get hour; int get minute;
/// Create a copy of MedTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedTimeCopyWith<MedTime> get copyWith => _$MedTimeCopyWithImpl<MedTime>(this as MedTime, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MedTime;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedTime&&(identical(other.hour, _this.hour) || other.hour == _this.hour)&&(identical(other.minute, _this.minute) || other.minute == _this.minute));
}


@override
int get hashCode {
  final _this = this as MedTime;
  return Object.hash(runtimeType,_this.hour,_this.minute);
}

@override
String toString() {
  final _this = this as MedTime;
  return 'MedTime(hour: ${_this.hour}, minute: ${_this.minute})';
}


}

/// @nodoc
abstract mixin class $MedTimeCopyWith<$Res>  {
  factory $MedTimeCopyWith(MedTime value, $Res Function(MedTime) _then) = _$MedTimeCopyWithImpl;
@useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class _$MedTimeCopyWithImpl<$Res>
    implements $MedTimeCopyWith<$Res> {
  _$MedTimeCopyWithImpl(this._self, this._then);

  final MedTime _self;
  final $Res Function(MedTime) _then;

/// Create a copy of MedTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hour = null,Object? minute = null,}) {
  return _then(MedTime(
null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MedTime].
extension MedTimePatterns on MedTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedTime value)  $default,){
final _that = this;
switch (_that) {
case _MedTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedTime value)?  $default,){
final _that = this;
switch (_that) {
case _MedTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int hour,  int minute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedTime() when $default != null:
return $default(_that.hour,_that.minute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int hour,  int minute)  $default,) {final _that = this;
switch (_that) {
case _MedTime():
return $default(_that.hour,_that.minute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int hour,  int minute)?  $default,) {final _that = this;
switch (_that) {
case _MedTime() when $default != null:
return $default(_that.hour,_that.minute);case _:
  return null;

}
}

}

/// @nodoc


class _MedTime extends MedTime {
  const _MedTime(this.hour, this.minute): super._();
  

@override final  int hour;
@override final  int minute;

/// Create a copy of MedTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedTimeCopyWith<_MedTime> get copyWith => __$MedTimeCopyWithImpl<_MedTime>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedTime&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.minute, minute) || other.minute == minute));
}


@override
int get hashCode {
    return Object.hash(runtimeType,hour,minute);
}

@override
String toString() {
    return 'MedTime(hour: $hour, minute: $minute)';
}


}

/// @nodoc
abstract mixin class _$MedTimeCopyWith<$Res> implements $MedTimeCopyWith<$Res> {
  factory _$MedTimeCopyWith(_MedTime value, $Res Function(_MedTime) _then) = __$MedTimeCopyWithImpl;
@override @useResult
$Res call({
 int hour, int minute
});




}
/// @nodoc
class __$MedTimeCopyWithImpl<$Res>
    implements _$MedTimeCopyWith<$Res> {
  __$MedTimeCopyWithImpl(this._self, this._then);

  final _MedTime _self;
  final $Res Function(_MedTime) _then;

/// Create a copy of MedTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hour = null,Object? minute = null,}) {
  return _then(_MedTime(
null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$Med {

 String get id; String get name;/// E.g. "1 tabletka".
 String? get dose; MedScheduleType get scheduleType;/// Daily: 1-3 times. Interval: the first time is used.
 List<MedTime> get times;/// Every N days (interval schedules only).
 int? get intervalDays;/// First day of the course.
 DateTime get startDate;/// Last day of the course; null = open-ended.
 DateTime? get endDate; bool get active; String? get note; DateTime? get createdAt;
/// Create a copy of Med
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedCopyWith<Med> get copyWith => _$MedCopyWithImpl<Med>(this as Med, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Med;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Med&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.dose, _this.dose) || other.dose == _this.dose)&&(identical(other.scheduleType, _this.scheduleType) || other.scheduleType == _this.scheduleType)&&const DeepCollectionEquality().equals(other.times, _this.times)&&(identical(other.intervalDays, _this.intervalDays) || other.intervalDays == _this.intervalDays)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.active, _this.active) || other.active == _this.active)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as Med;
  return Object.hash(runtimeType,_this.id,_this.name,_this.dose,_this.scheduleType,const DeepCollectionEquality().hash(_this.times),_this.intervalDays,_this.startDate,_this.endDate,_this.active,_this.note,_this.createdAt);
}

@override
String toString() {
  final _this = this as Med;
  return 'Med(id: ${_this.id}, name: ${_this.name}, dose: ${_this.dose}, scheduleType: ${_this.scheduleType}, times: ${_this.times}, intervalDays: ${_this.intervalDays}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, active: ${_this.active}, note: ${_this.note}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $MedCopyWith<$Res>  {
  factory $MedCopyWith(Med value, $Res Function(Med) _then) = _$MedCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? dose, MedScheduleType scheduleType, List<MedTime> times, int? intervalDays, DateTime startDate, DateTime? endDate, bool active, String? note, DateTime? createdAt
});




}
/// @nodoc
class _$MedCopyWithImpl<$Res>
    implements $MedCopyWith<$Res> {
  _$MedCopyWithImpl(this._self, this._then);

  final Med _self;
  final $Res Function(Med) _then;

/// Create a copy of Med
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? dose = freezed,Object? scheduleType = null,Object? times = null,Object? intervalDays = freezed,Object? startDate = null,Object? endDate = freezed,Object? active = null,Object? note = freezed,Object? createdAt = freezed,}) {
  return _then(Med(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dose: freezed == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String?,scheduleType: null == scheduleType ? _self.scheduleType : scheduleType // ignore: cast_nullable_to_non_nullable
as MedScheduleType,times: null == times ? _self.times : times // ignore: cast_nullable_to_non_nullable
as List<MedTime>,intervalDays: freezed == intervalDays ? _self.intervalDays : intervalDays // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Med].
extension MedPatterns on Med {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Med value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Med() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Med value)  $default,){
final _that = this;
switch (_that) {
case _Med():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Med value)?  $default,){
final _that = this;
switch (_that) {
case _Med() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? dose,  MedScheduleType scheduleType,  List<MedTime> times,  int? intervalDays,  DateTime startDate,  DateTime? endDate,  bool active,  String? note,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Med() when $default != null:
return $default(_that.id,_that.name,_that.dose,_that.scheduleType,_that.times,_that.intervalDays,_that.startDate,_that.endDate,_that.active,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? dose,  MedScheduleType scheduleType,  List<MedTime> times,  int? intervalDays,  DateTime startDate,  DateTime? endDate,  bool active,  String? note,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Med():
return $default(_that.id,_that.name,_that.dose,_that.scheduleType,_that.times,_that.intervalDays,_that.startDate,_that.endDate,_that.active,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? dose,  MedScheduleType scheduleType,  List<MedTime> times,  int? intervalDays,  DateTime startDate,  DateTime? endDate,  bool active,  String? note,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Med() when $default != null:
return $default(_that.id,_that.name,_that.dose,_that.scheduleType,_that.times,_that.intervalDays,_that.startDate,_that.endDate,_that.active,_that.note,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Med extends Med {
  const _Med({required this.id, required this.name, this.dose, this.scheduleType = MedScheduleType.daily, required  List<MedTime> times, this.intervalDays, required this.startDate, this.endDate, this.active = true, this.note, this.createdAt}): _times = times,super._();
  

@override final  String id;
@override final  String name;
/// E.g. "1 tabletka".
@override final  String? dose;
@override@JsonKey() final  MedScheduleType scheduleType;
/// Daily: 1-3 times. Interval: the first time is used.
 final  List<MedTime> _times;
/// Daily: 1-3 times. Interval: the first time is used.
@override List<MedTime> get times {
  if (_times is EqualUnmodifiableListView) return _times;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_times);
}

/// Every N days (interval schedules only).
@override final  int? intervalDays;
/// First day of the course.
@override final  DateTime startDate;
/// Last day of the course; null = open-ended.
@override final  DateTime? endDate;
@override@JsonKey() final  bool active;
@override final  String? note;
@override final  DateTime? createdAt;

/// Create a copy of Med
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedCopyWith<_Med> get copyWith => __$MedCopyWithImpl<_Med>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Med&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.dose, dose) || other.dose == dose)&&(identical(other.scheduleType, scheduleType) || other.scheduleType == scheduleType)&&const DeepCollectionEquality().equals(other.times, _times)&&(identical(other.intervalDays, intervalDays) || other.intervalDays == intervalDays)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.active, active) || other.active == active)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,dose,scheduleType,const DeepCollectionEquality().hash(_times),intervalDays,startDate,endDate,active,note,createdAt);
}

@override
String toString() {
    return 'Med(id: $id, name: $name, dose: $dose, scheduleType: $scheduleType, times: $times, intervalDays: $intervalDays, startDate: $startDate, endDate: $endDate, active: $active, note: $note, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MedCopyWith<$Res> implements $MedCopyWith<$Res> {
  factory _$MedCopyWith(_Med value, $Res Function(_Med) _then) = __$MedCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? dose, MedScheduleType scheduleType, List<MedTime> times, int? intervalDays, DateTime startDate, DateTime? endDate, bool active, String? note, DateTime? createdAt
});




}
/// @nodoc
class __$MedCopyWithImpl<$Res>
    implements _$MedCopyWith<$Res> {
  __$MedCopyWithImpl(this._self, this._then);

  final _Med _self;
  final $Res Function(_Med) _then;

/// Create a copy of Med
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? dose = freezed,Object? scheduleType = null,Object? times = null,Object? intervalDays = freezed,Object? startDate = null,Object? endDate = freezed,Object? active = null,Object? note = freezed,Object? createdAt = freezed,}) {
  return _then(_Med(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dose: freezed == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String?,scheduleType: null == scheduleType ? _self.scheduleType : scheduleType // ignore: cast_nullable_to_non_nullable
as MedScheduleType,times: null == times ? _self._times : times // ignore: cast_nullable_to_non_nullable
as List<MedTime>,intervalDays: freezed == intervalDays ? _self.intervalDays : intervalDays // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
