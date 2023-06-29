// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_exception_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomException {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code) authSignUpWithEmailPassword,
    required TResult Function(String code) authSignInWithEmailPassword,
    required TResult Function() authSignOut,
    required TResult Function() userReadUser,
    required TResult Function() userCreateUser,
    required TResult Function() userSaveToken,
    required TResult Function() userRemoveToken,
    required TResult Function() searchUsersException,
    required TResult Function() storageUploadImageException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String code)? authSignUpWithEmailPassword,
    TResult? Function(String code)? authSignInWithEmailPassword,
    TResult? Function()? authSignOut,
    TResult? Function()? userReadUser,
    TResult? Function()? userCreateUser,
    TResult? Function()? userSaveToken,
    TResult? Function()? userRemoveToken,
    TResult? Function()? searchUsersException,
    TResult? Function()? storageUploadImageException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code)? authSignUpWithEmailPassword,
    TResult Function(String code)? authSignInWithEmailPassword,
    TResult Function()? authSignOut,
    TResult Function()? userReadUser,
    TResult Function()? userCreateUser,
    TResult Function()? userSaveToken,
    TResult Function()? userRemoveToken,
    TResult Function()? searchUsersException,
    TResult Function()? storageUploadImageException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpWithEmailPasswordException value)
        authSignUpWithEmailPassword,
    required TResult Function(SignInWithEmailPasswordException value)
        authSignInWithEmailPassword,
    required TResult Function(SignOutException value) authSignOut,
    required TResult Function(ReadUserException value) userReadUser,
    required TResult Function(CreateUserException value) userCreateUser,
    required TResult Function(SaveTokenException value) userSaveToken,
    required TResult Function(RemoveTokenException value) userRemoveToken,
    required TResult Function(SearchUsersException value) searchUsersException,
    required TResult Function(UploadImageException value)
        storageUploadImageException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult? Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult? Function(SignOutException value)? authSignOut,
    TResult? Function(ReadUserException value)? userReadUser,
    TResult? Function(CreateUserException value)? userCreateUser,
    TResult? Function(SaveTokenException value)? userSaveToken,
    TResult? Function(RemoveTokenException value)? userRemoveToken,
    TResult? Function(SearchUsersException value)? searchUsersException,
    TResult? Function(UploadImageException value)? storageUploadImageException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult Function(SignOutException value)? authSignOut,
    TResult Function(ReadUserException value)? userReadUser,
    TResult Function(CreateUserException value)? userCreateUser,
    TResult Function(SaveTokenException value)? userSaveToken,
    TResult Function(RemoveTokenException value)? userRemoveToken,
    TResult Function(SearchUsersException value)? searchUsersException,
    TResult Function(UploadImageException value)? storageUploadImageException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomExceptionCopyWith<$Res> {
  factory $CustomExceptionCopyWith(
          CustomException value, $Res Function(CustomException) then) =
      _$CustomExceptionCopyWithImpl<$Res, CustomException>;
}

