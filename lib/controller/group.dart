import 'dart:async';

import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/repositories/group/group_repository_impl.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupsProvider = StreamProvider.autoDispose<List<GroupModel>>((ref) {
  final groups = ref.read(groupRepositoryImplProvider).subscribeGroups(
        queryBuilder: (q) => q.orderBy('createdAt', descending: true),
      );
  return groups;
});

final createGroupControllerProvider =
    AutoDisposeAsyncNotifierProvider<CreateGroupController, void>(
  CreateGroupController.new,
);

class CreateGroupController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> createGroup({
    required GroupModel group,
  }) async {
    final groupRepository = ref.read(groupRepositoryImplProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        if (group.groupName.isEmpty) {
          throw const AppException(
            message: "グループ名を入力してください",
          );
        }
        await groupRepository.createGroup(group: group);
      } on AppException {
        rethrow;
      }
    });
  }
}
