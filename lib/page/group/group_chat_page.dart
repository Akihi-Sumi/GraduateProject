import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/controllers/group/group.dart';
import 'package:graduate_app/page/auth/auth_dependent_builder.dart';
import 'package:graduate_app/widgets/group_massase_bubble.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class GroupChatPage extends ConsumerStatefulWidget {
  const GroupChatPage({
    Key? key,
    @PathParam('groupId') required this.groupId,
  }) : super(key: key);

  static const path = 'group/:groupId';

  static String location({required String groupId}) => 'group/$groupId';

  final String groupId;

  @override
  ConsumerState<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends ConsumerState<GroupChatPage> {
  final messageTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    messageTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(groupStateNotifierProvider(widget.groupId));
    //final loading = state.loading;
    final readGroup = state.readGroup;

    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            title: Text(
              readGroup?.groupName ?? '',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            leading: BackButton(
              onPressed: () => context.popRoute(),
            ),
            backgroundColor: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AuthDependentBuilder(
            onAuthenticated: (userId) {
              // if (loading) {
              //   return const Center(
              //     child: Icon(
              //       Icons.chat,
              //       size: 80,
              //       color: Colors.amber,
              //     ),
              //   );
              // }
              if (readGroup == null) {
                return const SizedBox();
              }
              // if (!_hasAccessToGroup(group: readGroup, userId: userId)) {
              //   return const Unavailable("そのグループは表示できません。");
              // }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.readGroupMessages.length,
                      //reverse: false,
                      // controller: _scrollController,
                      itemBuilder: (context, index) {
                        final readGroupMessage = state.readGroupMessages[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: GroupMessageBubble(
                            group: readGroup,
                            message: readGroupMessage,
                            isMyMessage:
                                readGroupMessage.senderId == appUserName,
                            isGroupMessage: true,
                            sizeSenderBubble:
                                EdgeInsets.fromLTRB(12.5, 15, 20, 15),
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  _MessageInputField(groupId: widget.groupId, userId: userId),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // bool _hasAccessToGroup({
  //   required String userId,
  //   required GroupModel group,
  // }) {
  //   return group.members.contains(element) == userId;
  // }
}

class _MessageInputField extends ConsumerStatefulWidget {
  const _MessageInputField({
    required this.groupId,
    required this.userId,
  });

  final String groupId;
  final String userId;

  @override
  ConsumerState<_MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends ConsumerState<_MessageInputField> {
  late final TextEditingController messageTextController;

  bool _isValid = false;

  @override
  void initState() {
    messageTextController = TextEditingController()
      ..addListener(() {
        _isValid = messageTextController.text.isNotEmpty;
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );

    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.grey.shade300,
            ),
            child: TextField(
              controller: messageTextController,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 16, right: 36, top: 8, bottom: 8),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'メッセージを入力',
                hintStyle: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isValid ? Colors.orange : Colors.grey,
            ),
            child: const Icon(Icons.send, size: 20, color: Colors.white),
          ),
          onTap: () async {
            if (!_isValid) {
              return;
            }
            final content = messageTextController.text;
            if (content.isEmpty) {
              return;
            }
            await ref
                .read(groupStateNotifierProvider(widget.groupId).notifier)
                .sendGroupMessage(
                  senderId: appUserName ?? '',
                  content: content,
                  createdAt: DateTime.now(),
                );
            messageTextController.clear();
          },
        ),
      ],
    );
  }
}