/// @nodoc
class _$CustomExceptionCopyWithImpl<$Res, $Val extends CustomException>
    implements $CustomExceptionCopyWith<$Res> {
  _$CustomExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SignUpWithEmailPasswordExceptionCopyWith<$Res> {
  factory _$$SignUpWithEmailPasswordExceptionCopyWith(
          _$SignUpWithEmailPasswordException value,
          $Res Function(_$SignUpWithEmailPasswordException) then) =
      __$$SignUpWithEmailPasswordExceptionCopyWithImpl<$Res>;
  @useResult
  $Res call({String code});
}

/// @nodoc
class __$$SignUpWithEmailPasswordExceptionCopyWithImpl<$Res>
    extends _$CustomExceptionCopyWithImpl<$Res,
        _$SignUpWithEmailPasswordException>
    implements _$$SignUpWithEmailPasswordExceptionCopyWith<$Res> {
  __$$SignUpWithEmailPasswordExceptionCopyWithImpl(
      _$SignUpWithEmailPasswordException _value,
      $Res Function(_$SignUpWithEmailPasswordException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_$SignUpWithEmailPasswordException(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignUpWithEmailPasswordException
    implements SignUpWithEmailPasswordException {
  const _$SignUpWithEmailPasswordException({this.code = 'Error'});

  @override
  @JsonKey()
  final String code;

  @override
  String toString() {
    return 'CustomException.authSignUpWithEmailPassword(code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpWithEmailPasswordException &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpWithEmailPasswordExceptionCopyWith<
          _$SignUpWithEmailPasswordException>
      get copyWith => __$$SignUpWithEmailPasswordExceptionCopyWithImpl<
          _$SignUpWithEmailPasswordException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code) authSignUpWithEmailPassword,
    required TResult Function(String code) authSignInWithEmailPassword,
    required TResult Function() authSignOut,
    required TResult Function() userReadUser,
    required TResult Function() userCreateUser,
    required TResult Function() userSaveToken,
    required TResult Function() userRemoveToken,
    required TResult Function() searchUsersException,
    required TResult Function() storageUploadImageException,
  }) {
    return authSignUpWithEmailPassword(code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String code)? authSignUpWithEmailPassword,
    TResult? Function(String code)? authSignInWithEmailPassword,
    TResult? Function()? authSignOut,
    TResult? Function()? userReadUser,
    TResult? Function()? userCreateUser,
    TResult? Function()? userSaveToken,
    TResult? Function()? userRemoveToken,
    TResult? Function()? searchUsersException,
    TResult? Function()? storageUploadImageException,
  }) {
    return authSignUpWithEmailPassword?.call(code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code)? authSignUpWithEmailPassword,
    TResult Function(String code)? authSignInWithEmailPassword,
    TResult Function()? authSignOut,
    TResult Function()? userReadUser,
    TResult Function()? userCreateUser,
    TResult Function()? userSaveToken,
    TResult Function()? userRemoveToken,
    TResult Function()? searchUsersException,
    TResult Function()? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (authSignUpWithEmailPassword != null) {
      return authSignUpWithEmailPassword(code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpWithEmailPasswordException value)
        authSignUpWithEmailPassword,
    required TResult Function(SignInWithEmailPasswordException value)
        authSignInWithEmailPassword,
    required TResult Function(SignOutException value) authSignOut,
    required TResult Function(ReadUserException value) userReadUser,
    required TResult Function(CreateUserException value) userCreateUser,
    required TResult Function(SaveTokenException value) userSaveToken,
    required TResult Function(RemoveTokenException value) userRemoveToken,
    required TResult Function(SearchUsersException value) searchUsersException,
    required TResult Function(UploadImageException value)
        storageUploadImageException,
  }) {
    return authSignUpWithEmailPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult? Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult? Function(SignOutException value)? authSignOut,
    TResult? Function(ReadUserException value)? userReadUser,
    TResult? Function(CreateUserException value)? userCreateUser,
    TResult? Function(SaveTokenException value)? userSaveToken,
    TResult? Function(RemoveTokenException value)? userRemoveToken,
    TResult? Function(SearchUsersException value)? searchUsersException,
    TResult? Function(UploadImageException value)? storageUploadImageException,
  }) {
    return authSignUpWithEmailPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult Function(SignOutException value)? authSignOut,
    TResult Function(ReadUserException value)? userReadUser,
    TResult Function(CreateUserException value)? userCreateUser,
    TResult Function(SaveTokenException value)? userSaveToken,
    TResult Function(RemoveTokenException value)? userRemoveToken,
    TResult Function(SearchUsersException value)? searchUsersException,
    TResult Function(UploadImageException value)? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (authSignUpWithEmailPassword != null) {
      return authSignUpWithEmailPassword(this);
    }
    return orElse();
  }
}

abstract class SignUpWithEmailPasswordException implements CustomException {
  const factory SignUpWithEmailPasswordException({final String code}) =
      _$SignUpWithEmailPasswordException;

  String get code;
  @JsonKey(ignore: true)
  _$$SignUpWithEmailPasswordExceptionCopyWith<
          _$SignUpWithEmailPasswordException>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignInWithEmailPasswordExceptionCopyWith<$Res> {
  factory _$$SignInWithEmailPasswordExceptionCopyWith(
          _$SignInWithEmailPasswordException value,
          $Res Function(_$SignInWithEmailPasswordException) then) =
      __$$SignInWithEmailPasswordExceptionCopyWithImpl<$Res>;
  @useResult
  $Res call({String code});
}

/// @nodoc
class __$$SignInWithEmailPasswordExceptionCopyWithImpl<$Res>
    extends _$CustomExceptionCopyWithImpl<$Res,
        _$SignInWithEmailPasswordException>
    implements _$$SignInWithEmailPasswordExceptionCopyWith<$Res> {
  __$$SignInWithEmailPasswordExceptionCopyWithImpl(
      _$SignInWithEmailPasswordException _value,
      $Res Function(_$SignInWithEmailPasswordException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_$SignInWithEmailPasswordException(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignInWithEmailPasswordException
    implements SignInWithEmailPasswordException {
  const _$SignInWithEmailPasswordException({this.code = 'Error'});

  @override
  @JsonKey()
  final String code;

  @override
  String toString() {
    return 'CustomException.authSignInWithEmailPassword(code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInWithEmailPasswordException &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInWithEmailPasswordExceptionCopyWith<
          _$SignInWithEmailPasswordException>
      get copyWith => __$$SignInWithEmailPasswordExceptionCopyWithImpl<
          _$SignInWithEmailPasswordException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code) authSignUpWithEmailPassword,
    required TResult Function(String code) authSignInWithEmailPassword,
    required TResult Function() authSignOut,
    required TResult Function() userReadUser,
    required TResult Function() userCreateUser,
    required TResult Function() userSaveToken,
    required TResult Function() userRemoveToken,
    required TResult Function() searchUsersException,
    required TResult Function() storageUploadImageException,
  }) {
    return authSignInWithEmailPassword(code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String code)? authSignUpWithEmailPassword,
    TResult? Function(String code)? authSignInWithEmailPassword,
    TResult? Function()? authSignOut,
    TResult? Function()? userReadUser,
    TResult? Function()? userCreateUser,
    TResult? Function()? userSaveToken,
    TResult? Function()? userRemoveToken,
    TResult? Function()? searchUsersException,
    TResult? Function()? storageUploadImageException,
  }) {
    return authSignInWithEmailPassword?.call(code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code)? authSignUpWithEmailPassword,
    TResult Function(String code)? authSignInWithEmailPassword,
    TResult Function()? authSignOut,
    TResult Function()? userReadUser,
    TResult Function()? userCreateUser,
    TResult Function()? userSaveToken,
    TResult Function()? userRemoveToken,
    TResult Function()? searchUsersException,
    TResult Function()? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (authSignInWithEmailPassword != null) {
      return authSignInWithEmailPassword(code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpWithEmailPasswordException value)
        authSignUpWithEmailPassword,
    required TResult Function(SignInWithEmailPasswordException value)
        authSignInWithEmailPassword,
    required TResult Function(SignOutException value) authSignOut,
    required TResult Function(ReadUserException value) userReadUser,
    required TResult Function(CreateUserException value) userCreateUser,
    required TResult Function(SaveTokenException value) userSaveToken,
    required TResult Function(RemoveTokenException value) userRemoveToken,
    required TResult Function(SearchUsersException value) searchUsersException,
    required TResult Function(UploadImageException value)
        storageUploadImageException,
  }) {
    return authSignInWithEmailPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult? Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult? Function(SignOutException value)? authSignOut,
    TResult? Function(ReadUserException value)? userReadUser,
    TResult? Function(CreateUserException value)? userCreateUser,
    TResult? Function(SaveTokenException value)? userSaveToken,
    TResult? Function(RemoveTokenException value)? userRemoveToken,
    TResult? Function(SearchUsersException value)? searchUsersException,
    TResult? Function(UploadImageException value)? storageUploadImageException,
  }) {
    return authSignInWithEmailPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult Function(SignOutException value)? authSignOut,
    TResult Function(ReadUserException value)? userReadUser,
    TResult Function(CreateUserException value)? userCreateUser,
    TResult Function(SaveTokenException value)? userSaveToken,
    TResult Function(RemoveTokenException value)? userRemoveToken,
    TResult Function(SearchUsersException value)? searchUsersException,
    TResult Function(UploadImageException value)? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (authSignInWithEmailPassword != null) {
      return authSignInWithEmailPassword(this);
    }
    return orElse();
  }
}

abstract class SignInWithEmailPasswordException implements CustomException {
  const factory SignInWithEmailPasswordException({final String code}) =
      _$SignInWithEmailPasswordException;

  String get code;
  @JsonKey(ignore: true)
  _$$SignInWithEmailPasswordExceptionCopyWith<
          _$SignInWithEmailPasswordException>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignOutExceptionCopyWith<$Res> {
  factory _$$SignOutExceptionCopyWith(
          _$SignOutException value, $Res Function(_$SignOutException) then) =
      __$$SignOutExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignOutExceptionCopyWithImpl<$Res>
    extends _$CustomExceptionCopyWithImpl<$Res, _$SignOutException>
    implements _$$SignOutExceptionCopyWith<$Res> {
  __$$SignOutExceptionCopyWithImpl(
      _$SignOutException _value, $Res Function(_$SignOutException) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignOutException implements SignOutException {
  const _$SignOutException();

  @override
  String toString() {
    return 'CustomException.authSignOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignOutException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code) authSignUpWithEmailPassword,
    required TResult Function(String code) authSignInWithEmailPassword,
    required TResult Function() authSignOut,
    required TResult Function() userReadUser,
    required TResult Function() userCreateUser,
    required TResult Function() userSaveToken,
    required TResult Function() userRemoveToken,
    required TResult Function() searchUsersException,
    required TResult Function() storageUploadImageException,
  }) {
    return authSignOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String code)? authSignUpWithEmailPassword,
    TResult? Function(String code)? authSignInWithEmailPassword,
    TResult? Function()? authSignOut,
    TResult? Function()? userReadUser,
    TResult? Function()? userCreateUser,
    TResult? Function()? userSaveToken,
    TResult? Function()? userRemoveToken,
    TResult? Function()? searchUsersException,
    TResult? Function()? storageUploadImageException,
  }) {
    return authSignOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code)? authSignUpWithEmailPassword,
    TResult Function(String code)? authSignInWithEmailPassword,
    TResult Function()? authSignOut,
    TResult Function()? userReadUser,
    TResult Function()? userCreateUser,
    TResult Function()? userSaveToken,
    TResult Function()? userRemoveToken,
    TResult Function()? searchUsersException,
    TResult Function()? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (authSignOut != null) {
      return authSignOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpWithEmailPasswordException value)
        authSignUpWithEmailPassword,
    required TResult Function(SignInWithEmailPasswordException value)
        authSignInWithEmailPassword,
    required TResult Function(SignOutException value) authSignOut,
    required TResult Function(ReadUserException value) userReadUser,
    required TResult Function(CreateUserException value) userCreateUser,
    required TResult Function(SaveTokenException value) userSaveToken,
    required TResult Function(RemoveTokenException value) userRemoveToken,
    required TResult Function(SearchUsersException value) searchUsersException,
    required TResult Function(UploadImageException value)
        storageUploadImageException,
  }) {
    return authSignOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult? Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult? Function(SignOutException value)? authSignOut,
    TResult? Function(ReadUserException value)? userReadUser,
    TResult? Function(CreateUserException value)? userCreateUser,
    TResult? Function(SaveTokenException value)? userSaveToken,
    TResult? Function(RemoveTokenException value)? userRemoveToken,
    TResult? Function(SearchUsersException value)? searchUsersException,
    TResult? Function(UploadImageException value)? storageUploadImageException,
  }) {
    return authSignOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult Function(SignOutException value)? authSignOut,
    TResult Function(ReadUserException value)? userReadUser,
    TResult Function(CreateUserException value)? userCreateUser,
    TResult Function(SaveTokenException value)? userSaveToken,
    TResult Function(RemoveTokenException value)? userRemoveToken,
    TResult Function(SearchUsersException value)? searchUsersException,
    TResult Function(UploadImageException value)? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (authSignOut != null) {
      return authSignOut(this);
    }
    return orElse();
  }
}

