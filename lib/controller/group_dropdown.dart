import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/utils/json_converters/union_timestamp.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const initGroup = GroupModel(
  groupId: 'id-unselected',
  groupName: '選択されていません',
  createdAt: UnionTimestamp.serverTimestamp(),
);

final dropdownButtonGroupProvider =
    StateNotifierProvider.autoDispose<DropdownButtonGroupNotifier, GroupModel>(
  (_) {
    return DropdownButtonGroupNotifier();
  },
);

class DropdownButtonGroupNotifier extends StateNotifier<GroupModel> {
  DropdownButtonGroupNotifier() : super(initGroup);

  void selectedGroup(GroupModel? group) {
    if (group != null) {
      state = state.copyWith(
        groupId: group.groupId,
        groupName: group.groupName,
        createdAt: group.createdAt,
      );
    }
  }
}
