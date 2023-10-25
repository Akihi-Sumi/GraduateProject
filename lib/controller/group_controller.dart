import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/models/post/group_model.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/repositories/group_repository.dart';
import 'package:graduate_app/utils/failure_type_defs.dart';
import 'package:graduate_app/widgets/show_snack_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//final userProvider = StateProvider<AppUser?>((ref) => null);

Future<String?> fetchUserData() async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final userId = firebaseAuth.currentUser?.uid ?? '';

  return userId;
}

final userIdProvider = Provider<String>((ref) {
  final authRepository = ref.watch(authRepositoryImplProvider);
  final currentUser = authRepository.currentUser;
  if (currentUser != null) {
    return currentUser.uid;
  } else {
    // ユーザーがログインしていない場合のデフォルト値を返す（例: 空の文字列）
    return '';
  }
});

final userGroupsProvider = StreamProvider((ref) {
  final groupController = ref.watch(groupControllerProvider.notifier);
  return groupController.getUserGroups();
});

final groupControllerProvider =
    StateNotifierProvider<GroupController, bool>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);
  //final storageRepository = ref.watch(storageRepositoryProvider);

  return GroupController(
    groupRepository: groupRepository,
    //storageRepository: storageRepository,
    ref: ref,
  );
});

final getGroupByNameProvider = StreamProvider.family((ref, String groupName) {
  return ref.watch(groupControllerProvider.notifier).getGroupByName(groupName);
});

final searchGroupProvider = StreamProvider.family((ref, String query) {
  return ref.watch(groupControllerProvider.notifier).searchGroup(query);
});

final getGroupMessageProvider = StreamProvider.family((ref, String groupName) {
  return ref.read(groupControllerProvider.notifier).getGroupMessages(groupName);
});

class GroupController extends StateNotifier<bool> {
  final GroupRepository _groupRepository;
  final Ref _ref;
  //final StorageRepository _storageRepository;

  GroupController({
    required GroupRepository groupRepository,
    required Ref ref,
    //required StorageRepository storageRepository,
  })  : _groupRepository = groupRepository,
        _ref = ref,
        //_storageRepository = storageRepository,
        super(false);

  //新しいコミュニティを作成するメソッド
  void createGroup(String groupName, BuildContext context) async {
    state = true; // プログラムの状態をtrueに設定（おそらく非同期処理の進行状況を示すためのフラグ）

    // 現在のユーザーのUIDを取得。_ref.read(userProvider)はユーザープロバイダーからユーザー情報を取得する操作を行っていると仮定します。
    final uid = (await fetchUserData()).toString();

    // 新しいCommunityオブジェクトを作成。コミュニティの情報を表現します。
    GroupModel2 group = GroupModel2(
      groupId: groupName, // id、nameは引数から受け取ったコミュニティの名前です。
      groupName: groupName,
      // banner: Constants.bannerDefault,
      // avatar: Constants.avatarDefault,
      // membersとmodsには、コミュニティを作成したユーザーのUIDが含まれています。
      members: [uid], // メンバーリストにユーザーのUIDを追加
      mods: [uid], // モデレーターリストにユーザーのUIDを追加
    );

    //関数を呼び出して、コミュニティの作成を待ちます。
    //作成が完了すると、結果が変数resに格納されます。
    final res = await _groupRepository.createGroup(group);
    state = false;
    //resの結果をfoldメソッドを使用して処理
    res.fold(
      //エラーがある場合（関数が呼び出される）、
      //showSnackBar関数を使用してエラーメッセージを表示
      (l) => showSnackBar(context, l.message),
      //成功した場合（関数が呼び出される）
      //成功メッセージを表示
      (r) {
        showSnackBar(context, 'グループを作成しました');
      },
    );
  }

  // ユーザーがコミュニティに参加または退会するメソッド
  void joinGroup(GroupModel2 group, BuildContext context) async {
    //final user = _ref.read(userProvider)!;//現在のユーザーオブジェクトを取得
    final uid = _ref.watch(userIdProvider);

    Either<Failure, void> res;
    //コミュニティのメンバーリストにユーザーIDが含まれているかどうかを確認
    if (group.members.contains(uid)) {
      //脱退
      res = await _groupRepository.leaveGroup(group.groupName, uid);
    } else {
      //参加
      res = await _groupRepository.joinGroup(group.groupName, uid);
    }

    res.fold((l) => showSnackBar(context, l.message), (r) {
      if (group.members.contains(uid)) {
        showSnackBar(context, 'グループを抜けました');
      } else {
        showSnackBar(context, 'グループに参加しました');
      }
    });
  }

  //ユーザーが参加しているコミュニティのリストを提供する非同期ストリームを取得
  Stream<List<GroupModel2>> getUserGroups() {
    final uid = _ref.read(userProvider)!.userId;
    return _groupRepository.getUserGroups(uid);
  }

  // コミュニティ名を指定して対応するコミュニティを提供する非同期ストリームを取得します
  Stream<GroupModel2> getGroupByName(String groupName) {
    return _groupRepository.getGroupByName(groupName);
  }

  //指定した検索クエリに一致するコミュニティのリストを提供
  Stream<List<GroupModel2>> searchGroup(String query) {
    return _groupRepository.searchGroup(query);
  }

  //指定したコミュニティ名に関連する投稿のリストを提供
  Stream<List<Message>> getGroupMessages(String groupName) {
    return _groupRepository.getGroupMessages(groupName);
  }
}