abstract class SignOutException implements CustomException {
  const factory SignOutException() = _$SignOutException;
}

/// @nodoc
abstract class _$$ReadUserExceptionCopyWith<$Res> {
  factory _$$ReadUserExceptionCopyWith(
          _$ReadUserException value, $Res Function(_$ReadUserException) then) =
      __$$ReadUserExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReadUserExceptionCopyWithImpl<$Res>
    extends _$CustomExceptionCopyWithImpl<$Res, _$ReadUserException>
    implements _$$ReadUserExceptionCopyWith<$Res> {
  __$$ReadUserExceptionCopyWithImpl(
      _$ReadUserException _value, $Res Function(_$ReadUserException) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ReadUserException implements ReadUserException {
  const _$ReadUserException();

  @override
  String toString() {
    return 'CustomException.userReadUser()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ReadUserException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code) authSignUpWithEmailPassword,
    required TResult Function(String code) authSignInWithEmailPassword,
    required TResult Function() authSignOut,
    required TResult Function() userReadUser,
    required TResult Function() userCreateUser,
    required TResult Function() userSaveToken,
    required TResult Function() userRemoveToken,
    required TResult Function() searchUsersException,
    required TResult Function() storageUploadImageException,
  }) {
    return userReadUser();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String code)? authSignUpWithEmailPassword,
    TResult? Function(String code)? authSignInWithEmailPassword,
    TResult? Function()? authSignOut,
    TResult? Function()? userReadUser,
    TResult? Function()? userCreateUser,
    TResult? Function()? userSaveToken,
    TResult? Function()? userRemoveToken,
    TResult? Function()? searchUsersException,
    TResult? Function()? storageUploadImageException,
  }) {
    return userReadUser?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code)? authSignUpWithEmailPassword,
    TResult Function(String code)? authSignInWithEmailPassword,
    TResult Function()? authSignOut,
    TResult Function()? userReadUser,
    TResult Function()? userCreateUser,
    TResult Function()? userSaveToken,
    TResult Function()? userRemoveToken,
    TResult Function()? searchUsersException,
    TResult Function()? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (userReadUser != null) {
      return userReadUser();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpWithEmailPasswordException value)
        authSignUpWithEmailPassword,
    required TResult Function(SignInWithEmailPasswordException value)
        authSignInWithEmailPassword,
    required TResult Function(SignOutException value) authSignOut,
    required TResult Function(ReadUserException value) userReadUser,
    required TResult Function(CreateUserException value) userCreateUser,
    required TResult Function(SaveTokenException value) userSaveToken,
    required TResult Function(RemoveTokenException value) userRemoveToken,
    required TResult Function(SearchUsersException value) searchUsersException,
    required TResult Function(UploadImageException value)
        storageUploadImageException,
  }) {
    return userReadUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult? Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult? Function(SignOutException value)? authSignOut,
    TResult? Function(ReadUserException value)? userReadUser,
    TResult? Function(CreateUserException value)? userCreateUser,
    TResult? Function(SaveTokenException value)? userSaveToken,
    TResult? Function(RemoveTokenException value)? userRemoveToken,
    TResult? Function(SearchUsersException value)? searchUsersException,
    TResult? Function(UploadImageException value)? storageUploadImageException,
  }) {
    return userReadUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult Function(SignOutException value)? authSignOut,
    TResult Function(ReadUserException value)? userReadUser,
    TResult Function(CreateUserException value)? userCreateUser,
    TResult Function(SaveTokenException value)? userSaveToken,
    TResult Function(RemoveTokenException value)? userRemoveToken,
    TResult Function(SearchUsersException value)? searchUsersException,
    TResult Function(UploadImageException value)? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (userReadUser != null) {
      return userReadUser(this);
    }
    return orElse();
  }
}

