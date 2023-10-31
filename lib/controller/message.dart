import 'dart:async';

import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/repositories/message/message_repository_impl.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final messagesProvider = StreamProvider.autoDispose<List<Message>>((ref) {
  final userId = ref.watch(authRepositoryImplProvider).currentUser!.uid;
  final messages = ref.read(messageRepositoryImplProvider).subscribeMessages(
        userId: userId,
        queryBuilder: (q) => q.orderBy('createdAt', descending: false),
      );
  return messages;
});

/// メッセージを追加する処理
final createMessageControllerProvider =
    AutoDisposeAsyncNotifierProvider<CreateMessageController, void>(
  CreateMessageController.new,
);

class CreateMessageController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  // メッセージを追加
  Future<void> createMessage({
    required String userId,
    required Message message,
  }) async {
    final messageRepository = ref.read(messageRepositoryImplProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        if (message.messageText.isEmpty) {
          throw const AppException(
            message: '文章を入力してください。',
          );
        }
        await messageRepository.create(
          userId: userId,
          message: message,
        );
      } on AppException {
        rethrow;
      }
    });
  }
}

/// メッセージの更新
final messageUpdateControllerProvider =
    AutoDisposeAsyncNotifierProvider<UpdateMessageController, void>(
  UpdateMessageController.new,
);

class UpdateMessageController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> updateMessage({
    required String userId,
    required String messageId,
    required Message message,
  }) async {
    final messageRepository = ref.read(messageRepositoryImplProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        if (message.messageText.isEmpty) {
          throw const AppException(
            message: '文章を入力してください。',
          );
        }

        await messageRepository.update(
          userId: userId,
          messageId: messageId,
          message: message,
        );
      } on AppException {
        rethrow;
      }
    });
  }
}

/// メッセージを削除する処理
final messageDeleteControllerProvider =
    AutoDisposeAsyncNotifierProvider<DeleteMessageController, void>(
  DeleteMessageController.new,
);

class DeleteMessageController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> deleteMessage({
    required String userId,
    required String messageId,
    required Message message,
  }) async {
    final messageRepository = ref.read(messageRepositoryImplProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        await messageRepository.delete(
          userId: userId,
          messageId: messageId,
          message: message,
        );
      } on AppException {
        rethrow;
      }
    });
  }
}
