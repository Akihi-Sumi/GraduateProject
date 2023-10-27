import 'dart:async';

import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/repositories/group_message/group_message_repository_impl.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupMessageProvider = StreamProvider.autoDispose<List<Message>>((ref) {
  final groupMessages =
      ref.read(groupMessageRepositoryImplProvider).subscribeGroupMessages(
            queryBuilder: (q) => q.orderBy('createdAt', descending: true),
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
    required Message groupMessage,
    //required GroupModel group,
  }) async {
    final groupMessageRepository = ref.read(groupMessageRepositoryImplProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        if (groupMessage.messageText.isEmpty) {
          throw const AppException(
            message: "文章を入力してください",
          );
        }
        // if (group.groupId == 'id-unselected') {
        //   throw const AppException(
        //     message: "グループを選択してください",
        //   );
        // }

        await groupMessageRepository.sendMessage(
          groupMessage: groupMessage,
        );
      } on AppException {
        rethrow;
      }
    });
  }
}
