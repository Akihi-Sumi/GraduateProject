import 'package:graduate_app/models/app_user/app_user.dart';
import 'package:graduate_app/repositories/app_user/user_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userStreamProvider = StreamProvider.family.autoDispose<AppUser?, String>(
  (ref, userId) =>
      ref.watch(userRepositoryProvider).subscribeUser(userId: userId),
);

final userImageProfileProvider =
    Provider.family.autoDispose<String, String>((ref, userId) {
  final user = ref.watch(userStreamProvider(userId)).valueOrNull;
  return user?.profilePicture ?? '';
});

final userNameProvider =
    Provider.family.autoDispose<String, String>((ref, userId) {
  final user = ref.watch(userStreamProvider(userId)).valueOrNull;
  return user?.userName ?? '';
});

final userFutureProvider = FutureProvider.family.autoDispose<AppUser?, String>(
  (ref, userId) => ref.watch(userServiceProvider).fetchUser(userId: userId),
);

final userServiceProvider = Provider.autoDispose<UserService>(
    (ref) => UserService(userRepository: ref.watch(userRepositoryProvider)));

class UserService {
  const UserService({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  Future<bool> userExists({required String userId}) async {
    final user = await _userRepository.fetchUser(userId: userId);
    return user != null;
  }

  Future<AppUser?> fetchUser({required String userId}) =>
      _userRepository.fetchUser(userId: userId);

  Future<void> update({
    required String userId,
    String? userName,
    String? userEmail,
    String? userEvacuation,
    String? profilePicture,
    //String?
  }) async {
    await _userRepository.update(
      userId: userId,
      userName: userName,
      userEmail: userEmail,
      userEvacuation: userEvacuation,
      profilePicture: profilePicture,
    );
  }
}
