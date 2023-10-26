import 'package:flutter/material.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
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
    StreamProvider.family((ref, List<GroupModel> groups) {
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
  final Ref _ref;

  GroupMessageController({
    required GroupMessageRepository groupMessageRepository,
    //required StorageRepository storageRepository,
    required Ref ref,
  })  : _groupMessageRepository = groupMessageRepository,
        _ref = ref,
        // _storageRepository = storageRepository,
        super(false);

  void sendTextMessage({
    required BuildContext context,
    required GroupModel selectedGroup,
    required String messageText,
  }) async {
    state = true;
    String messageId = const Uuid().v1();

    // final uid = _ref.watch(authRepositoryImplProvider).currentUser?.uid ?? '';
    final uid = _ref.watch(authRepositoryImplProvider).currentUser?.uid ?? '';
    final userName = _ref.watch(userProvider)?.userName ?? '';

    final Message message = Message(
      messageId: messageId,
      messageText: messageText,
      userId: uid,
      userName: userName,
      type: 'text',
      groupName: selectedGroup.groupName,
      createdAt: UnionTimestamp.serverTimestamp(),
      updatedAt: UnionTimestamp.serverTimestamp(),
    );

    final res = await _groupMessageRepository.addGroupMessage(message);
    state = false;

    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, "メッセージを送信しました");
    });
  }

  Stream<List<Message>> fetchUserGroupMessages(List<GroupModel> groups) {
    if (groups.isNotEmpty) {
      return _groupMessageRepository.fetchUserGroupMessages(groups);
    }

    return Stream.value([]);
  }

  Stream<Message> getGroupMessageById(String messageId) {
    return _groupMessageRepository.getGroupMessageById(messageId);
  }
}