abstract class ReadUserException implements CustomException {
  const factory ReadUserException() = _$ReadUserException;
}

/// @nodoc
abstract class _$$CreateUserExceptionCopyWith<$Res> {
  factory _$$CreateUserExceptionCopyWith(_$CreateUserException value,
          $Res Function(_$CreateUserException) then) =
      __$$CreateUserExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateUserExceptionCopyWithImpl<$Res>
    extends _$CustomExceptionCopyWithImpl<$Res, _$CreateUserException>
    implements _$$CreateUserExceptionCopyWith<$Res> {
  __$$CreateUserExceptionCopyWithImpl(
      _$CreateUserException _value, $Res Function(_$CreateUserException) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CreateUserException implements CreateUserException {
  const _$CreateUserException();

  @override
  String toString() {
    return 'CustomException.userCreateUser()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CreateUserException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code) authSignUpWithEmailPassword,
    required TResult Function(String code) authSignInWithEmailPassword,
    required TResult Function() authSignOut,
    required TResult Function() userReadUser,
    required TResult Function() userCreateUser,
    required TResult Function() userSaveToken,
    required TResult Function() userRemoveToken,
    required TResult Function() searchUsersException,
    required TResult Function() storageUploadImageException,
  }) {
    return userCreateUser();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String code)? authSignUpWithEmailPassword,
    TResult? Function(String code)? authSignInWithEmailPassword,
    TResult? Function()? authSignOut,
    TResult? Function()? userReadUser,
    TResult? Function()? userCreateUser,
    TResult? Function()? userSaveToken,
    TResult? Function()? userRemoveToken,
    TResult? Function()? searchUsersException,
    TResult? Function()? storageUploadImageException,
  }) {
    return userCreateUser?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code)? authSignUpWithEmailPassword,
    TResult Function(String code)? authSignInWithEmailPassword,
    TResult Function()? authSignOut,
    TResult Function()? userReadUser,
    TResult Function()? userCreateUser,
    TResult Function()? userSaveToken,
    TResult Function()? userRemoveToken,
    TResult Function()? searchUsersException,
    TResult Function()? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (userCreateUser != null) {
      return userCreateUser();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpWithEmailPasswordException value)
        authSignUpWithEmailPassword,
    required TResult Function(SignInWithEmailPasswordException value)
        authSignInWithEmailPassword,
    required TResult Function(SignOutException value) authSignOut,
    required TResult Function(ReadUserException value) userReadUser,
    required TResult Function(CreateUserException value) userCreateUser,
    required TResult Function(SaveTokenException value) userSaveToken,
    required TResult Function(RemoveTokenException value) userRemoveToken,
    required TResult Function(SearchUsersException value) searchUsersException,
    required TResult Function(UploadImageException value)
        storageUploadImageException,
  }) {
    return userCreateUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult? Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult? Function(SignOutException value)? authSignOut,
    TResult? Function(ReadUserException value)? userReadUser,
    TResult? Function(CreateUserException value)? userCreateUser,
    TResult? Function(SaveTokenException value)? userSaveToken,
    TResult? Function(RemoveTokenException value)? userRemoveToken,
    TResult? Function(SearchUsersException value)? searchUsersException,
    TResult? Function(UploadImageException value)? storageUploadImageException,
  }) {
    return userCreateUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult Function(SignOutException value)? authSignOut,
    TResult Function(ReadUserException value)? userReadUser,
    TResult Function(CreateUserException value)? userCreateUser,
    TResult Function(SaveTokenException value)? userSaveToken,
    TResult Function(RemoveTokenException value)? userRemoveToken,
    TResult Function(SearchUsersException value)? searchUsersException,
    TResult Function(UploadImageException value)? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (userCreateUser != null) {
      return userCreateUser(this);
    }
    return orElse();
  }
}

