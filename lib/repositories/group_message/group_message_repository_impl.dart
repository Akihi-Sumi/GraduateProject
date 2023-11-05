import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/utils/firestore_refs.dart';
import 'package:graduate_app/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'group_message_repository.dart';

final groupMessageRepositoryImplProvider = Provider<GroupMessageRepositoryImpl>(
  (ref) => GroupMessageRepositoryImpl(),
);

class GroupMessageRepositoryImpl implements GroupMessageRepository {
  @override
  Future<Message?> fetchGroupMessage({
    required String groupId,
    required String messageId,
  }) async {
    final ds =
        await groupMessageRef(groupId: groupId, messageId: messageId).get();

    if (!ds.exists) {
      logger.warning("Document not found: ${ds.reference.path}");
      return null;
    }
    return ds.data();
  }

  @override
  Stream<List<Message>> subscribeGroupMessages({
    required String groupId,
    Query<Message>? Function(Query<Message> query)? queryBuilder,
    int Function(Message lhs, Message rhs)? compare,
  }) {
    Query<Message> query = groupMessagesRef(groupId: groupId);

    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }

    return query.snapshots().map((qs) {
      final groupMessage = qs.docs.map((qds) => qds.data()).toList();

      if (compare != null) {
        groupMessage.sort(compare);
      }

      return groupMessage;
    });
  }

  @override
  Future<void> sendMessage({
    required String groupId,
    required Message groupMessage,
  }) async {
    await groupMessagesRef(groupId: groupId).add(groupMessage);
  }

  @override
  Future<void> updateGroupMessage({
    required String groupId,
    required String messageId,
    required Message groupMessage,
  }) async {
    await groupMessagesRef(groupId: groupId).doc(messageId).set(
          groupMessage,
          SetOptions(merge: true),
        );
  }

  @override
  Future<void> deleteGroupMessage({
    required String groupId,
    required String messageId,
    required Message groupMessage,
  }) async {
    await groupMessagesRef(groupId: groupId).doc(messageId).delete();
  }
}
