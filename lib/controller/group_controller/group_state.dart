import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/utils/firestore_refs/group_message_ref.dart';

part 'group_state.freezed.dart';

@freezed
class GroupState with _$GroupState {
  const factory GroupState({
    @Default(true) bool loading,
    GroupModel? readGroup,
    @Default(false) bool sending,
    @Default(<ReadGroupMessage>[]) List<ReadGroupMessage> readGroupMessages,
    @Default(<ReadGroupMessage>[]) List<ReadGroupMessage> newReadGroupMessages,
    @Default(<ReadGroupMessage>[]) List<ReadGroupMessage> pastReadGroupMessages,
    @Default(false) bool fetchitg,
    @Default(true) bool hasMore,
    String? lastReadGroupMessageId,
  }) = _GroupState;
}