abstract class CreateUserException implements CustomException {
  const factory CreateUserException() = _$CreateUserException;
}

/// @nodoc
abstract class _$$SaveTokenExceptionCopyWith<$Res> {
  factory _$$SaveTokenExceptionCopyWith(_$SaveTokenException value,
          $Res Function(_$SaveTokenException) then) =
      __$$SaveTokenExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SaveTokenExceptionCopyWithImpl<$Res>
    extends _$CustomExceptionCopyWithImpl<$Res, _$SaveTokenException>
    implements _$$SaveTokenExceptionCopyWith<$Res> {
  __$$SaveTokenExceptionCopyWithImpl(
      _$SaveTokenException _value, $Res Function(_$SaveTokenException) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SaveTokenException implements SaveTokenException {
  const _$SaveTokenException();

  @override
  String toString() {
    return 'CustomException.userSaveToken()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SaveTokenException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code) authSignUpWithEmailPassword,
    required TResult Function(String code) authSignInWithEmailPassword,
    required TResult Function() authSignOut,
    required TResult Function() userReadUser,
    required TResult Function() userCreateUser,
    required TResult Function() userSaveToken,
    required TResult Function() userRemoveToken,
    required TResult Function() searchUsersException,
    required TResult Function() storageUploadImageException,
  }) {
    return userSaveToken();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String code)? authSignUpWithEmailPassword,
    TResult? Function(String code)? authSignInWithEmailPassword,
    TResult? Function()? authSignOut,
    TResult? Function()? userReadUser,
    TResult? Function()? userCreateUser,
    TResult? Function()? userSaveToken,
    TResult? Function()? userRemoveToken,
    TResult? Function()? searchUsersException,
    TResult? Function()? storageUploadImageException,
  }) {
    return userSaveToken?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code)? authSignUpWithEmailPassword,
    TResult Function(String code)? authSignInWithEmailPassword,
    TResult Function()? authSignOut,
    TResult Function()? userReadUser,
    TResult Function()? userCreateUser,
    TResult Function()? userSaveToken,
    TResult Function()? userRemoveToken,
    TResult Function()? searchUsersException,
    TResult Function()? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (userSaveToken != null) {
      return userSaveToken();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpWithEmailPasswordException value)
        authSignUpWithEmailPassword,
    required TResult Function(SignInWithEmailPasswordException value)
        authSignInWithEmailPassword,
    required TResult Function(SignOutException value) authSignOut,
    required TResult Function(ReadUserException value) userReadUser,
    required TResult Function(CreateUserException value) userCreateUser,
    required TResult Function(SaveTokenException value) userSaveToken,
    required TResult Function(RemoveTokenException value) userRemoveToken,
    required TResult Function(SearchUsersException value) searchUsersException,
    required TResult Function(UploadImageException value)
        storageUploadImageException,
  }) {
    return userSaveToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult? Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult? Function(SignOutException value)? authSignOut,
    TResult? Function(ReadUserException value)? userReadUser,
    TResult? Function(CreateUserException value)? userCreateUser,
    TResult? Function(SaveTokenException value)? userSaveToken,
    TResult? Function(RemoveTokenException value)? userRemoveToken,
    TResult? Function(SearchUsersException value)? searchUsersException,
    TResult? Function(UploadImageException value)? storageUploadImageException,
  }) {
    return userSaveToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult Function(SignOutException value)? authSignOut,
    TResult Function(ReadUserException value)? userReadUser,
    TResult Function(CreateUserException value)? userCreateUser,
    TResult Function(SaveTokenException value)? userSaveToken,
    TResult Function(RemoveTokenException value)? userRemoveToken,
    TResult Function(SearchUsersException value)? searchUsersException,
    TResult Function(UploadImageException value)? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (userSaveToken != null) {
      return userSaveToken(this);
    }
    return orElse();
  }
}

