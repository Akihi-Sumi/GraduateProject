import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/utils/firestore_refs/group_message_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupMessageRepositoryProvider =
    Provider.autoDispose<GroupMessageRepository>(
        (_) => GroupMessageRepository());

class GroupMessageRepository {
  final _query = GroupMessageQuery();

  final Map<String, QueryDocumentSnapshot<ReadGroupMessage>>
      _lastReadQueryDocumentSnapshotCache = {};

  Future<(List<ReadGroupMessage>, String?, bool)>
      loadMessageWithDocumentIdCursor({
    required String groupId,
    required int limit,
    required String? lastReadMessageId,
  }) async {
    var query = readGroupMessageCollectionReference(groupId: groupId)
        .orderBy('createdAt', descending: false);

    final qds = lastReadMessageId == null
        ? null
        : _lastReadQueryDocumentSnapshotCache[lastReadMessageId];

    if (qds != null) {
      query = query.startAfterDocument(qds);
    }
    final qs = await query.limit(limit).get();
    final readMessages = qs.docs.map((qds) => qds.data()).toList();
    final lastReadQds = qs.docs.lastOrNull;
    _updateLastReadQueryDocumentSnapshotCache(lastReadQds);

    return (
      readMessages,
      lastReadQds?.id,
      readMessages.length >= limit,
    );
  }

  void _updateLastReadQueryDocumentSnapshotCache(
    QueryDocumentSnapshot<ReadGroupMessage>? lastReadQueryDocumentSnaphot,
  ) {
    _lastReadQueryDocumentSnapshotCache.clear();
    if (lastReadQueryDocumentSnaphot != null) {
      _lastReadQueryDocumentSnapshotCache[lastReadQueryDocumentSnaphot.id] =
          lastReadQueryDocumentSnaphot;
    }
  }

  /// Subscribe to the [GroupMessage] list after [startDateTime] of the specified [groupId].
  Stream<List<ReadGroupMessage>> subscribeGroupMessage({
    required String groupId,
    required DateTime startDateTime,
  }) {
    return _query.subscribeDocuments(
      groupId: groupId,
      queryBuilder: (query) => query
          .orderBy('createdAt', descending: true)
          .where('createdAt', isGreaterThanOrEqualTo: startDateTime),
    );
  }

  /// Create a [GroupMessage] for the specified [groupId].
  Future<void> addGroupMessage({
    required String groupId,
    required String senderId,
    required String content,
    List<String> imageUrls = const <String>[],
  }) {
    return _query.add(
      groupId: groupId,
      createGroupMessage: CreateGroupMessage(
        senderId: senderId,
        content: content,
        imageUrls: imageUrls,
      ),
    );
  }

  /// Returns at most one latest [GroupMessage] list for the specified [groupId].
  Stream<List<ReadGroupMessage>> subscribeLatestMessages({
    required String groupId,
  }) {
    return _query.subscribeDocuments(
      groupId: groupId,
      queryBuilder: (query) => query
          .where('isDeleted', isNotEqualTo: true)
          .orderBy('isDeleted')
          .orderBy('createdAt', descending: true)
          .limit(1),
    );
  }

  Stream<List<ReadGroupMessage>> subscribeUnReadGroupMessages({
    required String groupId,
    required DateTime? lastReadAt,
    required int limit,
  }) {
    return _query.subscribeDocuments(
      groupId: groupId,
      queryBuilder: (query) => lastReadAt != null
          ? query
              .where('createdAt', isGreaterThan: lastReadAt)
              .orderBy('createdAt', descending: true)
              .limit(limit)
          : query.orderBy('createdAt', descending: true).limit(limit),
    );
  }
}
