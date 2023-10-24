import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:graduate_app/utils/extensions/firebase_auth_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sendPasswordResetEmailControllerProvider =
    AutoDisposeAsyncNotifierProvider<SendPasswordResetEmailController, void>(
  SendPasswordResetEmailController.new,
);

class SendPasswordResetEmailController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // FutureOr<void> より、初期の処理の必要がないため何もしない。
    // Do nothing since the return type is void.
  }

  /// パスワードの再設定用のメールを送信する
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    final authRepository = ref.read(authRepositoryImplProvider);
    // メールの送信をローディング中にする
    state = const AsyncLoading();

    // メールを送信する
    state = await AsyncValue.guard(() async {
      try {
        if (email.isEmpty) {
          const exception = AppException(
            message: 'Please input your email.',
          );
          throw exception;
        }
        await authRepository.sendPasswordResetEmail(email: email);
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
