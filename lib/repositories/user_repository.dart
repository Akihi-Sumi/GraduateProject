import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:graduate_app/models/models.dart';

class UserRepository {
  UserRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
    FirebaseMessaging? firebaseMessaging,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseMessaging _firebaseMessaging;

  static const String usersCollection = 'users';
  static const String privateInfoCollection = 'privateInfo';
  static const String publicInfoCollection = 'publicInfo';

  Future<PublicUser> readPublicUser({required String id}) async {
    try {
      final doc = await _firebaseFirestore
          .collection(usersCollection)
          .doc(id)
          .collection(publicInfoCollection)
          .doc(id)
          .get();
      return PublicUser.fromDoc(doc);
    } catch (_) {
      throw const ReadUserException();
    }
  }

  Future<void> createPublicUser({required PublicUser user}) async {
    try {
      await _firebaseFirestore
          .collection(usersCollection)
          .doc(user.id)
          .collection(publicInfoCollection)
          .doc(user.id)
          .set(user.toJson());
    } catch (_) {
      throw const CreateUserException();
    }
  }

  Future<void> createPrivateUser({required PrivateUser user}) async {
    try {
      await _firebaseFirestore
          .collection(usersCollection)
          .doc(user.id)
          .collection(privateInfoCollection)
          .doc(user.id)
          .set(user.toJson());
    } catch (_) {
      throw const CreateUserException();
    }
  }

  Future<void> saveTokenToPrivateUser() async {
    try {
      final currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        final token = await _firebaseMessaging.getToken();
        if (token == null) return;

        await _firebaseFirestore
            .collection(usersCollection)
            .doc(currentUser.uid)
            .collection(privateInfoCollection)
            .doc(currentUser.uid)
            .set(
          <String, dynamic>{
            'tokens': FieldValue.arrayUnion(<String>[token]),
          },
          SetOptions(merge: true),
        );
      }
    } catch (_) {
      throw const SaveTokenException();
    }
  }

  Future<void> removeTokenFromPrivateUser() async {
    try {
      final currentUser = _firebaseAuth.currentUser;

      if (currentUser != null) {
        final token = await _firebaseMessaging.getToken();
        if (token == null) return;

        await _firebaseFirestore
            .collection(usersCollection)
            .doc(currentUser.uid)
            .collection(privateInfoCollection)
            .doc(currentUser.uid)
            .set(
          <String, dynamic>{
            'tokens': FieldValue.arrayRemove(<String>[token]),
          },
          SetOptions(merge: true),
        );
      }
    } catch (_) {
      throw const RemoveTokenException();
    }
  }

  Future<List<PublicUser>> searchUsers({required String term}) async {
    try {
      final query = await _firebaseFirestore
          .collection(publicInfoCollection)
          .where('name', isGreaterThanOrEqualTo: term)
          .limit(10)
          .get();

      return query.docs.map(PublicUser.fromDoc).toList();
    } catch (_) {
      throw const SearchUsersException();
    }
  }
}
