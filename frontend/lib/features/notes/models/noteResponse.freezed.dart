// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'noteResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoteResponse {

 bool get success; String get message; List<NoteModel> get data;
/// Create a copy of NoteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteResponseCopyWith<NoteResponse> get copyWith => _$NoteResponseCopyWithImpl<NoteResponse>(this as NoteResponse, _$identity);

  /// Serializes this NoteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'NoteResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $NoteResponseCopyWith<$Res>  {
  factory $NoteResponseCopyWith(NoteResponse value, $Res Function(NoteResponse) _then) = _$NoteResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, List<NoteModel> data
});




}
/// @nodoc
class _$NoteResponseCopyWithImpl<$Res>
    implements $NoteResponseCopyWith<$Res> {
  _$NoteResponseCopyWithImpl(this._self, this._then);

  final NoteResponse _self;
  final $Res Function(NoteResponse) _then;

/// Create a copy of NoteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(NoteResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<NoteModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteResponse].
extension NoteResponsePatterns on NoteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteResponse value)  $default,){
final _that = this;
switch (_that) {
case _NoteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NoteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  List<NoteModel> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  List<NoteModel> data)  $default,) {final _that = this;
switch (_that) {
case _NoteResponse():
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  List<NoteModel> data)?  $default,) {final _that = this;
switch (_that) {
case _NoteResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NoteResponse implements NoteResponse {
  const _NoteResponse({required this.success, required this.message, required  List<NoteModel> data}): _data = data;
  factory _NoteResponse.fromJson(Map<String, dynamic> json) => _$NoteResponseFromJson(json);

@override final  bool success;
@override final  String message;
 final  List<NoteModel> _data;
@override List<NoteModel> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of NoteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteResponseCopyWith<_NoteResponse> get copyWith => __$NoteResponseCopyWithImpl<_NoteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NoteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'NoteResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$NoteResponseCopyWith<$Res> implements $NoteResponseCopyWith<$Res> {
  factory _$NoteResponseCopyWith(_NoteResponse value, $Res Function(_NoteResponse) _then) = __$NoteResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, List<NoteModel> data
});




}
/// @nodoc
class __$NoteResponseCopyWithImpl<$Res>
    implements _$NoteResponseCopyWith<$Res> {
  __$NoteResponseCopyWithImpl(this._self, this._then);

  final _NoteResponse _self;
  final $Res Function(_NoteResponse) _then;

/// Create a copy of NoteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_NoteResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<NoteModel>,
  ));
}


}

// dart format on