abstract class SaveTokenException implements CustomException {
  const factory SaveTokenException() = _$SaveTokenException;
}

/// @nodoc
abstract class _$$RemoveTokenExceptionCopyWith<$Res> {
  factory _$$RemoveTokenExceptionCopyWith(_$RemoveTokenException value,
          $Res Function(_$RemoveTokenException) then) =
      __$$RemoveTokenExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RemoveTokenExceptionCopyWithImpl<$Res>
    extends _$CustomExceptionCopyWithImpl<$Res, _$RemoveTokenException>
    implements _$$RemoveTokenExceptionCopyWith<$Res> {
  __$$RemoveTokenExceptionCopyWithImpl(_$RemoveTokenException _value,
      $Res Function(_$RemoveTokenException) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RemoveTokenException implements RemoveTokenException {
  const _$RemoveTokenException();

  @override
  String toString() {
    return 'CustomException.userRemoveToken()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RemoveTokenException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code) authSignUpWithEmailPassword,
    required TResult Function(String code) authSignInWithEmailPassword,
    required TResult Function() authSignOut,
    required TResult Function() userReadUser,
    required TResult Function() userCreateUser,
    required TResult Function() userSaveToken,
    required TResult Function() userRemoveToken,
    required TResult Function() searchUsersException,
    required TResult Function() storageUploadImageException,
  }) {
    return userRemoveToken();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String code)? authSignUpWithEmailPassword,
    TResult? Function(String code)? authSignInWithEmailPassword,
    TResult? Function()? authSignOut,
    TResult? Function()? userReadUser,
    TResult? Function()? userCreateUser,
    TResult? Function()? userSaveToken,
    TResult? Function()? userRemoveToken,
    TResult? Function()? searchUsersException,
    TResult? Function()? storageUploadImageException,
  }) {
    return userRemoveToken?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code)? authSignUpWithEmailPassword,
    TResult Function(String code)? authSignInWithEmailPassword,
    TResult Function()? authSignOut,
    TResult Function()? userReadUser,
    TResult Function()? userCreateUser,
    TResult Function()? userSaveToken,
    TResult Function()? userRemoveToken,
    TResult Function()? searchUsersException,
    TResult Function()? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (userRemoveToken != null) {
      return userRemoveToken();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpWithEmailPasswordException value)
        authSignUpWithEmailPassword,
    required TResult Function(SignInWithEmailPasswordException value)
        authSignInWithEmailPassword,
    required TResult Function(SignOutException value) authSignOut,
    required TResult Function(ReadUserException value) userReadUser,
    required TResult Function(CreateUserException value) userCreateUser,
    required TResult Function(SaveTokenException value) userSaveToken,
    required TResult Function(RemoveTokenException value) userRemoveToken,
    required TResult Function(SearchUsersException value) searchUsersException,
    required TResult Function(UploadImageException value)
        storageUploadImageException,
  }) {
    return userRemoveToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult? Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult? Function(SignOutException value)? authSignOut,
    TResult? Function(ReadUserException value)? userReadUser,
    TResult? Function(CreateUserException value)? userCreateUser,
    TResult? Function(SaveTokenException value)? userSaveToken,
    TResult? Function(RemoveTokenException value)? userRemoveToken,
    TResult? Function(SearchUsersException value)? searchUsersException,
    TResult? Function(UploadImageException value)? storageUploadImageException,
  }) {
    return userRemoveToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult Function(SignOutException value)? authSignOut,
    TResult Function(ReadUserException value)? userReadUser,
    TResult Function(CreateUserException value)? userCreateUser,
    TResult Function(SaveTokenException value)? userSaveToken,
    TResult Function(RemoveTokenException value)? userRemoveToken,
    TResult Function(SearchUsersException value)? searchUsersException,
    TResult Function(UploadImageException value)? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (userRemoveToken != null) {
      return userRemoveToken(this);
    }
    return orElse();
  }
}

