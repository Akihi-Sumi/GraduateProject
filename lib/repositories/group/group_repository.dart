import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduate_app/models/group/group_model.dart';

abstract class GroupRepository {
  Future<GroupModel?> fetchGroup({
    required String groupId,
  });

  Stream<List<GroupModel>> subscribeGroups({
    Query<GroupModel>? Function(Query<GroupModel> query)? queryBuilder,
    int Function(GroupModel lhs, GroupModel rhs)? compare,
  });

  Future<void> createGroup({
    required GroupModel group,
  });

  Future<void> joinGroup({
    required String groupId,
    required String userId,
  });

  Future<void> leaveGroup({
    required String groupId,
    required String userId,
  });
}
