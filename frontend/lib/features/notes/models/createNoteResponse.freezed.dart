// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'createNoteResponse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateNoteResponse {

 bool get success; String get message; NoteModel get data;
/// Create a copy of CreateNoteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateNoteResponseCopyWith<CreateNoteResponse> get copyWith => _$CreateNoteResponseCopyWithImpl<CreateNoteResponse>(this as CreateNoteResponse, _$identity);

  /// Serializes this CreateNoteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateNoteResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'CreateNoteResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $CreateNoteResponseCopyWith<$Res>  {
  factory $CreateNoteResponseCopyWith(CreateNoteResponse value, $Res Function(CreateNoteResponse) _then) = _$CreateNoteResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, NoteModel data
});


$NoteModelCopyWith<$Res> get data;

}
/// @nodoc
class _$CreateNoteResponseCopyWithImpl<$Res>
    implements $CreateNoteResponseCopyWith<$Res> {
  _$CreateNoteResponseCopyWithImpl(this._self, this._then);

  final CreateNoteResponse _self;
  final $Res Function(CreateNoteResponse) _then;

/// Create a copy of CreateNoteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(CreateNoteResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as NoteModel,
  ));
}
/// Create a copy of CreateNoteResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteModelCopyWith<$Res> get data {
  
  return $NoteModelCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateNoteResponse].
extension CreateNoteResponsePatterns on CreateNoteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateNoteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateNoteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateNoteResponse value)  $default,){
final _that = this;
switch (_that) {
case _CreateNoteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateNoteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CreateNoteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  NoteModel data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateNoteResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  NoteModel data)  $default,) {final _that = this;
switch (_that) {
case _CreateNoteResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  NoteModel data)?  $default,) {final _that = this;
switch (_that) {
case _CreateNoteResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateNoteResponse implements CreateNoteResponse {
  const _CreateNoteResponse({required this.success, required this.message, required this.data});
  factory _CreateNoteResponse.fromJson(Map<String, dynamic> json) => _$CreateNoteResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  NoteModel data;

/// Create a copy of CreateNoteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateNoteResponseCopyWith<_CreateNoteResponse> get copyWith => __$CreateNoteResponseCopyWithImpl<_CreateNoteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateNoteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateNoteResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'CreateNoteResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CreateNoteResponseCopyWith<$Res> implements $CreateNoteResponseCopyWith<$Res> {
  factory _$CreateNoteResponseCopyWith(_CreateNoteResponse value, $Res Function(_CreateNoteResponse) _then) = __$CreateNoteResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, NoteModel data
});


@override $NoteModelCopyWith<$Res> get data;

}
/// @nodoc
class __$CreateNoteResponseCopyWithImpl<$Res>
    implements _$CreateNoteResponseCopyWith<$Res> {
  __$CreateNoteResponseCopyWithImpl(this._self, this._then);

  final _CreateNoteResponse _self;
  final $Res Function(_CreateNoteResponse) _then;

/// Create a copy of CreateNoteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_CreateNoteResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as NoteModel,
  ));
}

/// Create a copy of CreateNoteResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteModelCopyWith<$Res> get data {
  
  return $NoteModelCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
