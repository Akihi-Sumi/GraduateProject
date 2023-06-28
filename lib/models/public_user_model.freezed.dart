// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PublicUser _$PublicUserFromJson(Map<String, dynamic> json) {
  return _PublicUser.fromJson(json);
}

/// @nodoc
mixin _$PublicUser {
//@JsonKey(ignore: true) String? id,
  @JsonKey(includeIfNull: false)
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PublicUserCopyWith<PublicUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublicUserCopyWith<$Res> {
  factory $PublicUserCopyWith(
          PublicUser value, $Res Function(PublicUser) then) =
      _$PublicUserCopyWithImpl<$Res, PublicUser>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      String name,
      String avatarUrl});
}

/// @nodoc
class _$PublicUserCopyWithImpl<$Res, $Val extends PublicUser>
    implements $PublicUserCopyWith<$Res> {
  _$PublicUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? avatarUrl = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PublicUserCopyWith<$Res>
    implements $PublicUserCopyWith<$Res> {
  factory _$$_PublicUserCopyWith(
          _$_PublicUser value, $Res Function(_$_PublicUser) then) =
      __$$_PublicUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) String? id,
      String name,
      String avatarUrl});
}

/// @nodoc
class __$$_PublicUserCopyWithImpl<$Res>
    extends _$PublicUserCopyWithImpl<$Res, _$_PublicUser>
    implements _$$_PublicUserCopyWith<$Res> {
  __$$_PublicUserCopyWithImpl(
      _$_PublicUser _value, $Res Function(_$_PublicUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? avatarUrl = null,
  }) {
    return _then(_$_PublicUser(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PublicUser implements _PublicUser {
  const _$_PublicUser(
      {@JsonKey(includeIfNull: false) this.id,
      required this.name,
      required this.avatarUrl});

  factory _$_PublicUser.fromJson(Map<String, dynamic> json) =>
      _$$_PublicUserFromJson(json);

//@JsonKey(ignore: true) String? id,
  @override
  @JsonKey(includeIfNull: false)
  final String? id;
  @override
  final String name;
  @override
  final String avatarUrl;

  @override
  String toString() {
    return 'PublicUser(id: $id, name: $name, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PublicUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, avatarUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PublicUserCopyWith<_$_PublicUser> get copyWith =>
      __$$_PublicUserCopyWithImpl<_$_PublicUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PublicUserToJson(
      this,
    );
  }
}

abstract class _PublicUser implements PublicUser {
  const factory _PublicUser(
      {@JsonKey(includeIfNull: false) final String? id,
      required final String name,
      required final String avatarUrl}) = _$_PublicUser;

  factory _PublicUser.fromJson(Map<String, dynamic> json) =
      _$_PublicUser.fromJson;

  @override //@JsonKey(ignore: true) String? id,
  @JsonKey(includeIfNull: false)
  String? get id;
  @override
  String get name;
  @override
  String get avatarUrl;
  @override
  @JsonKey(ignore: true)
  _$$_PublicUserCopyWith<_$_PublicUser> get copyWith =>
      throw _privateConstructorUsedError;
}
