import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/models/message/message.dart';

part 'group_state.freezed.dart';

@freezed
class GroupState with _$GroupState {
  const factory GroupState({
    @Default(true) bool loading,
    GroupModel? readGroup,
    @Default(false) bool sending,
    @Default(<Message>[]) List<Message> readGroupMessages,
    @Default(<Message>[]) List<Message> newReadGroupMessages,
    @Default(<Message>[]) List<Message> pastReadGroupMessages,
    @Default(false) bool fetchitg,
    @Default(true) bool hasMore,
    String? lastReadGroupMessageId,
  }) = _GroupState;
}
