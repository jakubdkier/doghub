// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HealthTemplate {

 String get id; String get name; HealthType get type;/// Months until the next one; null when there's no fixed schedule.
 int? get intervalMonths; bool get mandatory; bool get active;
/// Create a copy of HealthTemplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HealthTemplateCopyWith<HealthTemplate> get copyWith => _$HealthTemplateCopyWithImpl<HealthTemplate>(this as HealthTemplate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HealthTemplate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HealthTemplate&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.intervalMonths, _this.intervalMonths) || other.intervalMonths == _this.intervalMonths)&&(identical(other.mandatory, _this.mandatory) || other.mandatory == _this.mandatory)&&(identical(other.active, _this.active) || other.active == _this.active));
}


@override
int get hashCode {
  final _this = this as HealthTemplate;
  return Object.hash(runtimeType,_this.id,_this.name,_this.type,_this.intervalMonths,_this.mandatory,_this.active);
}

@override
String toString() {
  final _this = this as HealthTemplate;
  return 'HealthTemplate(id: ${_this.id}, name: ${_this.name}, type: ${_this.type}, intervalMonths: ${_this.intervalMonths}, mandatory: ${_this.mandatory}, active: ${_this.active})';
}


}

/// @nodoc
abstract mixin class $HealthTemplateCopyWith<$Res>  {
  factory $HealthTemplateCopyWith(HealthTemplate value, $Res Function(HealthTemplate) _then) = _$HealthTemplateCopyWithImpl;
@useResult
$Res call({
 String id, String name, HealthType type, int? intervalMonths, bool mandatory, bool active
});




}
/// @nodoc
class _$HealthTemplateCopyWithImpl<$Res>
    implements $HealthTemplateCopyWith<$Res> {
  _$HealthTemplateCopyWithImpl(this._self, this._then);

  final HealthTemplate _self;
  final $Res Function(HealthTemplate) _then;

/// Create a copy of HealthTemplate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? intervalMonths = freezed,Object? mandatory = null,Object? active = null,}) {
  return _then(HealthTemplate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HealthType,intervalMonths: freezed == intervalMonths ? _self.intervalMonths : intervalMonths // ignore: cast_nullable_to_non_nullable
as int?,mandatory: null == mandatory ? _self.mandatory : mandatory // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HealthTemplate].
extension HealthTemplatePatterns on HealthTemplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HealthTemplate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HealthTemplate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HealthTemplate value)  $default,){
final _that = this;
switch (_that) {
case _HealthTemplate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HealthTemplate value)?  $default,){
final _that = this;
switch (_that) {
case _HealthTemplate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  HealthType type,  int? intervalMonths,  bool mandatory,  bool active)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HealthTemplate() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.intervalMonths,_that.mandatory,_that.active);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  HealthType type,  int? intervalMonths,  bool mandatory,  bool active)  $default,) {final _that = this;
switch (_that) {
case _HealthTemplate():
return $default(_that.id,_that.name,_that.type,_that.intervalMonths,_that.mandatory,_that.active);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  HealthType type,  int? intervalMonths,  bool mandatory,  bool active)?  $default,) {final _that = this;
switch (_that) {
case _HealthTemplate() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.intervalMonths,_that.mandatory,_that.active);case _:
  return null;

}
}

}

/// @nodoc


class _HealthTemplate extends HealthTemplate {
  const _HealthTemplate({required this.id, required this.name, required this.type, this.intervalMonths, this.mandatory = false, this.active = true}): super._();
  

@override final  String id;
@override final  String name;
@override final  HealthType type;
/// Months until the next one; null when there's no fixed schedule.
@override final  int? intervalMonths;
@override@JsonKey() final  bool mandatory;
@override@JsonKey() final  bool active;

/// Create a copy of HealthTemplate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HealthTemplateCopyWith<_HealthTemplate> get copyWith => __$HealthTemplateCopyWithImpl<_HealthTemplate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HealthTemplate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.intervalMonths, intervalMonths) || other.intervalMonths == intervalMonths)&&(identical(other.mandatory, mandatory) || other.mandatory == mandatory)&&(identical(other.active, active) || other.active == active));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,type,intervalMonths,mandatory,active);
}

@override
String toString() {
    return 'HealthTemplate(id: $id, name: $name, type: $type, intervalMonths: $intervalMonths, mandatory: $mandatory, active: $active)';
}


}

/// @nodoc
abstract mixin class _$HealthTemplateCopyWith<$Res> implements $HealthTemplateCopyWith<$Res> {
  factory _$HealthTemplateCopyWith(_HealthTemplate value, $Res Function(_HealthTemplate) _then) = __$HealthTemplateCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, HealthType type, int? intervalMonths, bool mandatory, bool active
});




}
/// @nodoc
class __$HealthTemplateCopyWithImpl<$Res>
    implements _$HealthTemplateCopyWith<$Res> {
  __$HealthTemplateCopyWithImpl(this._self, this._then);

  final _HealthTemplate _self;
  final $Res Function(_HealthTemplate) _then;

/// Create a copy of HealthTemplate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? intervalMonths = freezed,Object? mandatory = null,Object? active = null,}) {
  return _then(_HealthTemplate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as HealthType,intervalMonths: freezed == intervalMonths ? _self.intervalMonths : intervalMonths // ignore: cast_nullable_to_non_nullable
as int?,mandatory: null == mandatory ? _self.mandatory : mandatory // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
