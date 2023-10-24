// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) {
  return _GroupModel.fromJson(json);
}

/// @nodoc
mixin _$GroupModel {
  String get groupId => throw _privateConstructorUsedError;
  String get groupName => throw _privateConstructorUsedError;
  List<String> get members => throw _privateConstructorUsedError;
  List<String> get mods => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupModelCopyWith<GroupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupModelCopyWith<$Res> {
  factory $GroupModelCopyWith(
          GroupModel value, $Res Function(GroupModel) then) =
      _$GroupModelCopyWithImpl<$Res, GroupModel>;
  @useResult
  $Res call(
      {String groupId,
      String groupName,
      List<String> members,
      List<String> mods});
}

/// @nodoc
class _$GroupModelCopyWithImpl<$Res, $Val extends GroupModel>
    implements $GroupModelCopyWith<$Res> {
  _$GroupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? groupName = null,
    Object? members = null,
    Object? mods = null,
  }) {
    return _then(_value.copyWith(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mods: null == mods
          ? _value.mods
          : mods // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupModelImplCopyWith<$Res>
    implements $GroupModelCopyWith<$Res> {
  factory _$$GroupModelImplCopyWith(
          _$GroupModelImpl value, $Res Function(_$GroupModelImpl) then) =
      __$$GroupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String groupId,
      String groupName,
      List<String> members,
      List<String> mods});
}

/// @nodoc
class __$$GroupModelImplCopyWithImpl<$Res>
    extends _$GroupModelCopyWithImpl<$Res, _$GroupModelImpl>
    implements _$$GroupModelImplCopyWith<$Res> {
  __$$GroupModelImplCopyWithImpl(
      _$GroupModelImpl _value, $Res Function(_$GroupModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? groupName = null,
    Object? members = null,
    Object? mods = null,
  }) {
    return _then(_$GroupModelImpl(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: null == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mods: null == mods
          ? _value._mods
          : mods // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupModelImpl extends _GroupModel {
  const _$GroupModelImpl(
      {required this.groupId,
      required this.groupName,
      required final List<String> members,
      required final List<String> mods})
      : _members = members,
        _mods = mods,
        super._();

  factory _$GroupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupModelImplFromJson(json);

  @override
  final String groupId;
  @override
  final String groupName;
  final List<String> _members;
  @override
  List<String> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  final List<String> _mods;
  @override
  List<String> get mods {
    if (_mods is EqualUnmodifiableListView) return _mods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mods);
  }

  @override
  String toString() {
    return 'GroupModel(groupId: $groupId, groupName: $groupName, members: $members, mods: $mods)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupModelImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality().equals(other._mods, _mods));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      groupId,
      groupName,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(_mods));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      __$$GroupModelImplCopyWithImpl<_$GroupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupModelImplToJson(
      this,
    );
  }
}

abstract class _GroupModel extends GroupModel {
  const factory _GroupModel(
      {required final String groupId,
      required final String groupName,
      required final List<String> members,
      required final List<String> mods}) = _$GroupModelImpl;
  const _GroupModel._() : super._();

  factory _GroupModel.fromJson(Map<String, dynamic> json) =
      _$GroupModelImpl.fromJson;

  @override
  String get groupId;
  @override
  String get groupName;
  @override
  List<String> get members;
  @override
  List<String> get mods;
  @override
  @JsonKey(ignore: true)
  _$$GroupModelImplCopyWith<_$GroupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
