import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/auth.dart';
import 'package:graduate_app/repositories/app_user/user_profile_repository.dart';
import 'package:graduate_app/repositories/storage_repository.dart';
import 'package:graduate_app/widgets/show_snack_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _db = FirebaseFirestore.instance;

final userProfileControllerProvider =
    StateNotifierProvider<UserProfileController, bool>((ref) {
  final userProfileRepository = ref.watch(userProfileRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);

  return UserProfileController(
    userProfileRepository: userProfileRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

class UserProfileController extends StateNotifier<bool> {
  //final UserProfileRepository _userProfileRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  UserProfileController({
    required UserProfileRepository userProfileRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  :
        //_userProfileRepository = userProfileRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void editUserProfile({
    required File? profileFile,
    required String userName,
    required String userEmail,
    required String userEvacuation,
    required BuildContext context,
  }) async {
    state = true;

    final userId = _ref.watch(userIdProvider);

    if (profileFile != null) {
      final res = await _storageRepository.storeFile(
        path: 'users/profile',
        id: userId ?? '',
        file: profileFile,
      );
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => _db.collection('appUsers').doc(userId).update({
          'profilePicture': r,
        }),
      );
    }

    _db.collection('appUsers').doc(userId).update({
      'userName': userName,
      'userEmail': userEmail,
      'userEvacuation': userEvacuation,
    });

    // user = user.copyWith(
    //   userName: userName,
    //   userEmail: userEmail,
    //   userEvacuation: userEvacuation,
    // );
    // final res = await _userProfileRepository.editProfile(user);
    state = false;
    // res.fold(
    //   (l) => showSnackBar(context, l.message),
    //   (r) {
    //     _ref.read(userProvider.notifier).update((state) => user);
    //   },
    // );
  }
}
