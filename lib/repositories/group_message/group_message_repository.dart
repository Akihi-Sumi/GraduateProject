import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/message/message.dart';

abstract class GroupMessageRepository {
  Future<void> sendMessage({
    required String groupId,
    required Message groupMessage,
  });

  Future<void> sendMessageAllGroup({
    //required List<String> groupIds,
    required Message groupMessage,
  });

  Future<Message?> fetchGroupMessage({
    required String groupId,
    required String messageId,
  });

  Future<void> updateGroupMessage({
    required String groupId,
    required String messageId,
    required Message groupMessage,
  });

  Future<void> deleteGroupMessage({
    required String groupId,
    required String messageId,
    required Message groupMessage,
  });

  Stream<List<Message>> subscribeGroupMessages({
    required String groupId,
    Query<Message>? Function(Query<Message> query)? queryBuilder,
    int Function(Message lhs, Message rhs)? compare,
  });
}
