import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/utils/firestore_refs/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userMessageRepositoryProvider =
    Provider.autoDispose<UserMessageRepository>((_) => UserMessageRepository());

class UserMessageRepository {
  final _query = UserMessageQuery();

  Stream<List<Message>> subscribeUserMessage({
    required String userId,
    required DateTime createdAt,
  }) {
    return _query.subscribeDocuments(
      userId: userId,
      queryBuilder: (query) => query
          .orderBy('createdAt', descending: true)
          .where('createdAt', isGreaterThanOrEqualTo: createdAt),
    );
  }

  Future<void> addUserMessage({
    required String userId,
    required String senderId,
    required String content,
    required DateTime createdAt,
  }) {
    return _query.add(
      userId: userId,
      createUserMessage: Message(
        senderId: senderId,
        content: content,
        createdAt: createdAt,
      ),
    );
  }

  Future<void> updateUserMessage({
    required String userId,
    required String messageId,
    //required String senderId,
    required String content,
    required DateTime updatedAt,
  }) {
    return _query.update(
      userId: userId,
      messageId: messageId,
      updateUserMessage: Message(
        //senderId: senderId,
        content: content,
        updatedAt: updatedAt,
      ),
    );
  }
}
