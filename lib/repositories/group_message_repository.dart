import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/utils/failure_type_defs.dart';
import 'package:graduate_app/utils/firestore_refs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupMessageRepositoryProvider = Provider((ref) {
  return GroupMessageRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class GroupMessageRepository {
  final FirebaseFirestore _firestore;

  GroupMessageRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _groupMessage =>
      _firestore.collection(FirebaseConstants.groupMessagesCollection);

  FutureVoid addGroupMessage(Message message) async {
    try {
      return right(_groupMessage.doc(message.messageId).set(message.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Message>> fetchUserGroupMessages(List<GroupModel> groups) {
    return _groupMessage
        .where('groupName', whereIn: groups.map((e) => e.groupName).toList())
        .orderBy('createAt', descending: true)
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

  Stream<Message> getGroupMessageById(String messageId) {
    return _groupMessage.doc(messageId).snapshots().map(
          (event) => Message.fromJson(
            event.data() as Map<String, dynamic>,
          ),
        );
  }

  //FutureVoid deleteGroupMessage(Message message) async {}
}
