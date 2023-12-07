import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/utils/firestore_refs.dart';
import 'package:graduate_app/utils/firestore_refs/group_message_ref.dart';
import 'package:graduate_app/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class GroupMessageRepository {
  Future<void> sendMessage({
    required String groupId,
    required Message groupMessage,
  });

  Future<Message?> fetchGroupMessage({
    required String messageId,
    required String groupId,
  });
  Future<void> sendMessageAllGroup({
    required CreateGroupMessage groupMessage,
    String? userId,
    //String? content,
  });
  Stream<List<Message>> subscribeGroupMessages({
    required String groupId,
    Query<Message>? Function(Query<Message> query)? queryBuilder,
    int Function(Message lhs, Message rhs)? compare,
  });
}

final groupMessageRepositoryImplProvider = Provider<GroupMessageRepositoryImpl>(
  (ref) => GroupMessageRepositoryImpl(),
);

class GroupMessageRepositoryImpl implements GroupMessageRepository {
  @override
  Future<Message?> fetchGroupMessage({
    required String messageId,
    required String groupId,
  }) async {
    final ds =
        await groupMessageRef(messageId: messageId, groupId: groupId).get();

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
  Future<void> sendMessageAllGroup({
    required CreateGroupMessage groupMessage,
    String? userId,
    //String? content,
  }) async {
    final groupDocs =
        await groupsRef.where("members", arrayContains: userId).get();

    for (final groupDoc in groupDocs.docs) {
      final groupMessagesRef = groupDoc.reference.collection('groupMessages');
      groupMessagesRef.add(groupMessage.toJson());
    }
  }
}
