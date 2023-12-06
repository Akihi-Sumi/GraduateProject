import 'dart:async';

import 'package:graduate_app/controller/auth.dart';
import 'package:graduate_app/controller/group_controller/group_state.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/repositories/group.dart';
import 'package:graduate_app/repositories/group_message.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:graduate_app/utils/firestore_refs/group_message_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupFutureProvider = FutureProvider.family
    .autoDispose<GroupModel?, String>((ref, groupId) =>
        ref.watch(groupRepositoryProvider).fetchGroup(groupId: groupId));

// final groupPartnerImageUrlProvider =
//     Provider.family.autoDispose<String, GroupModel>((ref, redGroup) {
//   return ref.watch(userImageUrlProvider(readGroup.userId));
// });

// final groupPartnerDisplayNameProvider =
//     Provider.family.autoDispose<String, GroupModel>((ref, readGroup) {
//   return ref.watch(groupDisplayNameProvider(readGroup.userId));
// });

final groupStateNotifierProvider = StateNotifierProvider.family
    .autoDispose<GroupStateNotifier, GroupState, String>((ref, groupId) {
  return GroupStateNotifier(
    groupId: groupId,
    userId: ref.watch(userIdProvider) ?? '',
    groupRepository: ref.watch(groupRepositoryProvider),
    groupMessageRepository: ref.watch(groupMessageRepositoryProvider),
    //readStatusService: ref.watch(readStatusServiceProvider),
  );
});

class GroupStateNotifier extends StateNotifier<GroupState> {
  final String _groupId;
  //final String _userId;
  final GroupRepository _groupRepository;
  final GroupMessageRepository _groupMessageRepository;
  //final ReadStatusService _readStatusService;

  final _startDateTime = DateTime.now();
  static const _limit = 10;

  late final StreamSubscription<List<ReadGroupMessage>>
      _newReadGroupMessagesSubscription;

  GroupStateNotifier({
    required String groupId,
    required String userId,
    required GroupRepository groupRepository,
    required GroupMessageRepository groupMessageRepository,
    //required ReadStatusService readStatusService,
  })  : _groupId = groupId,
        //_userId = userId,
        _groupRepository = groupRepository,
        _groupMessageRepository = groupMessageRepository,
        //_readStatusService = readStatusService,
        super(const GroupState()) {
    _newReadGroupMessagesSubscription = _groupMessageRepository
        .subscribeGroupMessage(
          groupId: _groupId,
          startDateTime: _startDateTime,
        )
        .listen(_updateNewReadGroupMessages);

    Future<void>(() async {
      await Future.wait<void>([
        _fetchGroup(),
        //_updateReadStatus(),
        loadMore(),
        Future<void>.delayed(const Duration(milliseconds: 500)),
      ]);
    });
    state = state.copyWith(loading: false);
  }

  @override
  void dispose() {
    _newReadGroupMessagesSubscription.cancel();
    super.dispose();
  }

  Future<void> _fetchGroup() async {
    final readGroup = await _groupRepository.fetchGroup(groupId: _groupId);
    state = state.copyWith(readGroup: readGroup);
  }

  Future<void> loadMore() async {
    if (!state.hasMore) {
      state = state.copyWith(fetchitg: false);
      return;
    }
    if (state.fetchitg) {
      return;
    }

    state = state.copyWith(fetchitg: true);
    final (readGroupMessages, lastReadGroupMessageId, hasMore) =
        await _groupMessageRepository.loadMessageWithDocumentIdCursor(
      groupId: _groupId,
      limit: _limit,
      lastReadMessageId: state.lastReadGroupMessageId,
    );

    _updatePastReadGroupMessages(
        [...state.pastReadGroupMessages, ...readGroupMessages]);

    state = state.copyWith(
      fetchitg: false,
      lastReadGroupMessageId: lastReadGroupMessageId,
      hasMore: hasMore,
    );
  }

  void _updateNewReadGroupMessages(
      List<ReadGroupMessage> newReadGroupMessages) {
    state = state.copyWith(newReadGroupMessages: newReadGroupMessages);
    _updateReadGroupMessages();
    //_updateReadStatus();
  }

  void _updatePastReadGroupMessages(
      List<ReadGroupMessage> pastReadGroupMessages) {
    state = state.copyWith(pastReadGroupMessages: pastReadGroupMessages);
    _updateReadGroupMessages();
  }

  void _updateReadGroupMessages() {
    state = state.copyWith(
      readGroupMessages: [
        ...state.newReadGroupMessages,
        ...state.pastReadGroupMessages,
      ],
    );
  }

  // Future<void> _updateReadStatus() {
  //   return _readStatusService.setReadStatus(groupId: _groupId, userId: _userId);
  // }

  Future<void> sendGroupMessage({
    required String senderId,
    required String content,
    List<String> imageUrls = const <String>[],
    //required DateTime createdAt,
  }) {
    return _groupMessageRepository.addGroupMessage(
      groupId: _groupId,
      senderId: senderId,
      content: content,
      imageUrls: imageUrls,
      //createdAt: createdAt,
    );
  }
}

final createGroupControllerProvider =
    AutoDisposeAsyncNotifierProvider<CreateGroupController, void>(
        CreateGroupController.new);

class CreateGroupController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> createGroup({
    required GroupModel group,
  }) async {
    final groupRepository = ref.read(groupRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      try {
        if (group.groupName.isEmpty) {
          throw const AppException(message: "グループ名を入力してください");
        }
        await groupRepository.createGroup(group: group);
      } on AppException {
        rethrow;
      }
    });
  }
}
