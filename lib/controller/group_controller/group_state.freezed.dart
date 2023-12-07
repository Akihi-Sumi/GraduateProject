// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GroupState {
  bool get loading => throw _privateConstructorUsedError;
  GroupModel? get readGroup => throw _privateConstructorUsedError;
  bool get sending => throw _privateConstructorUsedError;
  List<ReadGroupMessage> get readGroupMessages =>
      throw _privateConstructorUsedError;
  List<ReadGroupMessage> get newReadGroupMessages =>
      throw _privateConstructorUsedError;
  List<ReadGroupMessage> get pastReadGroupMessages =>
      throw _privateConstructorUsedError;
  bool get fetchitg => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  String? get lastReadGroupMessageId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroupStateCopyWith<GroupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupStateCopyWith<$Res> {
  factory $GroupStateCopyWith(
          GroupState value, $Res Function(GroupState) then) =
      _$GroupStateCopyWithImpl<$Res, GroupState>;
  @useResult
  $Res call(
      {bool loading,
      GroupModel? readGroup,
      bool sending,
      List<ReadGroupMessage> readGroupMessages,
      List<ReadGroupMessage> newReadGroupMessages,
      List<ReadGroupMessage> pastReadGroupMessages,
      bool fetchitg,
      bool hasMore,
      String? lastReadGroupMessageId});

  $GroupModelCopyWith<$Res>? get readGroup;
}

