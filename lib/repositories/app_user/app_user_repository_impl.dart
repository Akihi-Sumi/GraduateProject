import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/app_user/app_user.dart';
import 'package:graduate_app/models/deleted_user/deleted_user.dart';
import 'package:graduate_app/utils/firestore_refs.dart';
import 'package:graduate_app/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_user_repository.dart';

final appUserRepositoryImplProvider = Provider<AppUserRepository>(
  (ref) => AppUserRepositoryImpl(),
);

class AppUserRepositoryImpl implements AppUserRepository {
  /// 指定した userId のユーザーを `SetOptions(merge: true)` で作成する。
  @override
  Future<void> create({
    required String userId,
    required AppUser appUser,
  }) async {
    await appUserRef(userId: userId).set(
      appUser,
      SetOptions(merge: true),
    );
  }

  Future<AppUser?> fetchAppUser({
    required String userId,
  }) async {
    return null;
  }

  @override
  Future<void> delete({required DeletedUser deletedUser}) async {
    await deletedUsersRef.doc(deletedUser.uid).set(deletedUser);
  }

  @override
  Future<AppUser?> fetch({required String userId}) async {
    final ds = await appUserRef(userId: userId).get();
    if (!ds.exists) {
      logger.warning('Document not found: ${ds.reference.path}');
      return null;
    }
    return ds.data()!;
  }

  @override
  Future<void> update({required String userId, required AppUser appUser}) {
    throw UnimplementedError();
  }
}
