import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:graduate_app/controllers/auth.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/repositories/group/group_repository.dart';
import 'package:graduate_app/utils/failure_type_defs.dart';
import 'package:graduate_app/widgets/show_snack_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///
///
// final groupFutureProvider = FutureProvider.family
//     .autoDispose<GroupModel?, String>((ref, groupId) =>
//         ref.watch(groupRepositoryProvider).fetchGroup(groupId: groupId));

final groupControllerProvider =
    StateNotifierProvider<GroupController, bool>((ref) {
  final groupRepository = ref.watch(groupRepositoryProvider);

  return GroupController(
    groupRepository: groupRepository,
    ref: ref,
  );
});

final searchGroupProvider = StreamProvider.family((ref, String query) {
  return ref.watch(groupControllerProvider.notifier).searchGroup(query);
});

final getGroupByNameProvider = StreamProvider.family((ref, String groupName) {
  return ref.watch(groupControllerProvider.notifier).getGroupByName(groupName);
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

  //指定した検索クエリに一致するコミュニティのリストを提供
  Stream<List<GroupModel>> searchGroup(String query) {
    return _groupRepository.searchGroup(query);
  }

  Stream<GroupModel> getGroupByName(String groupName) {
    return _groupRepository.getGroupByName(groupName);
  }

  // ユーザーがコミュニティに参加または退会するメソッド
  void joinOrLeaveGroup(GroupModel group, BuildContext context) async {
    //final user = _ref.read(userProvider)!;//現在のユーザーオブジェクトを取得
    final uid = _ref.watch(userIdProvider);

    Either<Failure, void> res;
    //コミュニティのメンバーリストにユーザーIDが含まれているかどうかを確認
    if (group.members.contains(uid)) {
      //脱退
      res = await _groupRepository.leaveGroup(group.groupName, uid ?? '');
    } else {
      //参加
      res = await _groupRepository.joinGroup(group.groupName, uid ?? '');
    }

    res.fold((l) => showSnackBar(context, l.message), (r) {
      if (group.members.contains(uid)) {
        showSnackBar(context, 'グループを抜けました');
      } else {
        showSnackBar(context, 'グループに参加しました');
      }
    });
  }
}
