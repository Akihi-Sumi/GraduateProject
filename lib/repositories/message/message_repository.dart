import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/models.dart';

abstract class MessageRepository {
  Future<Message?> fetchMessage({
    required String userId,
    required String messageId,
  });

  Stream<List<Message>> subscribeMessages({
    required String userId,
    Query<Message>? Function(Query<Message> query)? queryBuilder,
    int Function(Message lhs, Message rhs)? compare,
  });

  Future<void> create({
    required String userId,
    required Message message,
  });

  Future<void> update({
    required String userId,
    required String messageId,
    required Message message,
  });

  Future<void> delete({
    required String userId,
    required String messageId,
    required Message message,
  });
}
