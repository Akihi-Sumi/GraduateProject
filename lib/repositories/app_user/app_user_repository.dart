import 'package:graduate_app/models/app_user/app_user.dart';
import 'package:graduate_app/models/deleted_user/deleted_user.dart';

abstract class AppUserRepository {
  Future<void> create({
    required String userId,
    required AppUser appUser,
  });

  Future<AppUser?> fetch({required String userId});

  Future<void> update({
    required String userId,
    required AppUser appUser,
  });

  Future<void> delete({required DeletedUser deletedUser});
}
