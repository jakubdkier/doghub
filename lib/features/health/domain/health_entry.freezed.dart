// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HealthEntry {

 String? get id; HealthType get type;/// Template it was created from; null for one-off entries.
 String? get templateId;/// Shown name, copied from the template so renames don't rewrite history.
 String get name;/// Day it was done (stored at noon).
 DateTime get date;/// When the next one is due; null when nothing follows.
 DateTime? get nextDue; String? get note; String get by; DateTime? get createdAt; bool get deleted;
/// Create a copy of HealthEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthEntryCopyWith<HealthEntry> get copyWith => _$HealthEntryCopyWithImpl<HealthEntry>(this as HealthEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HealthEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.templateId, _this.templateId) || other.templateId == _this.templateId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.nextDue, _this.nextDue) || other.nextDue == _this.nextDue)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.by, _this.by) || other.by == _this.by)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.deleted, _this.deleted) || other.deleted == _this.deleted));
}


@override
int get hashCode {
  final _this = this as HealthEntry;
  return Object.hash(runtimeType,_this.id,_this.type,_this.templateId,_this.name,_this.date,_this.nextDue,_this.note,_this.by,_this.createdAt,_this.deleted);
}

@override
String toString() {
  final _this = this as HealthEntry;
  return 'HealthEntry(id: ${_this.id}, type: ${_this.type}, templateId: ${_this.templateId}, name: ${_this.name}, date: ${_this.date}, nextDue: ${_this.nextDue}, note: ${_this.note}, by: ${_this.by}, createdAt: ${_this.createdAt}, deleted: ${_this.deleted})';
}


}

/// @nodoc
abstract mixin class $HealthEntryCopyWith<$Res>  {
  factory $HealthEntryCopyWith(HealthEntry value, $Res Function(HealthEntry) _then) = _$HealthEntryCopyWithImpl;
@useResult
$Res call({
 String? id, HealthType type, String? templateId, String name, DateTime date, DateTime? nextDue, String? note, String by, DateTime? createdAt, bool deleted
});




}
/// @nodoc
class _$HealthEntryCopyWithImpl<$Res>
    implements $HealthEntryCopyWith<$Res> {
  _$HealthEntryCopyWithImpl(this._self, this._then);

  final HealthEntry _self;
  final $Res Function(HealthEntry) _then;

/// Create a copy of HealthEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? type = null,Object? templateId = freezed,Object? name = null,Object? date = null,Object? nextDue = freezed,Object? note = freezed,Object? by = null,Object? createdAt = freezed,Object? deleted = null,}) {
  return _then(HealthEntry(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HealthType,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,nextDue: freezed == nextDue ? _self.nextDue : nextDue // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,by: null == by ? _self.by : by // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HealthEntry].
extension HealthEntryPatterns on HealthEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HealthEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HealthEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HealthEntry value)  $default,){
final _that = this;
switch (_that) {
case _HealthEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HealthEntry value)?  $default,){
final _that = this;
switch (_that) {
case _HealthEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  HealthType type,  String? templateId,  String name,  DateTime date,  DateTime? nextDue,  String? note,  String by,  DateTime? createdAt,  bool deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HealthEntry() when $default != null:
return $default(_that.id,_that.type,_that.templateId,_that.name,_that.date,_that.nextDue,_that.note,_that.by,_that.createdAt,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  HealthType type,  String? templateId,  String name,  DateTime date,  DateTime? nextDue,  String? note,  String by,  DateTime? createdAt,  bool deleted)  $default,) {final _that = this;
switch (_that) {
case _HealthEntry():
return $default(_that.id,_that.type,_that.templateId,_that.name,_that.date,_that.nextDue,_that.note,_that.by,_that.createdAt,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  HealthType type,  String? templateId,  String name,  DateTime date,  DateTime? nextDue,  String? note,  String by,  DateTime? createdAt,  bool deleted)?  $default,) {final _that = this;
switch (_that) {
case _HealthEntry() when $default != null:
return $default(_that.id,_that.type,_that.templateId,_that.name,_that.date,_that.nextDue,_that.note,_that.by,_that.createdAt,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc


class _HealthEntry extends HealthEntry {
  const _HealthEntry({this.id, required this.type, this.templateId, required this.name, required this.date, this.nextDue, this.note, required this.by, this.createdAt, this.deleted = false}): super._();
  

@override final  String? id;
@override final  HealthType type;
/// Template it was created from; null for one-off entries.
@override final  String? templateId;
/// Shown name, copied from the template so renames don't rewrite history.
@override final  String name;
/// Day it was done (stored at noon).
@override final  DateTime date;
/// When the next one is due; null when nothing follows.
@override final  DateTime? nextDue;
@override final  String? note;
@override final  String by;
@override final  DateTime? createdAt;
@override@JsonKey() final  bool deleted;

/// Create a copy of HealthEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HealthEntryCopyWith<_HealthEntry> get copyWith => __$HealthEntryCopyWithImpl<_HealthEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HealthEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.templateId, templateId) || other.templateId == templateId)&&(identical(other.name, name) || other.name == name)&&(identical(other.date, date) || other.date == date)&&(identical(other.nextDue, nextDue) || other.nextDue == nextDue)&&(identical(other.note, note) || other.note == note)&&(identical(other.by, by) || other.by == by)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,type,templateId,name,date,nextDue,note,by,createdAt,deleted);
}

@override
String toString() {
    return 'HealthEntry(id: $id, type: $type, templateId: $templateId, name: $name, date: $date, nextDue: $nextDue, note: $note, by: $by, createdAt: $createdAt, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$HealthEntryCopyWith<$Res> implements $HealthEntryCopyWith<$Res> {
  factory _$HealthEntryCopyWith(_HealthEntry value, $Res Function(_HealthEntry) _then) = __$HealthEntryCopyWithImpl;
@override @useResult
$Res call({
 String? id, HealthType type, String? templateId, String name, DateTime date, DateTime? nextDue, String? note, String by, DateTime? createdAt, bool deleted
});




}
/// @nodoc
class __$HealthEntryCopyWithImpl<$Res>
    implements _$HealthEntryCopyWith<$Res> {
  __$HealthEntryCopyWithImpl(this._self, this._then);

  final _HealthEntry _self;
  final $Res Function(_HealthEntry) _then;

/// Create a copy of HealthEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? type = null,Object? templateId = freezed,Object? name = null,Object? date = null,Object? nextDue = freezed,Object? note = freezed,Object? by = null,Object? createdAt = freezed,Object? deleted = null,}) {
  return _then(_HealthEntry(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HealthType,templateId: freezed == templateId ? _self.templateId : templateId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,nextDue: freezed == nextDue ? _self.nextDue : nextDue // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,by: null == by ? _self.by : by // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
