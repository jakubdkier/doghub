// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventQuery {

 Set<EventType> get types; int get limit;
/// Create a copy of EventQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventQueryCopyWith<EventQuery> get copyWith => _$EventQueryCopyWithImpl<EventQuery>(this as EventQuery, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EventQuery;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventQuery&&const DeepCollectionEquality().equals(other.types, _this.types)&&(identical(other.limit, _this.limit) || other.limit == _this.limit));
}


@override
int get hashCode {
  final _this = this as EventQuery;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.types),_this.limit);
}

@override
String toString() {
  final _this = this as EventQuery;
  return 'EventQuery(types: ${_this.types}, limit: ${_this.limit})';
}


}

/// @nodoc
abstract mixin class $EventQueryCopyWith<$Res>  {
  factory $EventQueryCopyWith(EventQuery value, $Res Function(EventQuery) _then) = _$EventQueryCopyWithImpl;
@useResult
$Res call({
 Set<EventType> types, int limit
});




}
/// @nodoc
class _$EventQueryCopyWithImpl<$Res>
    implements $EventQueryCopyWith<$Res> {
  _$EventQueryCopyWithImpl(this._self, this._then);

  final EventQuery _self;
  final $Res Function(EventQuery) _then;

/// Create a copy of EventQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? types = null,Object? limit = null,}) {
  return _then(EventQuery(
types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as Set<EventType>,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EventQuery].
extension EventQueryPatterns on EventQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventQuery value)  $default,){
final _that = this;
switch (_that) {
case _EventQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventQuery value)?  $default,){
final _that = this;
switch (_that) {
case _EventQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<EventType> types,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventQuery() when $default != null:
return $default(_that.types,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<EventType> types,  int limit)  $default,) {final _that = this;
switch (_that) {
case _EventQuery():
return $default(_that.types,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<EventType> types,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _EventQuery() when $default != null:
return $default(_that.types,_that.limit);case _:
  return null;

}
}

}

/// @nodoc


class _EventQuery extends EventQuery {
  const _EventQuery({ Set<EventType> types = const <EventType>{}, this.limit = EventQuery.pageSize}): _types = types,super._();
  

 final  Set<EventType> _types;
@override@JsonKey() Set<EventType> get types {
  if (_types is EqualUnmodifiableSetView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_types);
}

@override@JsonKey() final  int limit;

/// Create a copy of EventQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventQueryCopyWith<_EventQuery> get copyWith => __$EventQueryCopyWithImpl<_EventQuery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventQuery&&const DeepCollectionEquality().equals(other.types, _types)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_types),limit);
}

@override
String toString() {
    return 'EventQuery(types: $types, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$EventQueryCopyWith<$Res> implements $EventQueryCopyWith<$Res> {
  factory _$EventQueryCopyWith(_EventQuery value, $Res Function(_EventQuery) _then) = __$EventQueryCopyWithImpl;
@override @useResult
$Res call({
 Set<EventType> types, int limit
});




}
/// @nodoc
class __$EventQueryCopyWithImpl<$Res>
    implements _$EventQueryCopyWith<$Res> {
  __$EventQueryCopyWithImpl(this._self, this._then);

  final _EventQuery _self;
  final $Res Function(_EventQuery) _then;

/// Create a copy of EventQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? types = null,Object? limit = null,}) {
  return _then(_EventQuery(
types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as Set<EventType>,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$EventPage {

 List<DogEvent> get events; bool get hasMore;
/// Create a copy of EventPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventPageCopyWith<EventPage> get copyWith => _$EventPageCopyWithImpl<EventPage>(this as EventPage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EventPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventPage&&const DeepCollectionEquality().equals(other.events, _this.events)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore));
}


@override
int get hashCode {
  final _this = this as EventPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.events),_this.hasMore);
}

@override
String toString() {
  final _this = this as EventPage;
  return 'EventPage(events: ${_this.events}, hasMore: ${_this.hasMore})';
}


}

/// @nodoc
abstract mixin class $EventPageCopyWith<$Res>  {
  factory $EventPageCopyWith(EventPage value, $Res Function(EventPage) _then) = _$EventPageCopyWithImpl;
@useResult
$Res call({
 List<DogEvent> events, bool hasMore
});




}
/// @nodoc
class _$EventPageCopyWithImpl<$Res>
    implements $EventPageCopyWith<$Res> {
  _$EventPageCopyWithImpl(this._self, this._then);

  final EventPage _self;
  final $Res Function(EventPage) _then;

/// Create a copy of EventPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? events = null,Object? hasMore = null,}) {
  return _then(EventPage(
events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<DogEvent>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EventPage].
extension EventPagePatterns on EventPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventPage value)  $default,){
final _that = this;
switch (_that) {
case _EventPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventPage value)?  $default,){
final _that = this;
switch (_that) {
case _EventPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DogEvent> events,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventPage() when $default != null:
return $default(_that.events,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DogEvent> events,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _EventPage():
return $default(_that.events,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DogEvent> events,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _EventPage() when $default != null:
return $default(_that.events,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _EventPage implements EventPage {
  const _EventPage({required  List<DogEvent> events, required this.hasMore}): _events = events;
  

 final  List<DogEvent> _events;
@override List<DogEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

@override final  bool hasMore;

/// Create a copy of EventPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventPageCopyWith<_EventPage> get copyWith => __$EventPageCopyWithImpl<_EventPage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventPage&&const DeepCollectionEquality().equals(other.events, _events)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_events),hasMore);
}

@override
String toString() {
    return 'EventPage(events: $events, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$EventPageCopyWith<$Res> implements $EventPageCopyWith<$Res> {
  factory _$EventPageCopyWith(_EventPage value, $Res Function(_EventPage) _then) = __$EventPageCopyWithImpl;
@override @useResult
$Res call({
 List<DogEvent> events, bool hasMore
});




}
/// @nodoc
class __$EventPageCopyWithImpl<$Res>
    implements _$EventPageCopyWith<$Res> {
  __$EventPageCopyWithImpl(this._self, this._then);

  final _EventPage _self;
  final $Res Function(_EventPage) _then;

/// Create a copy of EventPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? events = null,Object? hasMore = null,}) {
  return _then(_EventPage(
events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<DogEvent>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
