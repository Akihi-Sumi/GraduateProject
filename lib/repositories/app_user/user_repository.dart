import 'package:graduate_app/models/app_user/app_user.dart';
import 'package:graduate_app/models/user/user_model.dart';
import 'package:graduate_app/utils/firestore_refs/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userRepositoryProvider = Provider.autoDispose<UserRepository>(
  (_) => UserRepository(),
);

class UserRepository {
  final _query = UserQuery();

  Stream<AppUser?> subscribeUser({required String userId}) =>
      _query.subscribeDocument(userId: userId);

  Future<AppUser?> fetchUser({required String userId}) =>
      _query.fetchDocument(userId: userId);

  Future<void> update({
    required String userId,
    String? userName,
    String? userEmail,
    String? userEvacuation,
    //String? introducrtion,
    String? profilePicture,
  }) =>
      _query.update(
        userId: userId,
        updateUser: UpdateUser(
          userName: userName,
          userEmail: userEmail,
          userEvacuation: userEvacuation,
          profilePicture: profilePicture,
        ),
      );
}
