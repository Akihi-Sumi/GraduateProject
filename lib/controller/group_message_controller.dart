import 'package:flutter/material.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/models/post/group_model.dart';
import 'package:graduate_app/repositories/group_message_repository.dart';
import 'package:graduate_app/utils/json_converters/union_timestamp.dart';
import 'package:graduate_app/widgets/show_snack_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

final groupMessageControllerProvider =
    StateNotifierProvider<GroupMessageController, bool>((ref) {
  final groupMessageRepository = ref.watch(groupMessageRepositoryProvider);
  //final storageRepository = ref.watch(storageRepositoryProvider);

  return GroupMessageController(
    groupMessageRepository: groupMessageRepository,
    //storageRepository: storageRepository,
    ref: ref,
  );
});

final userGroupMessagesProvider =
    StreamProvider.family((ref, List<GroupModel2> groups) {
  final groupMessageController =
      ref.watch(groupMessageControllerProvider.notifier);

  return groupMessageController.fetchUserGroupMessages(groups);
});

final getGroupMessageByIdProvider =
    StreamProvider.family((ref, String messageId) {
  final groupMessageContorller =
      ref.watch(groupMessageControllerProvider.notifier);

  return groupMessageContorller.getGroupMessageById(messageId);
});

class GroupMessageController extends StateNotifier<bool> {
  final GroupMessageRepository _groupMessageRepository;
  //final StorageRepository _storageRepository;

  GroupMessageController({
    required GroupMessageRepository groupMessageRepository,
    //required StorageRepository storageRepository,
    required Ref ref,
  })  : _groupMessageRepository = groupMessageRepository,
        // _storageRepository = storageRepository,
        super(false);

  void sendTextMessage({
    required BuildContext context,
    required GroupModel2 selectedGroup,
    required String messageText,
  }) async {
    state = true;
    String messageId = const Uuid().v1();
    //final user = _ref.read(userProvider);

    final Message message = Message(
      messageId: messageId,
      messageText: messageText,
      // userId: user.uid,
      // userName: user.name,
      // type: 'text,
      // groupName: selectedGroup,
      createdAt: UnionTimestamp.serverTimestamp(),
      updatedAt: UnionTimestamp.serverTimestamp(),
    );

    final res = await _groupMessageRepository.addGroupMessage(message);
    state = false;

    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, "メッセージを送信しました");
    });
  }

  Stream<List<Message>> fetchUserGroupMessages(List<GroupModel2> groups) {
    if (groups.isNotEmpty) {
      return _groupMessageRepository.fetchUserGroupMessages(groups);
    }

    return Stream.value([]);
  }

  Stream<Message> getGroupMessageById(String messageId) {
    return _groupMessageRepository.getGroupMessageById(messageId);
  }
}