abstract class RemoveTokenException implements CustomException {
  const factory RemoveTokenException() = _$RemoveTokenException;
}

/// @nodoc
abstract class _$$SearchUsersExceptionCopyWith<$Res> {
  factory _$$SearchUsersExceptionCopyWith(_$SearchUsersException value,
          $Res Function(_$SearchUsersException) then) =
      __$$SearchUsersExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SearchUsersExceptionCopyWithImpl<$Res>
    extends _$CustomExceptionCopyWithImpl<$Res, _$SearchUsersException>
    implements _$$SearchUsersExceptionCopyWith<$Res> {
  __$$SearchUsersExceptionCopyWithImpl(_$SearchUsersException _value,
      $Res Function(_$SearchUsersException) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SearchUsersException implements SearchUsersException {
  const _$SearchUsersException();

  @override
  String toString() {
    return 'CustomException.searchUsersException()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SearchUsersException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code) authSignUpWithEmailPassword,
    required TResult Function(String code) authSignInWithEmailPassword,
    required TResult Function() authSignOut,
    required TResult Function() userReadUser,
    required TResult Function() userCreateUser,
    required TResult Function() userSaveToken,
    required TResult Function() userRemoveToken,
    required TResult Function() searchUsersException,
    required TResult Function() storageUploadImageException,
  }) {
    return searchUsersException();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String code)? authSignUpWithEmailPassword,
    TResult? Function(String code)? authSignInWithEmailPassword,
    TResult? Function()? authSignOut,
    TResult? Function()? userReadUser,
    TResult? Function()? userCreateUser,
    TResult? Function()? userSaveToken,
    TResult? Function()? userRemoveToken,
    TResult? Function()? searchUsersException,
    TResult? Function()? storageUploadImageException,
  }) {
    return searchUsersException?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code)? authSignUpWithEmailPassword,
    TResult Function(String code)? authSignInWithEmailPassword,
    TResult Function()? authSignOut,
    TResult Function()? userReadUser,
    TResult Function()? userCreateUser,
    TResult Function()? userSaveToken,
    TResult Function()? userRemoveToken,
    TResult Function()? searchUsersException,
    TResult Function()? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (searchUsersException != null) {
      return searchUsersException();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpWithEmailPasswordException value)
        authSignUpWithEmailPassword,
    required TResult Function(SignInWithEmailPasswordException value)
        authSignInWithEmailPassword,
    required TResult Function(SignOutException value) authSignOut,
    required TResult Function(ReadUserException value) userReadUser,
    required TResult Function(CreateUserException value) userCreateUser,
    required TResult Function(SaveTokenException value) userSaveToken,
    required TResult Function(RemoveTokenException value) userRemoveToken,
    required TResult Function(SearchUsersException value) searchUsersException,
    required TResult Function(UploadImageException value)
        storageUploadImageException,
  }) {
    return searchUsersException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult? Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult? Function(SignOutException value)? authSignOut,
    TResult? Function(ReadUserException value)? userReadUser,
    TResult? Function(CreateUserException value)? userCreateUser,
    TResult? Function(SaveTokenException value)? userSaveToken,
    TResult? Function(RemoveTokenException value)? userRemoveToken,
    TResult? Function(SearchUsersException value)? searchUsersException,
    TResult? Function(UploadImageException value)? storageUploadImageException,
  }) {
    return searchUsersException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult Function(SignOutException value)? authSignOut,
    TResult Function(ReadUserException value)? userReadUser,
    TResult Function(CreateUserException value)? userCreateUser,
    TResult Function(SaveTokenException value)? userSaveToken,
    TResult Function(RemoveTokenException value)? userRemoveToken,
    TResult Function(SearchUsersException value)? searchUsersException,
    TResult Function(UploadImageException value)? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (searchUsersException != null) {
      return searchUsersException(this);
    }
    return orElse();
  }
}

