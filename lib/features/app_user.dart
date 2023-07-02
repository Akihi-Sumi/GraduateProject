import 'package:graduate_app/models/models.dart';
import 'package:graduate_app/repositories/repositories.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appUserFutureProvider = FutureProvider.autoDispose<AppUser?>((ref) async {
  final userId = ref.watch(authRepositoryImplProvider).currentUser!.uid;
  final appUser =
      await ref.read(appUserRepositoryImplProvider).fetch(userId: userId);
  return appUser;
});
