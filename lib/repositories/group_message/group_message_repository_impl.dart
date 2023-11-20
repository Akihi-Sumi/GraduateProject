import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/utils/firestore_refs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class GroupMessageRepository {
  Future<void> sendMessageAllGroup({
    required Message groupMessage,
    required String userId,
  });
}

final groupMessageRepositoryImplProvider = Provider<GroupMessageRepositoryImpl>(
  (ref) => GroupMessageRepositoryImpl(),
);

class GroupMessageRepositoryImpl implements GroupMessageRepository {
  @override
  Future<void> sendMessageAllGroup({
    required Message groupMessage,
    required String userId,
  }) async {
    final groupDocs =
        await groupsRef.where("members", arrayContains: userId).get();

    for (final groupDoc in groupDocs.docs) {
      final groupMessagesRef = groupDoc.reference.collection('groupMessages');
      groupMessagesRef.add(groupMessage.toJson());
    }
  }
}
