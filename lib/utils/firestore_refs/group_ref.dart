import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/group/group_model.dart';

final _db =
    FirebaseFirestore.instance.collection('groups').withConverter<GroupModel>;

final readGroupCollectionReference = _db(
  fromFirestore: (ds, _) => GroupModel.fromDocumentSnapshot(ds),
  toFirestore: (_, __) => throw UnimplementedError(),
);

DocumentReference<GroupModel> readGroupDocumentReference({
  required String groupId,
}) =>
    readGroupCollectionReference.doc(groupId);

final createGroupCollectionReference = _db(
  fromFirestore: (_, __) => throw UnimplementedError(),
  toFirestore: (obj, _) => obj.toJson(),
);

DocumentReference<GroupModel> createGroupDocumentReference({
  required String groupId,
}) =>
    createGroupCollectionReference.doc(groupId);

final updateGroupCollectionReference = _db(
  fromFirestore: (_, __) => throw UnimplementedError(),
  toFirestore: (obj, _) => obj.toJson(),
);

DocumentReference<GroupModel> updateGroupDocumentReference({
  required String groupId,
}) =>
    updateGroupCollectionReference.doc(groupId);

final deleteGroupCollectionReference = _db(
  fromFirestore: (_, __) => throw UnimplementedError(),
  toFirestore: (_, __) => throw UnimplementedError(),
);

DocumentReference<GroupModel> deleteGroupDocumentReference({
  required String groupId,
}) =>
    deleteGroupCollectionReference.doc(groupId);

class GroupQuery {
  Future<List<GroupModel>> fetchDocuments({
    GetOptions? options,
    Query<GroupModel>? Function(Query<GroupModel> query)? queryBuilder,
    int Function(GroupModel lhs, GroupModel rhs)? compare,
  }) async {
    Query<GroupModel> query = readGroupCollectionReference;

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

  Stream<List<GroupModel>> subscribeDocuments({
    Query<GroupModel>? Function(Query<GroupModel> query)? queryBuilder,
    int Function(GroupModel lhs, GroupModel rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<GroupModel> query = readGroupCollectionReference;
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

  /// Fetches a specific [GroupModel] document.
  Future<GroupModel?> fetchDocument({
    required String groupId,
    GetOptions? options,
  }) async {
    final ds = await readGroupDocumentReference(
      groupId: groupId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes a specific [GroupModel] document.
  Stream<GroupModel?> subscribeDocument({
    required String groupId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readGroupDocumentReference(
      groupId: groupId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a [GroupModel] document.
  Future<DocumentReference<GroupModel>> add({
    required GroupModel createGroup,
  }) =>
      createGroupCollectionReference.add(createGroup);

  /// Sets a [GroupModel] document.
  Future<void> set({
    required String groupId,
    required GroupModel createGroup,
    SetOptions? options,
  }) =>
      createGroupDocumentReference(
        groupId: groupId,
      ).set(createGroup, options);

  /// Updates a specific [GroupModel] document.
  Future<void> update({
    required String groupId,
    required GroupModel updateGroup,
  }) =>
      updateGroupDocumentReference(
        groupId: groupId,
      ).update(updateGroup.toJson());

  /// Deletes a specific [GroupModel] document.
  Future<void> delete({
    required String groupId,
  }) =>
      deleteGroupDocumentReference(
        groupId: groupId,
      ).delete();
}