abstract class SearchUsersException implements CustomException {
  const factory SearchUsersException() = _$SearchUsersException;
}

/// @nodoc
abstract class _$$UploadImageExceptionCopyWith<$Res> {
  factory _$$UploadImageExceptionCopyWith(_$UploadImageException value,
          $Res Function(_$UploadImageException) then) =
      __$$UploadImageExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UploadImageExceptionCopyWithImpl<$Res>
    extends _$CustomExceptionCopyWithImpl<$Res, _$UploadImageException>
    implements _$$UploadImageExceptionCopyWith<$Res> {
  __$$UploadImageExceptionCopyWithImpl(_$UploadImageException _value,
      $Res Function(_$UploadImageException) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UploadImageException implements UploadImageException {
  const _$UploadImageException();

  @override
  String toString() {
    return 'CustomException.storageUploadImageException()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UploadImageException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String code) authSignUpWithEmailPassword,
    required TResult Function(String code) authSignInWithEmailPassword,
    required TResult Function() authSignOut,
    required TResult Function() userReadUser,
    required TResult Function() userCreateUser,
    required TResult Function() userSaveToken,
    required TResult Function() userRemoveToken,
    required TResult Function() searchUsersException,
    required TResult Function() storageUploadImageException,
  }) {
    return storageUploadImageException();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String code)? authSignUpWithEmailPassword,
    TResult? Function(String code)? authSignInWithEmailPassword,
    TResult? Function()? authSignOut,
    TResult? Function()? userReadUser,
    TResult? Function()? userCreateUser,
    TResult? Function()? userSaveToken,
    TResult? Function()? userRemoveToken,
    TResult? Function()? searchUsersException,
    TResult? Function()? storageUploadImageException,
  }) {
    return storageUploadImageException?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String code)? authSignUpWithEmailPassword,
    TResult Function(String code)? authSignInWithEmailPassword,
    TResult Function()? authSignOut,
    TResult Function()? userReadUser,
    TResult Function()? userCreateUser,
    TResult Function()? userSaveToken,
    TResult Function()? userRemoveToken,
    TResult Function()? searchUsersException,
    TResult Function()? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (storageUploadImageException != null) {
      return storageUploadImageException();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SignUpWithEmailPasswordException value)
        authSignUpWithEmailPassword,
    required TResult Function(SignInWithEmailPasswordException value)
        authSignInWithEmailPassword,
    required TResult Function(SignOutException value) authSignOut,
    required TResult Function(ReadUserException value) userReadUser,
    required TResult Function(CreateUserException value) userCreateUser,
    required TResult Function(SaveTokenException value) userSaveToken,
    required TResult Function(RemoveTokenException value) userRemoveToken,
    required TResult Function(SearchUsersException value) searchUsersException,
    required TResult Function(UploadImageException value)
        storageUploadImageException,
  }) {
    return storageUploadImageException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult? Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult? Function(SignOutException value)? authSignOut,
    TResult? Function(ReadUserException value)? userReadUser,
    TResult? Function(CreateUserException value)? userCreateUser,
    TResult? Function(SaveTokenException value)? userSaveToken,
    TResult? Function(RemoveTokenException value)? userRemoveToken,
    TResult? Function(SearchUsersException value)? searchUsersException,
    TResult? Function(UploadImageException value)? storageUploadImageException,
  }) {
    return storageUploadImageException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SignUpWithEmailPasswordException value)?
        authSignUpWithEmailPassword,
    TResult Function(SignInWithEmailPasswordException value)?
        authSignInWithEmailPassword,
    TResult Function(SignOutException value)? authSignOut,
    TResult Function(ReadUserException value)? userReadUser,
    TResult Function(CreateUserException value)? userCreateUser,
    TResult Function(SaveTokenException value)? userSaveToken,
    TResult Function(RemoveTokenException value)? userRemoveToken,
    TResult Function(SearchUsersException value)? searchUsersException,
    TResult Function(UploadImageException value)? storageUploadImageException,
    required TResult orElse(),
  }) {
    if (storageUploadImageException != null) {
      return storageUploadImageException(this);
    }
    return orElse();
  }
}

abstract class UploadImageException implements CustomException {
  const factory UploadImageException() = _$UploadImageException;
}
