import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/message/message.dart';

final _db = FirebaseFirestore.instance.collection('appUsers').doc;

CollectionReference<Message> readUserMessageCollectionReference({
  required String userId,
}) =>
    _db(userId).collection('message').withConverter<Message>(
          fromFirestore: (ds, _) => Message.fromDocumentSnapshot(ds),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

DocumentReference<Message> readUserMessageDocumentReference({
  required String userId,
  required String messageId,
}) =>
    readUserMessageCollectionReference(userId: userId).doc(messageId);

CollectionReference<Message> createUserMessageCollectionReference({
  required String userId,
}) =>
    _db(userId).collection('message').withConverter<Message>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

DocumentReference<Message> createUserMessageDocumentReference({
  required String userId,
  required String messageId,
}) =>
    createUserMessageCollectionReference(userId: userId).doc(messageId);

CollectionReference<Message> updateUserMessageCollectionReference({
  required String userId,
}) =>
    _db(userId).collection('message').withConverter<Message>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

DocumentReference<Message> updateUserMessageDocumentReference({
  required String userId,
  required String messageId,
}) =>
    updateUserMessageCollectionReference(userId: userId).doc(messageId);

CollectionReference<Message> deleteUserMessageCollectionReference({
  required String userId,
}) =>
    _db(userId).collection('message').withConverter<Message>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

DocumentReference<Message> deleteUserMessageDocumentReference({
  required String userId,
  required String messageId,
}) =>
    deleteUserMessageCollectionReference(userId: userId).doc(messageId);

class UserMessageQuery {
  Future<List<Message>> fetchDocuments({
    required String userId,
    GetOptions? options,
    Query<Message>? Function(Query<Message> query)? queryBuilder,
    int Function(Message lhs, Message rhs)? compare,
  }) async {
    Query<Message> query = readUserMessageCollectionReference(userId: userId);

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
    required String userId,
    Query<Message>? Function(Query<Message> query)? queryBuilder,
    int Function(Message lhs, Message rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<Message> query = readUserMessageCollectionReference(userId: userId);

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
    required String userId,
    required String messageId,
    GetOptions? options,
  }) async {
    final ds = await readUserMessageDocumentReference(
      userId: userId,
      messageId: messageId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes a specific [Message] document.
  Stream<Message?> subscribeDocument({
    required String userId,
    required String messageId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readUserMessageDocumentReference(
      userId: userId,
      messageId: messageId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a [Message] document.
  Future<DocumentReference<Message>> add({
    required String userId,
    required Message createUserMessage,
  }) =>
      createUserMessageCollectionReference(userId: userId)
          .add(createUserMessage);

  /// Sets a [Message] document.
  Future<void> set({
    required String userId,
    required String messageId,
    required Message createUserMessage,
    SetOptions? options,
  }) =>
      createUserMessageDocumentReference(userId: userId, messageId: messageId)
          .set(createUserMessage, options);

  /// Updates a specific [Message] document.
  Future<void> update({
    required String userId,
    required String messageId,
    required Message updateUserMessage,
  }) =>
      updateUserMessageDocumentReference(userId: userId, messageId: messageId)
          .update(updateUserMessage.toJson());

  /// Deletes a specific [Message] document.
  Future<void> delete({
    required String userId,
    required String messageId,
  }) =>
      deleteUserMessageDocumentReference(userId: userId, messageId: messageId)
          .delete();
}
