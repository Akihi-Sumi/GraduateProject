import 'package:graduate_app/controllers/group/read_status.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/repositories/group.dart';
import 'package:graduate_app/repositories/group_message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupsStreamProvider =
    StreamProvider.family.autoDispose<List<GroupModel>, String>((ref, userId) {
  return ref.watch(groupRepositoryProvider).subscribeGroups(userId: userId);
});

final _latestMessagesStreamProvider =
    StreamProvider.family.autoDispose<List<Message>, String>(
  (ref, groupId) => ref
      .watch(groupMessageRepositoryProvider)
      .subscribeLatestMessages(groupId: groupId),
);

final latestMessageProvider =
    Provider.family.autoDispose<Message?, String>((ref, groupId) {
  final latestMessages =
      ref.watch(_latestMessagesStreamProvider(groupId)).value ?? [];
  return latestMessages.firstOrNull;
});

const _maxUnReadCount = 10;

final _unReadCountStreamProvider =
    StreamProvider.autoDispose.family<int, GroupModel>((ref, readGroup) {
  final readStatus =
      ref.watch(myReadStatusStreamProvider(readGroup)).valueOrNull;
  final lastReadAt = readStatus?.lastReadAt;

  return ref
      .watch(groupMessageRepositoryProvider)
      .subscribeUnReadGroupMessages(
          groupId: readGroup.groupId,
          lastReadAt: lastReadAt,
          limit: _maxUnReadCount + 1)
      .map((messages) => messages.length);
});

final unReadCountStringProvider =
    Provider.autoDispose.family<String, GroupModel>((ref, readGroup) {
  final unReadCount =
      ref.watch(_unReadCountStreamProvider(readGroup)).value ?? 0;
  if (unReadCount == 0) {
    return '';
  }
  if (unReadCount > _maxUnReadCount) {
    return '$_maxUnReadCount+';
  }
  return unReadCount.toString();
});
