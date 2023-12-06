import 'dart:async';

import 'package:graduate_app/repositories/group_message/group_message_repository_impl.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:graduate_app/utils/firestore_refs/group_message_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sendMessageAllGroupControllerProvider =
    AutoDisposeAsyncNotifierProvider<SendMessageController, void>(
  SendMessageController.new,
);

class SendMessageController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> sendMessageAllGroup({
    required CreateGroupMessage groupMessage,
    required String userId,
  }) async {
    final groupMessageRepo = ref.read(groupMessageRepositoryImplProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        await groupMessageRepo.sendMessageAllGroup(
          groupMessage: groupMessage,
          userId: userId,
        );
      } on AppException {
        rethrow;
      }
    });
  }
}