/// @nodoc
class _$GroupStateCopyWithImpl<$Res, $Val extends GroupState>
    implements $GroupStateCopyWith<$Res> {
  _$GroupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? readGroup = freezed,
    Object? sending = null,
    Object? readGroupMessages = null,
    Object? newReadGroupMessages = null,
    Object? pastReadGroupMessages = null,
    Object? fetchitg = null,
    Object? hasMore = null,
    Object? lastReadGroupMessageId = freezed,
  }) {
    return _then(_value.copyWith(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      readGroup: freezed == readGroup
          ? _value.readGroup
          : readGroup // ignore: cast_nullable_to_non_nullable
              as GroupModel?,
      sending: null == sending
          ? _value.sending
          : sending // ignore: cast_nullable_to_non_nullable
              as bool,
      readGroupMessages: null == readGroupMessages
          ? _value.readGroupMessages
          : readGroupMessages // ignore: cast_nullable_to_non_nullable
              as List<ReadGroupMessage>,
      newReadGroupMessages: null == newReadGroupMessages
          ? _value.newReadGroupMessages
          : newReadGroupMessages // ignore: cast_nullable_to_non_nullable
              as List<ReadGroupMessage>,
      pastReadGroupMessages: null == pastReadGroupMessages
          ? _value.pastReadGroupMessages
          : pastReadGroupMessages // ignore: cast_nullable_to_non_nullable
              as List<ReadGroupMessage>,
      fetchitg: null == fetchitg
          ? _value.fetchitg
          : fetchitg // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      lastReadGroupMessageId: freezed == lastReadGroupMessageId
          ? _value.lastReadGroupMessageId
          : lastReadGroupMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GroupModelCopyWith<$Res>? get readGroup {
    if (_value.readGroup == null) {
      return null;
    }

    return $GroupModelCopyWith<$Res>(_value.readGroup!, (value) {
      return _then(_value.copyWith(readGroup: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupStateImplCopyWith<$Res>
    implements $GroupStateCopyWith<$Res> {
  factory _$$GroupStateImplCopyWith(
          _$GroupStateImpl value, $Res Function(_$GroupStateImpl) then) =
      __$$GroupStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      GroupModel? readGroup,
      bool sending,
      List<ReadGroupMessage> readGroupMessages,
      List<ReadGroupMessage> newReadGroupMessages,
      List<ReadGroupMessage> pastReadGroupMessages,
      bool fetchitg,
      bool hasMore,
      String? lastReadGroupMessageId});

  @override
  $GroupModelCopyWith<$Res>? get readGroup;
}

/// @nodoc
class __$$GroupStateImplCopyWithImpl<$Res>
    extends _$GroupStateCopyWithImpl<$Res, _$GroupStateImpl>
    implements _$$GroupStateImplCopyWith<$Res> {
  __$$GroupStateImplCopyWithImpl(
      _$GroupStateImpl _value, $Res Function(_$GroupStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? readGroup = freezed,
    Object? sending = null,
    Object? readGroupMessages = null,
    Object? newReadGroupMessages = null,
    Object? pastReadGroupMessages = null,
    Object? fetchitg = null,
    Object? hasMore = null,
    Object? lastReadGroupMessageId = freezed,
  }) {
    return _then(_$GroupStateImpl(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      readGroup: freezed == readGroup
          ? _value.readGroup
          : readGroup // ignore: cast_nullable_to_non_nullable
              as GroupModel?,
      sending: null == sending
          ? _value.sending
          : sending // ignore: cast_nullable_to_non_nullable
              as bool,
      readGroupMessages: null == readGroupMessages
          ? _value._readGroupMessages
          : readGroupMessages // ignore: cast_nullable_to_non_nullable
              as List<ReadGroupMessage>,
      newReadGroupMessages: null == newReadGroupMessages
          ? _value._newReadGroupMessages
          : newReadGroupMessages // ignore: cast_nullable_to_non_nullable
              as List<ReadGroupMessage>,
      pastReadGroupMessages: null == pastReadGroupMessages
          ? _value._pastReadGroupMessages
          : pastReadGroupMessages // ignore: cast_nullable_to_non_nullable
              as List<ReadGroupMessage>,
      fetchitg: null == fetchitg
          ? _value.fetchitg
          : fetchitg // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      lastReadGroupMessageId: freezed == lastReadGroupMessageId
          ? _value.lastReadGroupMessageId
          : lastReadGroupMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GroupStateImpl implements _GroupState {
  const _$GroupStateImpl(
      {this.loading = true,
      this.readGroup,
      this.sending = false,
      final List<ReadGroupMessage> readGroupMessages =
          const <ReadGroupMessage>[],
      final List<ReadGroupMessage> newReadGroupMessages =
          const <ReadGroupMessage>[],
      final List<ReadGroupMessage> pastReadGroupMessages =
          const <ReadGroupMessage>[],
      this.fetchitg = false,
      this.hasMore = true,
      this.lastReadGroupMessageId})
      : _readGroupMessages = readGroupMessages,
        _newReadGroupMessages = newReadGroupMessages,
        _pastReadGroupMessages = pastReadGroupMessages;

  @override
  @JsonKey()
  final bool loading;
  @override
  final GroupModel? readGroup;
  @override
  @JsonKey()
  final bool sending;
  final List<ReadGroupMessage> _readGroupMessages;
  @override
  @JsonKey()
  List<ReadGroupMessage> get readGroupMessages {
    if (_readGroupMessages is EqualUnmodifiableListView)
      return _readGroupMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readGroupMessages);
  }

  final List<ReadGroupMessage> _newReadGroupMessages;
  @override
  @JsonKey()
  List<ReadGroupMessage> get newReadGroupMessages {
    if (_newReadGroupMessages is EqualUnmodifiableListView)
      return _newReadGroupMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newReadGroupMessages);
  }

  final List<ReadGroupMessage> _pastReadGroupMessages;
  @override
  @JsonKey()
  List<ReadGroupMessage> get pastReadGroupMessages {
    if (_pastReadGroupMessages is EqualUnmodifiableListView)
      return _pastReadGroupMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pastReadGroupMessages);
  }

  @override
  @JsonKey()
  final bool fetchitg;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  final String? lastReadGroupMessageId;

  @override
  String toString() {
    return 'GroupState(loading: $loading, readGroup: $readGroup, sending: $sending, readGroupMessages: $readGroupMessages, newReadGroupMessages: $newReadGroupMessages, pastReadGroupMessages: $pastReadGroupMessages, fetchitg: $fetchitg, hasMore: $hasMore, lastReadGroupMessageId: $lastReadGroupMessageId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.readGroup, readGroup) ||
                other.readGroup == readGroup) &&
            (identical(other.sending, sending) || other.sending == sending) &&
            const DeepCollectionEquality()
                .equals(other._readGroupMessages, _readGroupMessages) &&
            const DeepCollectionEquality()
                .equals(other._newReadGroupMessages, _newReadGroupMessages) &&
            const DeepCollectionEquality()
                .equals(other._pastReadGroupMessages, _pastReadGroupMessages) &&
            (identical(other.fetchitg, fetchitg) ||
                other.fetchitg == fetchitg) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.lastReadGroupMessageId, lastReadGroupMessageId) ||
                other.lastReadGroupMessageId == lastReadGroupMessageId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      readGroup,
      sending,
      const DeepCollectionEquality().hash(_readGroupMessages),
      const DeepCollectionEquality().hash(_newReadGroupMessages),
      const DeepCollectionEquality().hash(_pastReadGroupMessages),
      fetchitg,
      hasMore,
      lastReadGroupMessageId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupStateImplCopyWith<_$GroupStateImpl> get copyWith =>
      __$$GroupStateImplCopyWithImpl<_$GroupStateImpl>(this, _$identity);
}

abstract class _GroupState implements GroupState {
  const factory _GroupState(
      {final bool loading,
      final GroupModel? readGroup,
      final bool sending,
      final List<ReadGroupMessage> readGroupMessages,
      final List<ReadGroupMessage> newReadGroupMessages,
      final List<ReadGroupMessage> pastReadGroupMessages,
      final bool fetchitg,
      final bool hasMore,
      final String? lastReadGroupMessageId}) = _$GroupStateImpl;

  @override
  bool get loading;
  @override
  GroupModel? get readGroup;
  @override
  bool get sending;
  @override
  List<ReadGroupMessage> get readGroupMessages;
  @override
  List<ReadGroupMessage> get newReadGroupMessages;
  @override
  List<ReadGroupMessage> get pastReadGroupMessages;
  @override
  bool get fetchitg;
  @override
  bool get hasMore;
  @override
  String? get lastReadGroupMessageId;
  @override
  @JsonKey(ignore: true)
  _$$GroupStateImplCopyWith<_$GroupStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
