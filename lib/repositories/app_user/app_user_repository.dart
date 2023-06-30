import 'package:graduate_app/models/models.dart';

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
