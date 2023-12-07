import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/utils/firestore_refs.dart';

@FirestoreDocument(
  path: 'groups/{groupId}/groupMessages',
  documentName: 'groupMessage',
)
class GroupMessage {
  const GroupMessage({
    required this.senderId,
    required this.messageType,
    required this.content,
    required this.imageUrl,
    required this.isDeleted,
    this.createdAt,
  });

  final String senderId;

  @_messageTypeConverter
  final String messageType;

  @ReadDefault('')
  final String content;

  @ReadDefault(String)
  @CreateDefault(String)
  final String imageUrl;

  @ReadDefault(false)
  @CreateDefault(false)
  final bool isDeleted;

  @AlwaysUseFieldValueServerTimestampWhenCreating()
  final DateTime? createdAt;
}

enum MessageType {
  text,
  picture;

  factory MessageType.fromString(String messageTypeString) {
    switch (messageTypeString) {
      case 'text':
        return MessageType.text;
      case 'picture':
        return MessageType.picture;
    }
    throw ArgumentError("メッセージの種別が正しくありません。");
  }
}

const _messageTypeConverter = _MessageTypeConverter();

class _MessageTypeConverter implements JsonConverter<MessageType, String> {
  const _MessageTypeConverter();

  @override
  MessageType fromJson(String json) => MessageType.fromString(json);

  @override
  String toJson(MessageType messageType) => messageType.name;
}

class ReadGroupMessage {
  const ReadGroupMessage({
    required this.messageId,
    required this.messageType,
    required this.path,
    required this.senderId,
    required this.content,
    required this.imageUrl,
    required this.isDeleted,
    required this.createdAt,
  });

  final String messageId;
  final MessageType messageType;
  final String path;
  final String senderId;
  final String content;
  final String imageUrl;
  final bool isDeleted;
  final DateTime? createdAt;

  factory ReadGroupMessage._fromJson(Map<String, dynamic> json) {
    return ReadGroupMessage(
      messageId: json['messageId'] as String,
      messageType:
          _messageTypeConverter.fromJson(json['messageType'] as String),
      path: json['path'] as String,
      senderId: json['senderId'] as String,
      content: json['content'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  factory ReadGroupMessage.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return ReadGroupMessage._fromJson(<String, dynamic>{
      ...data,
      'messageId': ds.id,
      'path': ds.reference.path,
    });
  }
}

class CreateGroupMessage {
  const CreateGroupMessage({
    required this.senderId,
    required this.messageType,
    this.content,
    this.imageUrl,
    this.isDeleted = false,
  });

  final String senderId;
  final MessageType messageType;
  final String? content;
  final String? imageUrl;
  final bool isDeleted;

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'messageType': _messageTypeConverter.toJson(messageType),
      'content': content,
      'imageUrl': imageUrl,
      'isDeleted': isDeleted,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}

final _db = FirebaseFirestore.instance.collection('groups');

CollectionReference<ReadGroupMessage> readGroupMessageCollectionReference({
  required String groupId,
}) =>
    _db
        .doc(groupId)
        .collection('groupMessages')
        .withConverter<ReadGroupMessage>(
          fromFirestore: (ds, _) => ReadGroupMessage.fromDocumentSnapshot(ds),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

DocumentReference<ReadGroupMessage> readGroupMessageDocumentReference({
  required String groupId,
  required String messageId,
}) =>
    readGroupMessageCollectionReference(groupId: groupId).doc(messageId);

CollectionReference<CreateGroupMessage> createGroupMessageCollectionReference({
  required String groupId,
}) =>
    _db
        .doc(groupId)
        .collection('groupMessages')
        .withConverter<CreateGroupMessage>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

DocumentReference<CreateGroupMessage> createGroupMessageDocumentReference({
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
  Future<List<ReadGroupMessage>> fetchDocuments({
    required String groupId,
    GetOptions? options,
    Query<ReadGroupMessage>? Function(Query<ReadGroupMessage> query)?
        queryBuilder,
    int Function(ReadGroupMessage lhs, ReadGroupMessage rhs)? compare,
  }) async {
    Query<ReadGroupMessage> query =
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

  Stream<List<ReadGroupMessage>> subscribeDocuments({
    required String groupId,
    Query<ReadGroupMessage>? Function(Query<ReadGroupMessage> query)?
        queryBuilder,
    int Function(ReadGroupMessage lhs, ReadGroupMessage rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<ReadGroupMessage> query =
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
  Future<ReadGroupMessage?> fetchDocument({
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
  Stream<ReadGroupMessage?> subscribeDocument({
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
  Future<DocumentReference<CreateGroupMessage>> add({
    required String groupId,
    required CreateGroupMessage createGroupMessage,
  }) =>
      createGroupMessageCollectionReference(groupId: groupId)
          .add(createGroupMessage);

  /// Sets a [Message] document.
  Future<void> set({
    required String groupId,
    required String messageId,
    required CreateGroupMessage createGroupMessage,
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

  Future<void> sendAllGroup({
    required String userId,
    required CreateGroupMessage allGroupMessage,
  }) async {
    final groupDocs =
        await groupsRef.where("members", arrayContains: userId).get();

    for (final groupDoc in groupDocs.docs) {
      final groupMessagesRef = groupDoc.reference.collection('groupMessages');
      groupMessagesRef.add(allGroupMessage.toJson());
    }
  }
}
