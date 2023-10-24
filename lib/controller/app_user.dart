import 'package:graduate_app/models/app_user/app_user.dart';
import 'package:graduate_app/repositories/app_user/app_user_repository_impl.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appUserFutureProvider = FutureProvider.autoDispose<AppUser?>((ref) async {
  final userId = ref.watch(authRepositoryImplProvider).currentUser!.uid;
  final appUser =
      await ref.watch(appUserRepositoryImplProvider).fetch(userId: userId);
  return appUser;
});

final userProvider = StateProvider<AppUser?>((ref) => null);
