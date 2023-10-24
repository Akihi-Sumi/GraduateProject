import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/models/models.dart';
import 'package:graduate_app/repositories/repositories.dart';
import 'package:graduate_app/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 削除アカウントの作成後、Firebase Auth を用いてサインアウトをする [AsyncNotifierProvider]。
final deleteAccountControllerProvider =
    AutoDisposeAsyncNotifierProvider<DeleteAccountController, void>(
  DeleteAccountController.new,
);

class DeleteAccountController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> deleteAccount() async {
    final userId = ref.watch(authRepositoryImplProvider).currentUser!.uid;
    final authRepository = ref.read(authRepositoryImplProvider);
    final appUserRepository = ref.read(appUserRepositoryImplProvider);

    final deletedUser = DeletedUser(
      uid: userId,
      createdAt: const UnionTimestamp.serverTimestamp(),
    );

    // ローディング中にする
    state = const AsyncLoading();

    // 削除アカウントの作成とサインアウト処理を実行する
    state = await AsyncValue.guard(() async {
      try {
        await appUserRepository.delete(deletedUser: deletedUser);
        await authRepository.signOut();
      } on FirebaseAuthException catch (e) {
        final exception = AppException(
          code: e.code,
          message: e.toJapanese,
        );
        debugPrint(e.code);
        throw exception;
      }
    });
  }
}
