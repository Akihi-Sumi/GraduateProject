import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/models.dart';

final _db = FirebaseFirestore.instance;

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

/// message コレクションの参照
CollectionReference<Message> messagesRef({
  required String userId,
}) =>
    appUserRef(userId: userId).collection('messages').withConverter(
          fromFirestore: (ds, _) => Message.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// message ドキュメントの参照
DocumentReference<Message> messageRef({
  required String userId,
  required String messageId,
}) =>
    messagesRef(userId: userId).doc(messageId);

/// deletedUsers コレクションの参照。
final deletedUsersRef = _db.collection('deletedUsers').withConverter(
      fromFirestore: (ds, _) => DeletedUser.fromDocumentSnapshot(ds),
      toFirestore: (obj, _) => obj.toJson(),
    );
