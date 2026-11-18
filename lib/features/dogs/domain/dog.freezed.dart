// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Dog {

 String get id; String get name; String? get breed; DateTime? get birthDate;/// Null until the server timestamp is synced.
 DateTime? get createdAt;
/// Create a copy of Dog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DogCopyWith<Dog> get copyWith => _$DogCopyWithImpl<Dog>(this as Dog, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Dog;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Dog&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.breed, _this.breed) || other.breed == _this.breed)&&(identical(other.birthDate, _this.birthDate) || other.birthDate == _this.birthDate)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as Dog;
  return Object.hash(runtimeType,_this.id,_this.name,_this.breed,_this.birthDate,_this.createdAt);
}

@override
String toString() {
  final _this = this as Dog;
  return 'Dog(id: ${_this.id}, name: ${_this.name}, breed: ${_this.breed}, birthDate: ${_this.birthDate}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $DogCopyWith<$Res>  {
  factory $DogCopyWith(Dog value, $Res Function(Dog) _then) = _$DogCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? breed, DateTime? birthDate, DateTime? createdAt
});




}
/// @nodoc
class _$DogCopyWithImpl<$Res>
    implements $DogCopyWith<$Res> {
  _$DogCopyWithImpl(this._self, this._then);

  final Dog _self;
  final $Res Function(Dog) _then;

/// Create a copy of Dog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? breed = freezed,Object? birthDate = freezed,Object? createdAt = freezed,}) {
  return _then(Dog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,breed: freezed == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Dog].
extension DogPatterns on Dog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Dog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Dog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Dog value)  $default,){
final _that = this;
switch (_that) {
case _Dog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Dog value)?  $default,){
final _that = this;
switch (_that) {
case _Dog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? breed,  DateTime? birthDate,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Dog() when $default != null:
return $default(_that.id,_that.name,_that.breed,_that.birthDate,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? breed,  DateTime? birthDate,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _Dog():
return $default(_that.id,_that.name,_that.breed,_that.birthDate,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? breed,  DateTime? birthDate,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Dog() when $default != null:
return $default(_that.id,_that.name,_that.breed,_that.birthDate,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Dog extends Dog {
  const _Dog({required this.id, required this.name, this.breed, this.birthDate, this.createdAt}): super._();
  

@override final  String id;
@override final  String name;
@override final  String? breed;
@override final  DateTime? birthDate;
/// Null until the server timestamp is synced.
@override final  DateTime? createdAt;

/// Create a copy of Dog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DogCopyWith<_Dog> get copyWith => __$DogCopyWithImpl<_Dog>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Dog&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.breed, breed) || other.breed == breed)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,breed,birthDate,createdAt);
}

@override
String toString() {
    return 'Dog(id: $id, name: $name, breed: $breed, birthDate: $birthDate, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DogCopyWith<$Res> implements $DogCopyWith<$Res> {
  factory _$DogCopyWith(_Dog value, $Res Function(_Dog) _then) = __$DogCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? breed, DateTime? birthDate, DateTime? createdAt
});




}
/// @nodoc
class __$DogCopyWithImpl<$Res>
    implements _$DogCopyWith<$Res> {
  __$DogCopyWithImpl(this._self, this._then);

  final _Dog _self;
  final $Res Function(_Dog) _then;

/// Create a copy of Dog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? breed = freezed,Object? birthDate = freezed,Object? createdAt = freezed,}) {
  return _then(_Dog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,breed: freezed == breed ? _self.breed : breed // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
