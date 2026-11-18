// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'household.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Household {

 String get id; String get name; List<String> get members; Map<String, String> get memberNames; String? get inviteCode;
/// Create a copy of Household
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HouseholdCopyWith<Household> get copyWith => _$HouseholdCopyWithImpl<Household>(this as Household, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Household;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Household&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&const DeepCollectionEquality().equals(other.members, _this.members)&&const DeepCollectionEquality().equals(other.memberNames, _this.memberNames)&&(identical(other.inviteCode, _this.inviteCode) || other.inviteCode == _this.inviteCode));
}


@override
int get hashCode {
  final _this = this as Household;
  return Object.hash(runtimeType,_this.id,_this.name,const DeepCollectionEquality().hash(_this.members),const DeepCollectionEquality().hash(_this.memberNames),_this.inviteCode);
}

@override
String toString() {
  final _this = this as Household;
  return 'Household(id: ${_this.id}, name: ${_this.name}, members: ${_this.members}, memberNames: ${_this.memberNames}, inviteCode: ${_this.inviteCode})';
}


}

/// @nodoc
abstract mixin class $HouseholdCopyWith<$Res>  {
  factory $HouseholdCopyWith(Household value, $Res Function(Household) _then) = _$HouseholdCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<String> members, Map<String, String> memberNames, String? inviteCode
});




}
/// @nodoc
class _$HouseholdCopyWithImpl<$Res>
    implements $HouseholdCopyWith<$Res> {
  _$HouseholdCopyWithImpl(this._self, this._then);

  final Household _self;
  final $Res Function(Household) _then;

/// Create a copy of Household
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? members = null,Object? memberNames = null,Object? inviteCode = freezed,}) {
  return _then(Household(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<String>,memberNames: null == memberNames ? _self.memberNames : memberNames // ignore: cast_nullable_to_non_nullable
as Map<String, String>,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Household].
extension HouseholdPatterns on Household {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Household value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Household() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Household value)  $default,){
final _that = this;
switch (_that) {
case _Household():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Household value)?  $default,){
final _that = this;
switch (_that) {
case _Household() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<String> members,  Map<String, String> memberNames,  String? inviteCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Household() when $default != null:
return $default(_that.id,_that.name,_that.members,_that.memberNames,_that.inviteCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<String> members,  Map<String, String> memberNames,  String? inviteCode)  $default,) {final _that = this;
switch (_that) {
case _Household():
return $default(_that.id,_that.name,_that.members,_that.memberNames,_that.inviteCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<String> members,  Map<String, String> memberNames,  String? inviteCode)?  $default,) {final _that = this;
switch (_that) {
case _Household() when $default != null:
return $default(_that.id,_that.name,_that.members,_that.memberNames,_that.inviteCode);case _:
  return null;

}
}

}

/// @nodoc


class _Household extends Household {
  const _Household({required this.id, required this.name, required  List<String> members,  Map<String, String> memberNames = const {}, this.inviteCode}): _members = members,_memberNames = memberNames,super._();
  

@override final  String id;
@override final  String name;
 final  List<String> _members;
@override List<String> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

 final  Map<String, String> _memberNames;
@override@JsonKey() Map<String, String> get memberNames {
  if (_memberNames is EqualUnmodifiableMapView) return _memberNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_memberNames);
}

@override final  String? inviteCode;

/// Create a copy of Household
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HouseholdCopyWith<_Household> get copyWith => __$HouseholdCopyWithImpl<_Household>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Household&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.members, _members)&&const DeepCollectionEquality().equals(other.memberNames, _memberNames)&&(identical(other.inviteCode, inviteCode) || other.inviteCode == inviteCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_members),const DeepCollectionEquality().hash(_memberNames),inviteCode);
}

@override
String toString() {
    return 'Household(id: $id, name: $name, members: $members, memberNames: $memberNames, inviteCode: $inviteCode)';
}


}

/// @nodoc
abstract mixin class _$HouseholdCopyWith<$Res> implements $HouseholdCopyWith<$Res> {
  factory _$HouseholdCopyWith(_Household value, $Res Function(_Household) _then) = __$HouseholdCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<String> members, Map<String, String> memberNames, String? inviteCode
});




}
/// @nodoc
class __$HouseholdCopyWithImpl<$Res>
    implements _$HouseholdCopyWith<$Res> {
  __$HouseholdCopyWithImpl(this._self, this._then);

  final _Household _self;
  final $Res Function(_Household) _then;

/// Create a copy of Household
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? members = null,Object? memberNames = null,Object? inviteCode = freezed,}) {
  return _then(_Household(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<String>,memberNames: null == memberNames ? _self._memberNames : memberNames // ignore: cast_nullable_to_non_nullable
as Map<String, String>,inviteCode: freezed == inviteCode ? _self.inviteCode : inviteCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
