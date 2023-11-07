import 'dart:async';

import 'package:graduate_app/controller/group.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/repositories/group_message/group_message_repository_impl.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupMessageProvider = StreamProvider.autoDispose<List<Message>>((ref) {
  final groupId = ref
      .watch(groupsStreamProvider)
      .maybeWhen(data: (data) => data.map((e) => e.groupId), orElse: () => '')
      .toString();
  final groupMessages =
      ref.read(groupMessageRepositoryImplProvider).subscribeGroupMessages(
            groupId: groupId,
            queryBuilder: (q) => q.orderBy('createdAt', descending: false),
          );

  return groupMessages;
});

final sendMessageControllerProvider =
    AutoDisposeAsyncNotifierProvider<SendMessageController, void>(
  SendMessageController.new,
);

class SendMessageController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> sendMessage({
    required String groupId,
    required Message groupMessage,
  }) async {
    final groupMessageRepository = ref.read(groupMessageRepositoryImplProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        if (groupMessage.content.isEmpty) {
          throw const AppException(
            message: "文章を入力してください",
          );
        }

        await groupMessageRepository.sendMessage(
          groupId: groupId,
          groupMessage: groupMessage,
        );
      } on AppException {
        rethrow;
      }
    });
  }

  Future<void> sendMessageAllGroup({
    required List<String> groupId,
    required Message groupMessage,
  }) async {
    final groupMessageRepo = ref.read(groupMessageRepositoryImplProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        await groupMessageRepo.sendMessageAllGroup(
            groupIds: groupId, groupMessage: groupMessage);
      } on AppException {
        rethrow;
      }
    });
  }
}
