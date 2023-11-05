import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/app_user/app_user.dart';
import 'package:graduate_app/models/deleted_user/deleted_user.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _db = FirebaseFirestore.instance;

final firestoreProvider = Provider((ref) => _db);

/// appUsers コレクションの参照。
final appUsersRef = _db.collection('appUsers').withConverter(
      fromFirestore: (ds, _) => AppUser.fromDocumentSnapshot(ds),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// appUser ドキュメントの参照。
DocumentReference<AppUser> appUserRef({
  required String userId,
}) =>
    appUsersRef.doc(userId);

/// deletedUsers コレクションの参照。
final deletedUsersRef = _db.collection('deletedUsers').withConverter(
      fromFirestore: (ds, _) => DeletedUser.fromDocumentSnapshot(ds),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// message コレクションの参照
CollectionReference<Message> messagesRef({
  required String userId,
}) =>
    appUserRef(userId: userId).collection('message').withConverter(
          fromFirestore: (ds, _) => Message.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// message ドキュメントの参照
DocumentReference<Message> messageRef({
  required String userId,
  required String messageId,
}) =>
    messagesRef(userId: userId).doc(messageId);

class FirebaseConstants {
  //static const usersCollection = 'users';
  static const groupsCollection = 'groups';
  static const groupMessagesCollection = 'messages';
  //static const commentsCollection = 'comments';
}

/// groupコレクション
final groupsRef = _db.collection('groups').withConverter(
      fromFirestore: (ds, _) => GroupModel.fromDocumentSnapshot(ds),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// groupドキュメント
DocumentReference<GroupModel> groupRef({
  required String groupId,
}) =>
    groupsRef.doc(groupId);

/// groupMessagesコレクション
CollectionReference<Message> groupMessagesRef({
  required String groupId,
}) =>
    groupRef(groupId: groupId).collection('groupMessages').withConverter(
          fromFirestore: (ds, _) => Message.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// groupMessageドキュメント
DocumentReference<Message> groupMessageRef({
  required String groupId,
  required String messageId,
}) =>
    groupMessagesRef(groupId: groupId).doc(messageId);
