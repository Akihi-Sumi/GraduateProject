import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/repositories/group.dart';
import 'package:graduate_app/repositories/group/group_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupsProvider = FutureProvider.family.autoDispose<GroupModel?, String>(
  (ref, groupId) =>
      ref.watch(groupRepositoryImplProvider).fetchGroup(groupId: groupId),
);

final groupsStreamProvider =
    StreamProvider.autoDispose<List<GroupModel>>((ref) {
  final groups = ref.read(groupRepositoryImplProvider).subscribeGroups(
        queryBuilder: (q) => q.orderBy('updatedAt', descending: true),
      );
  return groups;
});

///
///
final groupFutureProvider = FutureProvider.family
    .autoDispose<GroupModel?, String>((ref, groupId) =>
        ref.watch(groupRepositoryProvider).fetchGroup(groupId: groupId));

// class GroupNotifier extends StateNotifier<GroupState> {
//   final String _groupId;
//   final GroupMessageRepository _groupMessageRepository;

//   Future<void> sendAllMessage({
//     required String senderId,
//     required String content,
//     required DateTime createdAt,
//   }) {
//     return _groupMessageRepository.addGroupMessage(
//       groupId: _groupId,
//       senderId: senderId,
//       content: content,
//       createdAt: createdAt,
//     );
//   }
// }
