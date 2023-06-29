// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'private_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PrivateUser _$PrivateUserFromJson(Map<String, dynamic> json) {
  return _PrivateUser.fromJson(json);
}

/// @nodoc
mixin _$PrivateUser {
  @JsonKey(includeIfNull: false)
  String? get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  List<String> get tokens => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrivateUserCopyWith<PrivateUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrivateUserCopyWith<$Res> {
  factory $PrivateUserCopyWith(
          PrivateUser value, $Res Function(PrivateUser) then) =
      _$PrivateUserCopyWithImpl<$Res, PrivateUser>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      String email,
      List<String> tokens});
}

/// @nodoc
class _$PrivateUserCopyWithImpl<$Res, $Val extends PrivateUser>
    implements $PrivateUserCopyWith<$Res> {
  _$PrivateUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = null,
    Object? tokens = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PrivateUserCopyWith<$Res>
    implements $PrivateUserCopyWith<$Res> {
  factory _$$_PrivateUserCopyWith(
          _$_PrivateUser value, $Res Function(_$_PrivateUser) then) =
      __$$_PrivateUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      String email,
      List<String> tokens});
}

/// @nodoc
class __$$_PrivateUserCopyWithImpl<$Res>
    extends _$PrivateUserCopyWithImpl<$Res, _$_PrivateUser>
    implements _$$_PrivateUserCopyWith<$Res> {
  __$$_PrivateUserCopyWithImpl(
      _$_PrivateUser _value, $Res Function(_$_PrivateUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = null,
    Object? tokens = null,
  }) {
    return _then(_$_PrivateUser(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      tokens: null == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PrivateUser implements _PrivateUser {
  const _$_PrivateUser(
      {@JsonKey(includeIfNull: false) this.id,
      required this.email,
      required final List<String> tokens})
      : _tokens = tokens;

  factory _$_PrivateUser.fromJson(Map<String, dynamic> json) =>
      _$$_PrivateUserFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final String? id;
  @override
  final String email;
  final List<String> _tokens;
  @override
  List<String> get tokens {
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokens);
  }

  @override
  String toString() {
    return 'PrivateUser(id: $id, email: $email, tokens: $tokens)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PrivateUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, email, const DeepCollectionEquality().hash(_tokens));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PrivateUserCopyWith<_$_PrivateUser> get copyWith =>
      __$$_PrivateUserCopyWithImpl<_$_PrivateUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PrivateUserToJson(
      this,
    );
  }
}

abstract class _PrivateUser implements PrivateUser {
  const factory _PrivateUser(
      {@JsonKey(includeIfNull: false) final String? id,
      required final String email,
      required final List<String> tokens}) = _$_PrivateUser;

  factory _PrivateUser.fromJson(Map<String, dynamic> json) =
      _$_PrivateUser.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  String? get id;
  @override
  String get email;
  @override
  List<String> get tokens;
  @override
  @JsonKey(ignore: true)
  _$$_PrivateUserCopyWith<_$_PrivateUser> get copyWith =>
      throw _privateConstructorUsedError;
}
