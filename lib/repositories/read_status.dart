import 'package:graduate_app/models/read_status/read_status.dart';
import 'package:graduate_app/utils/firestore_refs/read_status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final readStatusRepositoryProvider =
    Provider.autoDispose<ReadStatusRepository>((_) => ReadStatusRepository());

class ReadStatusRepository {
  final _query = ReadStatusQuery();

  /// Obtains the [ReadStatus] of the specified [chatRoomId] and [userId].
  Stream<ReadStatus?> subscribeReadStatus({
    required String groupId,
    required String userId,
  }) {
    return _query.subscribeDocument(
      groupId: groupId,
      readStatusId: userId,
    );
  }

  /// Update [ReadStatus] of the specified [chatRoomId] and [userId] with the current server time.
  Future<void> setLastReadAt({
    required String groupId,
    required String userId,
  }) {
    return _query.set(
      groupId: groupId,
      readStatusId: userId,
      createReadStatus: ReadStatus(lastReadAt: DateTime.now()),
    );
  }
}
