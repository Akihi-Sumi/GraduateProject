import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:graduate_app/models/app_user/app_user.dart';
import 'package:graduate_app/utils/failure_type_defs.dart';
import 'package:graduate_app/utils/firestore_refs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileRepositoryProvider = Provider((ref) {
  return UserProfileRepository(firestore: ref.watch(firestoreProvider));
});

class UserProfileRepository {
  final FirebaseFirestore _firestore;

  UserProfileRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users => _firestore.collection('appUsers');

  FutureVoid editProfile(AppUser user) async {
    try {
      return right(_users.doc(user.userId).update(user.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
