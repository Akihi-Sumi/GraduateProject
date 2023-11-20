// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'read_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReadStatus _$ReadStatusFromJson(Map<String, dynamic> json) {
  return _ReadStatus.fromJson(json);
}

/// @nodoc
mixin _$ReadStatus {
  String get readStatusId => throw _privateConstructorUsedError;
  @alwaysUseServerTimestampUnionTimestampConverter
  DateTime? get lastReadAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReadStatusCopyWith<ReadStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadStatusCopyWith<$Res> {
  factory $ReadStatusCopyWith(
          ReadStatus value, $Res Function(ReadStatus) then) =
      _$ReadStatusCopyWithImpl<$Res, ReadStatus>;
  @useResult
  $Res call(
      {String readStatusId,
      @alwaysUseServerTimestampUnionTimestampConverter DateTime? lastReadAt});
}

/// @nodoc
class _$ReadStatusCopyWithImpl<$Res, $Val extends ReadStatus>
    implements $ReadStatusCopyWith<$Res> {
  _$ReadStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? readStatusId = null,
    Object? lastReadAt = freezed,
  }) {
    return _then(_value.copyWith(
      readStatusId: null == readStatusId
          ? _value.readStatusId
          : readStatusId // ignore: cast_nullable_to_non_nullable
              as String,
      lastReadAt: freezed == lastReadAt
          ? _value.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReadStatusImplCopyWith<$Res>
    implements $ReadStatusCopyWith<$Res> {
  factory _$$ReadStatusImplCopyWith(
          _$ReadStatusImpl value, $Res Function(_$ReadStatusImpl) then) =
      __$$ReadStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String readStatusId,
      @alwaysUseServerTimestampUnionTimestampConverter DateTime? lastReadAt});
}

/// @nodoc
class __$$ReadStatusImplCopyWithImpl<$Res>
    extends _$ReadStatusCopyWithImpl<$Res, _$ReadStatusImpl>
    implements _$$ReadStatusImplCopyWith<$Res> {
  __$$ReadStatusImplCopyWithImpl(
      _$ReadStatusImpl _value, $Res Function(_$ReadStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? readStatusId = null,
    Object? lastReadAt = freezed,
  }) {
    return _then(_$ReadStatusImpl(
      readStatusId: null == readStatusId
          ? _value.readStatusId
          : readStatusId // ignore: cast_nullable_to_non_nullable
              as String,
      lastReadAt: freezed == lastReadAt
          ? _value.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReadStatusImpl extends _ReadStatus {
  const _$ReadStatusImpl(
      {this.readStatusId = '',
      @alwaysUseServerTimestampUnionTimestampConverter this.lastReadAt})
      : super._();

  factory _$ReadStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReadStatusImplFromJson(json);

  @override
  @JsonKey()
  final String readStatusId;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  final DateTime? lastReadAt;

  @override
  String toString() {
    return 'ReadStatus(readStatusId: $readStatusId, lastReadAt: $lastReadAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadStatusImpl &&
            (identical(other.readStatusId, readStatusId) ||
                other.readStatusId == readStatusId) &&
            (identical(other.lastReadAt, lastReadAt) ||
                other.lastReadAt == lastReadAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, readStatusId, lastReadAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadStatusImplCopyWith<_$ReadStatusImpl> get copyWith =>
      __$$ReadStatusImplCopyWithImpl<_$ReadStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReadStatusImplToJson(
      this,
    );
  }
}

abstract class _ReadStatus extends ReadStatus {
  const factory _ReadStatus(
      {final String readStatusId,
      @alwaysUseServerTimestampUnionTimestampConverter
      final DateTime? lastReadAt}) = _$ReadStatusImpl;
  const _ReadStatus._() : super._();

  factory _ReadStatus.fromJson(Map<String, dynamic> json) =
      _$ReadStatusImpl.fromJson;

  @override
  String get readStatusId;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  DateTime? get lastReadAt;
  @override
  @JsonKey(ignore: true)
  _$$ReadStatusImplCopyWith<_$ReadStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
