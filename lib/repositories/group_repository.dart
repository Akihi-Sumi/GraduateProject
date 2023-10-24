import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/utils/failure_type_defs.dart';
import 'package:graduate_app/utils/firestore_refs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final groupRepositoryProvider = Provider((ref) {
  return GroupRepository(firestore: ref.watch(firestoreProvider));
});

class GroupRepository {
  final FirebaseFirestore _firestore;
  GroupRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //: 新しいコミュニティを作成します。同じ名前のコミュニティが既に存在する場合はエラーをスローします。
  FutureVoid createGroup(GroupModel group) async {
    try {
      //与えられたコミュニティの名前を使用して、Firestore内のドキュメントを取得
      var groupDoc = await _group.doc(group.groupName).get();
      //取得したドキュメントが既に存在する場合、同じ名前のコミュニティがすでに存在するというエラーメッセージをスロー
      if (groupDoc.exists) {
        throw 'このグループ名は既に存在します';
      }

      //Firestoreに新しいコミュニティのドキュメントを作成する操作
      return right(_group.doc(group.groupName).set(group.toJson()));
    } on FirebaseException catch (e) {
      //エラーメッセージをキャッチしてスロー
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //ユーザーをコミュニティに参加させたり、コミュニティから退出させたりします。
  FutureVoid joinGroup(String groupName, String userId) async {
    try {
      return right(_group.doc(groupName).update({
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
    try {
      return right(_group.doc(groupName).update({
        'members': FieldValue.arrayRemove([userId]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // 特定のユーザーがメンバーであるすべてのコミュニティを取得するためのストリームを提供します。
  Stream<List<GroupModel>> getUserGroups(String uid) {
    return _group.where('members', arrayContains: uid).snapshots().map((event) {
      List<GroupModel> groups = [];
      for (var doc in event.docs) {
        groups.add(GroupModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      return groups;
    });
  }

  // コミュニティの名前を指定して、そのコミュニティの詳細を取得するためのストリームを提供します。
  Stream<GroupModel> getGroupByName(String name) {
    return _group.doc(name).snapshots().map(
        (event) => GroupModel.fromJson(event.data() as Map<String, dynamic>));
  }

  // コミュニティの情報を編集します。
  FutureVoid editGroup(GroupModel group) async {
    try {
      return right(_group.doc(group.groupName).update(group.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //指定したクエリに基づいてコミュニティを検索するためのストリームを提供します。
  Stream<List<GroupModel>> searchGroup(String query) {
    return _group
        .where(
          'name',
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

  // コミュニティのモデレータを追加します。
  FutureVoid addMods(String groupName, List<String> uids) async {
    try {
      return right(_group.doc(groupName).update({
        'mods': uids,
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //特定のコミュニティに関連する投稿を取得するためのストリームを提供します。
  Stream<List<Message>> getGroupMessages(String name) {
    return _messages
        .where('groupName', isEqualTo: name)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Message.fromJson(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  //_posts: 投稿データを保存するFirestoreのコレクションへの参照を取得します。
  //_group: コミュニティデータを保存するFirestoreのコレクションへの参照を取得します。
  CollectionReference get _messages =>
      _firestore.collection(FirebaseConstants.groupMessagesCollection);
  CollectionReference get _group =>
      _firestore.collection(FirebaseConstants.groupsCollection);
}
