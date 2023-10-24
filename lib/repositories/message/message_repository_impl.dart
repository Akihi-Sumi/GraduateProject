import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/utils/firestore_refs.dart';
import 'package:graduate_app/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'message_repository.dart';

final messageRepositoryImplProvider = Provider<MessageRepositoryImpl>(
  (ref) => MessageRepositoryImpl(),
);

class MessageRepositoryImpl implements MessageRepository {
  @override
  Future<Message?> fetchMessage({
    required String userId,
    required String messageId,
  }) async {
    final ds = await messageRef(userId: userId, messageId: messageId).get();

    if (!ds.exists) {
      logger.warning('Document not found: ${ds.reference.path}');
      return null;
    }
    return ds.data();
  }

  @override
  Stream<List<Message>> subscribeMessages({
    required String userId,
    Query<Message>? Function(Query<Message> query)? queryBuilder,
    int Function(Message lhs, Message rhs)? compare,
  }) {
    Query<Message> query = messagesRef(userId: userId);

    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    return query.snapshots().map((qs) {
      final message = qs.docs.map((qds) => qds.data()).toList();

      if (compare != null) {
        message.sort(compare);
      }
      return message;
    });
  }

  @override
  Future<void> create({
    required String userId,
    required Message message,
  }) async {
    await messagesRef(userId: userId).add(
      message,
    );
  }

  @override
  Future<void> update({
    required String userId,
    required String messageId,
    required Message message,
  }) async {
    await messagesRef(userId: userId)
        .doc(messageId)
        .set(message, SetOptions(merge: true));
  }

  @override
  Future<void> delete({
    required String userId,
    required String messageId,
    required Message message,
  }) async {
    await messagesRef(userId: userId).doc(messageId).delete();
  }
}
