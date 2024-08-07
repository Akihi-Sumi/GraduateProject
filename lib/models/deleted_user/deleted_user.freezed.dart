// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deleted_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeletedUser _$DeletedUserFromJson(Map<String, dynamic> json) {
  return _DeletedUser.fromJson(json);
}

/// @nodoc
mixin _$DeletedUser {
  String get uid => throw _privateConstructorUsedError;
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeletedUserCopyWith<DeletedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeletedUserCopyWith<$Res> {
  factory $DeletedUserCopyWith(
          DeletedUser value, $Res Function(DeletedUser) then) =
      _$DeletedUserCopyWithImpl<$Res, DeletedUser>;
  @useResult
  $Res call(
      {String uid,
      @alwaysUseServerTimestampUnionTimestampConverter
      UnionTimestamp createdAt});

  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class _$DeletedUserCopyWithImpl<$Res, $Val extends DeletedUser>
    implements $DeletedUserCopyWith<$Res> {
  _$DeletedUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnionTimestampCopyWith<$Res> get createdAt {
    return $UnionTimestampCopyWith<$Res>(_value.createdAt, (value) {
      return _then(_value.copyWith(createdAt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DeletedUserImplCopyWith<$Res>
    implements $DeletedUserCopyWith<$Res> {
  factory _$$DeletedUserImplCopyWith(
          _$DeletedUserImpl value, $Res Function(_$DeletedUserImpl) then) =
      __$$DeletedUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      @alwaysUseServerTimestampUnionTimestampConverter
      UnionTimestamp createdAt});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class __$$DeletedUserImplCopyWithImpl<$Res>
    extends _$DeletedUserCopyWithImpl<$Res, _$DeletedUserImpl>
    implements _$$DeletedUserImplCopyWith<$Res> {
  __$$DeletedUserImplCopyWithImpl(
      _$DeletedUserImpl _value, $Res Function(_$DeletedUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? createdAt = null,
  }) {
    return _then(_$DeletedUserImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeletedUserImpl extends _DeletedUser {
  const _$DeletedUserImpl(
      {this.uid = '',
      @alwaysUseServerTimestampUnionTimestampConverter required this.createdAt})
      : super._();

  factory _$DeletedUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeletedUserImplFromJson(json);

  @override
  @JsonKey()
  final String uid;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  final UnionTimestamp createdAt;

  @override
  String toString() {
    return 'DeletedUser(uid: $uid, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeletedUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeletedUserImplCopyWith<_$DeletedUserImpl> get copyWith =>
      __$$DeletedUserImplCopyWithImpl<_$DeletedUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletedUserImplToJson(
      this,
    );
  }
}

abstract class _DeletedUser extends DeletedUser {
  const factory _DeletedUser(
      {final String uid,
      @alwaysUseServerTimestampUnionTimestampConverter
      required final UnionTimestamp createdAt}) = _$DeletedUserImpl;
  const _DeletedUser._() : super._();

  factory _DeletedUser.fromJson(Map<String, dynamic> json) =
      _$DeletedUserImpl.fromJson;

  @override
  String get uid;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$DeletedUserImplCopyWith<_$DeletedUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
