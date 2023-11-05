import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/models/read_status/read_status.dart';
import 'package:graduate_app/repositories/read_status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final myReadStatusStreamProvider = StreamProvider.family
    .autoDispose<ReadStatus?, GroupModel>((ref, readGroup) {
  return ref.watch(readStatusRepositoryProvider).subscrbeReadStatus(
        groupId: readGroup.groupId,
        userId: readGroup.createUserId,
      );
});

final groupPartnerLastReadAtProvider =
    Provider.family.autoDispose<DateTime?, GroupModel>((ref, readGroup) {
  final readStatus =
      ref.watch(_groupPartnerReadStatusStreamProvider(readGroup)).valueOrNull;
  return readStatus?.lastReadAt;
});

final _groupPartnerReadStatusStreamProvider = StreamProvider.family
    .autoDispose<ReadStatus?, GroupModel>((ref, readGroup) {
  return ref.watch(readStatusRepositoryProvider).subscrbeReadStatus(
        groupId: readGroup.groupId,
        userId: readGroup.createUserId,
      );
});

final readStatusServiceProvider = Provider.autoDispose<ReadStatusService>(
  (ref) => ReadStatusService(
    readStatusRepository: ref.watch(readStatusRepositoryProvider),
  ),
);

class ReadStatusService {
  const ReadStatusService({required ReadStatusRepository readStatusRepository})
      : _readStatusRepository = readStatusRepository;

  final ReadStatusRepository _readStatusRepository;

  Future<void> setReadStatus({
    required String groupId,
    required String userId,
  }) {
    return _readStatusRepository.setLastReadAt(
      groupId: groupId,
      userId: userId,
    );
  }
}
