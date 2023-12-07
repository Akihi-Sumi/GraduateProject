import 'dart:async';
import 'dart:io';

import 'package:graduate_app/controller/group.dart';
import 'package:graduate_app/repositories/group_message/group_message_repository_impl.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:graduate_app/utils/firebase_storage.dart';
import 'package:graduate_app/utils/firestore_refs/group_message_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sendMessageAllGroupControllerProvider =
    AutoDisposeAsyncNotifierProvider<SendMessageController, void>(
  SendMessageController.new,
);

final sendAllGroupControllerProvider = Provider.family
    .autoDispose<SendImageAllGroupController, String>((ref, userId) {
  return SendImageAllGroupController(
    userId: userId,
    groupService: ref.watch(groupServiceProvider),
    storageService: ref.watch(firebaseStorageServiceProvider),
  );
});

class SendMessageController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> sendMessageAllGroup({
    required CreateGroupMessage groupMessage,
    required String userId,
  }) async {
    final groupMessageRepo = ref.read(groupMessageRepositoryImplProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        await groupMessageRepo.sendMessageAllGroup(
          groupMessage: groupMessage,
          userId: userId,
        );
      } on AppException {
        rethrow;
      }
    });
  }
}

class SendImageAllGroupController {
  SendImageAllGroupController({
    required String userId,
    required FirebaseStorageService storageService,
    required GroupService groupService,
  })  : _userId = userId,
        _storageService = storageService,
        _groupService = groupService;

  final String _userId;
  final FirebaseStorageService _storageService;
  final GroupService _groupService;

  static const _storagePath = 'groups';

  Future<void> sendAllGroup({
    required String userId,
    String? content,
    File? picture,
  }) async {
    String? imageUrl;
    if (picture != null) {
      imageUrl = await _uploadImage(picture);
    }

    await _groupService.sendAllGroup(
      userId: userId,
      content: imageUrl,
    );
  }

  Future<String> _uploadImage(File picture) {
    final imagePath = '$_storagePath/$_userId+${DateTime.now()}.jpg';
    return _storageService.upload(
      path: imagePath,
      resource: FirebaseStorageFile(picture),
    );
  }
}
