import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/message/message.dart';

final _db = FirebaseFirestore.instance.collection('groups');

CollectionReference<Message> readGroupMessageCollectionReference({
  required String groupId,
}) =>
    _db.doc(groupId).collection('groupMessages').withConverter<Message>(
          fromFirestore: (ds, _) => Message.fromDocumentSnapshot(ds),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

DocumentReference<Message> readGroupMessageDocumentReference({
  required String groupId,
  required String messageId,
}) =>
    readGroupMessageCollectionReference(groupId: groupId).doc(messageId);

CollectionReference<Message> createGroupMessageCollectionReference({
  required String groupId,
}) =>
    _db.doc(groupId).collection('groupMessages').withConverter<Message>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

DocumentReference<Message> createGroupMessageDocumentReference({
  required String groupId,
  required String messageId,
}) =>
    createGroupMessageCollectionReference(groupId: groupId).doc(messageId);

CollectionReference<Message> updateGroupMessageCollectionReference({
  required String groupId,
}) =>
    _db.doc(groupId).collection('groupMessages').withConverter<Message>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

DocumentReference<Message> updateGroupMessageDocumentReference({
  required String groupId,
  required String messageId,
}) =>
    updateGroupMessageCollectionReference(groupId: groupId).doc(messageId);

CollectionReference<Message> deleteGroupMessageCollectionReference({
  required String groupId,
}) =>
    _db.doc(groupId).collection('groupMessages').withConverter<Message>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

DocumentReference<Message> deleteGroupMessageDocumentReference({
  required String groupId,
  required String messageId,
}) =>
    deleteGroupMessageCollectionReference(groupId: groupId).doc(messageId);

class GroupMessageQuery {
  Future<List<Message>> fetchDocuments({
    required String groupId,
    GetOptions? options,
    Query<Message>? Function(Query<Message> query)? queryBuilder,
    int Function(Message lhs, Message rhs)? compare,
  }) async {
    Query<Message> query =
        readGroupMessageCollectionReference(groupId: groupId);

    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final qs = await query.get(options);
    final result = qs.docs.map((qds) => qds.data()).toList();
    if (compare != null) {
      result.sort(compare);
    }
    return result;
  }

  Stream<List<Message>> subscribeDocuments({
    required String groupId,
    Query<Message>? Function(Query<Message> query)? queryBuilder,
    int Function(Message lhs, Message rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<Message> query =
        readGroupMessageCollectionReference(groupId: groupId);

    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    var streamQs =
        query.snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamQs = streamQs.where((qs) => !qs.metadata.hasPendingWrites);
    }
    return streamQs.map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }

  /// Fetches a specific [Message] document.
  Future<Message?> fetchDocument({
    required String groupId,
    required String messageId,
    GetOptions? options,
  }) async {
    final ds = await readGroupMessageDocumentReference(
      groupId: groupId,
      messageId: messageId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes a specific [Message] document.
  Stream<Message?> subscribeDocument({
    required String groupId,
    required String messageId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readGroupMessageDocumentReference(
      groupId: groupId,
      messageId: messageId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a [Message] document.
  Future<DocumentReference<Message>> add({
    required String groupId,
    required Message createGroupMessage,
  }) =>
      createGroupMessageCollectionReference(groupId: groupId)
          .add(createGroupMessage);

  /// Sets a [Message] document.
  Future<void> set({
    required String groupId,
    required String messageId,
    required Message createGroupMessage,
    SetOptions? options,
  }) =>
      createGroupMessageDocumentReference(
              groupId: groupId, messageId: messageId)
          .set(createGroupMessage, options);

  /// Updates a specific [Message] document.
  Future<void> update({
    required String groupId,
    required String messageId,
    required Message updateGroupMessage,
  }) =>
      updateGroupMessageDocumentReference(
              groupId: groupId, messageId: messageId)
          .update(updateGroupMessage.toJson());

  /// Deletes a specific [Message] document.
  Future<void> delete({
    required String groupId,
    required String messageId,
  }) =>
      deleteGroupMessageDocumentReference(
              groupId: groupId, messageId: messageId)
          .delete();
}
