import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/utils/firestore_refs/group_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupRepositoryProvider =
    Provider.autoDispose<GroupRepository>((_) => GroupRepository());

class GroupRepository {
  final _query = GroupQuery();

  Future<GroupModel?> fetchGroup({required String groupId}) {
    return _query.fetchDocument(groupId: groupId);
  }

  Stream<List<GroupModel>> subscribeGroups({required String userId}) {
    return _query.subscribeDocuments(
      queryBuilder: (query) => query
          .where('members', arrayContains: userId)
          .orderBy('updatedAt', descending: true),
    );
  }

  Future<String> createGroup({required GroupModel group}) async {
    final documentReference = await _query.add(createGroup: group);
    return documentReference.id;
  }
}
