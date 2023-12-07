import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/app_user/app_user.dart';
import 'package:graduate_app/models/user/user_model.dart';

final _db = FirebaseFirestore.instance.collection('appUsers');

/// Provides a reference to the Users collection for reading.
final readUserCollectionReference = _db.withConverter<AppUser>(
  fromFirestore: (ds, _) => AppUser.fromDocumentSnapshot(ds),
  toFirestore: (_, __) => throw UnimplementedError(),
);

/// Provides a reference to a User document for reading.
DocumentReference<AppUser> readUserDocumentReference({
  required String userId,
}) =>
    readUserCollectionReference.doc(userId);

/// Provides a reference to the Users collection for creating.
final createUserCollectionReference = _db.withConverter<AppUser>(
  fromFirestore: (_, __) => throw UnimplementedError(),
  toFirestore: (obj, _) => obj.toJson(),
);

/// Provides a reference to a User document for creating.
DocumentReference<AppUser> createUserDocumentReference({
  required String userId,
}) =>
    createUserCollectionReference.doc(userId);

/// Provides a reference to the Users collection for updating.
final updateUserCollectionReference = _db.withConverter<UpdateUser>(
  fromFirestore: (_, __) => throw UnimplementedError(),
  toFirestore: (obj, _) => obj.toJson(),
);

/// Provides a reference to a User document for updating.
DocumentReference<UpdateUser> updateUserDocumentReference({
  required String userId,
}) =>
    updateUserCollectionReference.doc(userId);

/// Provides a reference to the Users collection for deleting.
final deleteUserCollectionReference = _db.withConverter<AppUser>(
  fromFirestore: (_, __) => throw UnimplementedError(),
  toFirestore: (_, __) => throw UnimplementedError(),
);

/// Provides a reference to a User document for deleting.
DocumentReference<AppUser> deleteUserDocumentReference({
  required String userId,
}) =>
    deleteUserCollectionReference.doc(userId);

/// Maneges queries against the users collections.
class UserQuery {
  Future<List<AppUser>> fetchDocuments({
    GetOptions? options,
    Query<AppUser>? Function(Query<AppUser> query)? queryBuilder,
    int Function(AppUser lhs, AppUser rhs)? compare,
  }) async {
    Query<AppUser> query = readUserCollectionReference;
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

  /// Subscribes [User] documents.
  Stream<List<AppUser>> subscribeDocuments({
    Query<AppUser>? Function(Query<AppUser> query)? queryBuilder,
    int Function(AppUser lhs, AppUser rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    Query<AppUser> query = readUserCollectionReference;
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

  /// Fetches a specific [AppUser] document.
  Future<AppUser?> fetchDocument({
    required String userId,
    GetOptions? options,
  }) async {
    final ds = await readUserDocumentReference(
      userId: userId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes a specific [User] document.
  Stream<AppUser?> subscribeDocument({
    required String userId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readUserDocumentReference(
      userId: userId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a [User] document.
  Future<DocumentReference<AppUser>> add({
    required AppUser createUser,
  }) =>
      createUserCollectionReference.add(createUser);

  /// Sets a [User] document.
  Future<void> set({
    required String userId,
    required AppUser createUser,
    SetOptions? options,
  }) =>
      createUserDocumentReference(
        userId: userId,
      ).set(createUser, options);

  /// Updates a specific [User] document.
  Future<void> update({
    required String userId,
    required UpdateUser updateUser,
  }) =>
      updateUserDocumentReference(
        userId: userId,
      ).update(updateUser.toJson());

  /// Deletes a specific [User] document.
  Future<void> delete({
    required String userId,
  }) =>
      deleteUserDocumentReference(
        userId: userId,
      ).delete();
}
