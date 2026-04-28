// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clean_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CleanError {

 String get message;
/// Create a copy of CleanError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CleanErrorCopyWith<CleanError> get copyWith => _$CleanErrorCopyWithImpl<CleanError>(this as CleanError, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CleanError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CleanError(message: $message)';
}


}

/// @nodoc
abstract mixin class $CleanErrorCopyWith<$Res>  {
  factory $CleanErrorCopyWith(CleanError value, $Res Function(CleanError) _then) = _$CleanErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CleanErrorCopyWithImpl<$Res>
    implements $CleanErrorCopyWith<$Res> {
  _$CleanErrorCopyWithImpl(this._self, this._then);

  final CleanError _self;
  final $Res Function(CleanError) _then;

/// Create a copy of CleanError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CleanError].
extension CleanErrorPatterns on CleanError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CleanError_AnyhowError value)?  anyhowError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CleanError_AnyhowError() when anyhowError != null:
return anyhowError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CleanError_AnyhowError value)  anyhowError,}){
final _that = this;
switch (_that) {
case CleanError_AnyhowError():
return anyhowError(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CleanError_AnyhowError value)?  anyhowError,}){
final _that = this;
switch (_that) {
case CleanError_AnyhowError() when anyhowError != null:
return anyhowError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  anyhowError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CleanError_AnyhowError() when anyhowError != null:
return anyhowError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  anyhowError,}) {final _that = this;
switch (_that) {
case CleanError_AnyhowError():
return anyhowError(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  anyhowError,}) {final _that = this;
switch (_that) {
case CleanError_AnyhowError() when anyhowError != null:
return anyhowError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CleanError_AnyhowError extends CleanError {
  const CleanError_AnyhowError({required this.message}): super._();
  

@override final  String message;

/// Create a copy of CleanError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CleanError_AnyhowErrorCopyWith<CleanError_AnyhowError> get copyWith => _$CleanError_AnyhowErrorCopyWithImpl<CleanError_AnyhowError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CleanError_AnyhowError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CleanError.anyhowError(message: $message)';
}


}

/// @nodoc
abstract mixin class $CleanError_AnyhowErrorCopyWith<$Res> implements $CleanErrorCopyWith<$Res> {
  factory $CleanError_AnyhowErrorCopyWith(CleanError_AnyhowError value, $Res Function(CleanError_AnyhowError) _then) = _$CleanError_AnyhowErrorCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CleanError_AnyhowErrorCopyWithImpl<$Res>
    implements $CleanError_AnyhowErrorCopyWith<$Res> {
  _$CleanError_AnyhowErrorCopyWithImpl(this._self, this._then);

  final CleanError_AnyhowError _self;
  final $Res Function(CleanError_AnyhowError) _then;

/// Create a copy of CleanError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CleanError_AnyhowError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
