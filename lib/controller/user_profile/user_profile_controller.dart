import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:graduate_app/controller/user_profile/user.dart';
import 'package:graduate_app/utils/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileControllerProvider =
    Provider.family.autoDispose<UserProfileController, String>((ref, userId) {
  return UserProfileController(
    userId: userId,
    userService: ref.watch(userServiceProvider),
    storageService: ref.watch(firebaseStorageServiceProvider),
  );
});

class UserProfileController {
  UserProfileController({
    required String userId,
    required UserService userService,
    required FirebaseStorageService storageService,
  })  : _userId = userId,
        _userService = userService,
        _storageService = storageService;

  final String _userId;
  final UserService _userService;
  final FirebaseStorageService _storageService;

  static const _storagePath = 'users';

  Future<void> update({
    required String userId,
    String? userName,
    String? userEmail,
    String? userEvacuation,
    File? profilePicture,
    Uint8List? profileWebPicture,
  }) async {
    String? imageUrl;

    if (kIsWeb) {
      if (profileWebPicture != null) {
        imageUrl = await _uploadWebImage(profileWebPicture);
      }
    } else if (!kIsWeb) {
      if (profilePicture != null) {
        imageUrl = await _uploadImage(profilePicture);
      }
    }

    await _userService.update(
      userId: userId,
      userName: userName,
      userEmail: userEmail,
      userEvacuation: userEvacuation,
      profilePicture: imageUrl,
    );
  }

  Future<String> _uploadImage(File profilePicture) {
    final imagePath = '$_storagePath/$_userId.jpg';
    return _storageService.upload(
      path: imagePath,
      resource: FirebaseStorageFile(profilePicture),
    );
  }

  Future<String> _uploadWebImage(Uint8List profileWebPicture) {
    final imagePath = '$_storagePath/$_userId.jpg';
    return _storageService.upload(
      path: imagePath,
      resource: FirebaseStorageRawData(profileWebPicture),
    );
  }
}
