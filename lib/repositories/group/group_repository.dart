import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/utils/failure_type_defs.dart';
import 'package:graduate_app/utils/firestore_refs.dart';
import 'package:graduate_app/utils/firestore_refs/group_message_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupRepositoryProvider = Provider((ref) {
  return GroupRepository(firestore: ref.watch(firestoreProvider));
});

class GroupRepository {
  final FirebaseFirestore _firestore;
  GroupRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final _query = GroupMessageQuery();

  Stream<List<GroupModel>> searchGroup(String query) {
    return _groups
        .where(
          'groupName',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<GroupModel> groups = [];
      for (var group in event.docs) {
        groups.add(GroupModel.fromJson(group.data() as Map<String, dynamic>));
      }
      return groups;
    });
  }

  Stream<GroupModel> getGroupByName(String groupName) {
    return _groups
        .where('groupName', isEqualTo: groupName)
        .snapshots()
        .map((qs) {
      var doc = qs.docs.first;
      var data = doc.data() as Map<String, dynamic>;
      return GroupModel.fromJson(data);
    });
  }

  Future<String> getGroupById(String groupName) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('groups')
        .where('groupName', isEqualTo: groupName)
        .get();
    if (qs.docs.isNotEmpty) {
      return qs.docs.first.reference.id;
    } else {
      throw Exception('Group not found');
    }
  }

  //ユーザーをコミュニティに参加させたり、コミュニティから退出させたりします。
  FutureVoid joinGroup(String groupName, String userId) async {
    String docId = await getGroupById(groupName);
    try {
      return right(_groups.doc(docId).update({
        'members': FieldValue.arrayUnion([userId]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //ユーザーをコミュニティに参加させたり、コミュニティから退出させたりします。
  FutureVoid leaveGroup(String groupName, String userId) async {
    String docId = await getGroupById(groupName);
    try {
      return right(_groups.doc(docId).update({
        'members': FieldValue.arrayRemove([userId]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<void> sendAllGroup({
    required String userId,
    required MessageType messageType,
    String? content,
  }) =>
      _query.sendAllGroup(
        userId: userId,
        allGroupMessage: CreateGroupMessage(
          senderId: userId,
          messageType: messageType,
          content: content,
        ),
      );

  CollectionReference get _groups =>
      _firestore.collection(FirebaseConstants.groupsCollection);
}
