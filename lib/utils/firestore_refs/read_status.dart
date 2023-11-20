import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/read_status/read_status.dart';

final _db = FirebaseFirestore.instance.collection('groups').doc;

///
CollectionReference<ReadStatus> readReadStatusCollectionReference({
  required String groupId,
}) =>
    _db(groupId).collection('readStatus').withConverter<ReadStatus>(
          fromFirestore: (ds, _) => ReadStatus.fromDocumentSnapshot(ds),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

DocumentReference<ReadStatus> readReadStatusDocumentReference({
  required String groupId,
  required String readStatusId,
}) =>
    readReadStatusCollectionReference(groupId: groupId).doc(readStatusId);

///
CollectionReference<ReadStatus> createReadStatusCollectionReference({
  required String groupId,
}) =>
    _db(groupId).collection('readStatus').withConverter<ReadStatus>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

DocumentReference<ReadStatus> createReadStatusDocumentReference({
  required String groupId,
  required String readStatusId,
}) =>
    createReadStatusCollectionReference(groupId: groupId).doc(readStatusId);

///
CollectionReference<ReadStatus> updateReadStatusCollectionReference({
  required String groupId,
}) =>
    _db(groupId).collection('readStatus').withConverter<ReadStatus>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (obj, _) => obj.toJson(),
        );

DocumentReference<ReadStatus> updateReadStatusDocumentReference({
  required String groupId,
  required String readStatusId,
}) =>
    updateReadStatusCollectionReference(groupId: groupId).doc(readStatusId);

///
CollectionReference<ReadStatus> deleteReadStatusCollectionReference({
  required String groupId,
}) =>
    _db(groupId).collection('readStatus').withConverter<ReadStatus>(
          fromFirestore: (_, __) => throw UnimplementedError(),
          toFirestore: (_, __) => throw UnimplementedError(),
        );

DocumentReference<ReadStatus> deleteReadStatusDocumentReference({
  required String groupId,
  required String readStatusId,
}) =>
    deleteReadStatusCollectionReference(groupId: groupId).doc(readStatusId);

class ReadStatusQuery {
  /// Fetches [ReadReadStatus] documents.
  Future<List<ReadStatus>> fetchDocuments({
    required String groupId,
    GetOptions? options,
    Query<ReadStatus>? Function(Query<ReadStatus> query)? queryBuilder,
    int Function(ReadStatus lhs, ReadStatus rhs)? compare,
  }) async {
    Query<ReadStatus> query =
        readReadStatusCollectionReference(groupId: groupId);
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

  /// Subscribes [ReadStatus] documents.
  Stream<List<ReadStatus>> subscribeDocuments({
    required String groupId,
    Query<ReadStatus>? Function(Query<ReadStatus> query)? queryBuilder,
    int Function(ReadStatus lhs, ReadStatus rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<ReadStatus> query =
        readReadStatusCollectionReference(groupId: groupId);
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

  /// Fetches a specific [ReadReadStatus] document.
  Future<ReadStatus?> fetchDocument({
    required String groupId,
    required String readStatusId,
    GetOptions? options,
  }) async {
    final ds = await readReadStatusDocumentReference(
      groupId: groupId,
      readStatusId: readStatusId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes a specific [ReadStatus] document.
  Stream<ReadStatus?> subscribeDocument({
    required String groupId,
    required String readStatusId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readReadStatusDocumentReference(
      groupId: groupId,
      readStatusId: readStatusId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a [ReadStatus] document.
  Future<DocumentReference<ReadStatus>> add({
    required String groupId,
    required ReadStatus createReadStatus,
  }) =>
      createReadStatusCollectionReference(groupId: groupId)
          .add(createReadStatus);

  /// Sets a [ReadStatus] document.
  Future<void> set({
    required String groupId,
    required String readStatusId,
    required ReadStatus createReadStatus,
    SetOptions? options,
  }) =>
      createReadStatusDocumentReference(
        groupId: groupId,
        readStatusId: readStatusId,
      ).set(createReadStatus, options);

  /// Updates a specific [ReadStatus] document.
  Future<void> update({
    required String groupId,
    required String readStatusId,
    required ReadStatus updateReadStatus,
  }) =>
      updateReadStatusDocumentReference(
        groupId: groupId,
        readStatusId: readStatusId,
      ).update(updateReadStatus.toJson());

  /// Deletes a specific [ReadStatus] document.
  Future<void> delete({
    required String groupId,
    required String readStatusId,
  }) =>
      deleteReadStatusDocumentReference(
        groupId: groupId,
        readStatusId: readStatusId,
      ).delete();
}
