import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/utils/firestore_refs.dart';
import 'package:graduate_app/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'group_repository.dart';

final groupRepositoryImplProvider = Provider<GroupRepositoryImpl>(
  (ref) => GroupRepositoryImpl(),
);

class GroupRepositoryImpl implements GroupRepository {
  @override
  Future<GroupModel?> fetchGroup({
    required String groupId,
  }) async {
    final ds = await groupRef(groupId: groupId).get();

    if (!ds.exists) {
      logger.warning("Document not found: ${ds.reference.path}");
      return null;
    }

    return ds.data();
  }

  @override
  Stream<List<GroupModel>> subscribeGroups({
    Query<GroupModel>? Function(Query<GroupModel> query)? queryBuilder,
    int Function(GroupModel lhs, GroupModel rhs)? compare,
  }) {
    Query<GroupModel> query = groupsRef;

    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }

    return query.snapshots().map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();

      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }

  @override
  Future<void> createGroup({
    required GroupModel group,
  }) async {
    await groupsRef.add(group);
  }
}
