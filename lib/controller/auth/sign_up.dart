import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/models/app_user/app_user.dart';
import 'package:graduate_app/page/settings/survival_kits/add_item_page.dart';
import 'package:graduate_app/repositories/app_user/app_user_repository_impl.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:graduate_app/utils/extensions/firebase_auth_exception.dart';
import 'package:graduate_app/utils/json_converters/union_timestamp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Firebase Auth を用いてサインアップをする [AsyncNotifierProvider]。
final signUpControllerProvider =
    AutoDisposeAsyncNotifierProvider<SignUpController, void>(
  SignUpController.new,
);

class SignUpController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // FutureOr<void> より、初期の処理の必要がないため何もしない。
    // Do nothing since the return type is void.
  }

  /// サインアップする
  Future<void> signUp({
    required bool isCheckTerms,
    required String userName,
    required String email,
    required String password,
  }) async {
    final authRepository = ref.read(authRepositoryImplProvider);
    final appUserRepository = ref.read(appUserRepositoryImplProvider);
    // サインアップをローディング中にする
    state = const AsyncLoading();

    // サインアップを実行する
    state = await AsyncValue.guard(() async {
      try {
        if (isCheckTerms == false) {
          const exception = AppException(
            message: '利用規約とプライバシーポリシーに同意してください。',
          );
          throw exception;
        }

        if (userName.isEmpty || email.isEmpty || password.isEmpty) {
          const exception = AppException(
            message: 'ユーザー名、メールアドレス、パスワードを入力してください。',
          );
          throw exception;
        }

        final userId = await authRepository.signUp(
          email: email,
          password: password,
        );
        if (userId != null) {
          final appUser = AppUser(
            userId: userId,
            userName: userName,
            userEmail: email,
            createdAt: const UnionTimestamp.serverTimestamp(),
          );

          await appUserRepository.create(userId: userId, appUser: appUser);

          // サブコレクション
          final survivalCollection = FirebaseFirestore.instance
              .collection('appUsers')
              .doc(userId)
              .collection('survivalKits');
          await survivalCollection.doc('listData').set({'list': _list});
        } else {
          const exception = AppException(
            message: "アカウントの作成に失敗しました。",
          );
          throw exception;
        }
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

  List<Map> _list = [
    {
      "expirationDate": "保存期限なし",
      "name": "応急セット",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": AddItemPage.nowData(),
      "name": "長期保存水",
      "time": 10,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "緊急用呼口笛",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": AddItemPage.nowData(),
      "name": "缶詰、備蓄パン",
      "time": 5,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "レジャーシート",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "食品加熱袋、加熱材",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "防災折り畳みヘルメット",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "ウェットボディタオル",
      "time": 0,
      "isChecked": false
    },
    {"expirationDate": "保存期限なし", "name": "歯ブラシ", "time": 0, "isChecked": false},
    {
      "expirationDate": "保存期限なし",
      "name": "非常用簡易トイレ",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "布ガムテープ",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "アルミブランケット、アルミシート",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "レインコート",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "アルコール除菌ジェル",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "非常用カイロ",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "マルチツール",
      "time": 0,
      "isChecked": false
    },
    {"expirationDate": "保存期限なし", "name": "乾電池", "time": 0, "isChecked": false},
    {
      "expirationDate": "保存期限なし",
      "name": "エアーピロー",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "三角巾、ガーゼ",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "折り畳み式スリッパ",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "緊急用連絡シート",
      "time": 0,
      "isChecked": false
    },
    {
      "expirationDate": "保存期限なし",
      "name": "非常用給水袋",
      "time": 0,
      "isChecked": false
    },
    {"expirationDate": "保存期限なし", "name": "マスク", "time": 0, "isChecked": false},
    {
      "expirationDate": "保存期限なし",
      "name": "ドライシャンプー",
      "time": 3,
      "isChecked": false
    },
  ];
}
