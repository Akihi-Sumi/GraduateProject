import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/controller/group.dart';
import 'package:graduate_app/controller/group_message.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/page/group/send_message_page.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/constants/app_colors.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/utils/extensions/date_time.dart';
import 'package:graduate_app/utils/json_converters/union_timestamp.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:graduate_app/widgets/message_bubble.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class GroupRouterPage extends AutoRouter {
  const GroupRouterPage({super.key});
}

@RoutePage()
class GroupPage extends StatefulHookConsumerWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  ConsumerState<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends ConsumerState<GroupPage> {
  final messageTextController = TextEditingController();

  List<GroupModel> groups = [];
  GroupModel? selectedGroup;

  @override
  void dispose() {
    super.dispose();
    messageTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(sendMessageControllerProvider,
        (_, state) async {
      if (state.isLoading) {
        ref.watch(overlayLoadingProvider.notifier).update((state) => true);
        return;
      }

      await state.when(data: (_) async {
        ref.watch(overlayLoadingProvider.notifier).update((state) => false);
        ref.read(scaffoldMessengerServiceProvider).showSnackBar("送信しました");
      }, error: (e, s) async {
        ref.watch(overlayLoadingProvider.notifier).update((state) => false);
        state.showAlertDialogOnError(context);
      }, loading: () {
        ref.watch(overlayLoadingProvider.notifier).update((state) => true);
      });
    });

    final groupMessages =
        ref.watch(groupMessageProvider).maybeWhen<List<Message>>(
              data: (data) => data.toList(),
              orElse: () => [],
            );

    final userId = ref.watch(authRepositoryImplProvider).currentUser?.uid;
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            ref.watch(groupsProvider).when(
                  data: (data) {
                    groups = data;

                    if (data.isEmpty) {
                      return const SizedBox();
                    }

                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: Measure.br_6,
                        border: Border.all(
                          color: AppColors.secondary,
                        ),
                      ),
                      child: SizedBox(
                        width: 300,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Container(),
                            dropdownColor: Colors.grey[800],
                            icon: Icon(
                              Icons.expand_more,
                              color: AppColors.secondary,
                            ),
                            value: selectedGroup ?? data[0],
                            items: data
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Center(
                                        child: Text(e.groupName),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedGroup = value;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) => ErrorText(
                    error: error.toString(),
                  ),
                  loading: () => const Loader(),
                ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: groupMessages.map((messages) {
                          /// 自身のユーザーIDとメッセージのユーザーIDを比較
                          final isSender = userId == messages.userId;

                          return Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: GroupMessageBubble(
                              message: messages,
                              isSender: isSender,
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.5,
                                fontWeight: FontWeight.bold,
                              ),
                              onLongPress: () {
                                print("longPressed");
                              },
                              date: toIsoStringDateWithWeekDay(
                                  messages.createdAt.dateTime),
                              time: to24HourNotationString(
                                  messages.createdAt.dateTime),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _MessageInputField(
              controller: messageTextController,
              sendMessage: () async {
                ref
                    .watch(overlayLoadingProvider.notifier)
                    .update((state) => true);

                final groupMessage = Message(
                  messageText: messageTextController.value.text,
                  type: 'text',
                  userId: userId ?? '',
                  userName: appUserName ?? '',
                  createdAt: UnionTimestamp.serverTimestamp(),
                );
                await ref
                    .read(sendMessageControllerProvider.notifier)
                    .sendMessage(
                      groupMessage: groupMessage,
                    );

                messageTextController.clear();
              },
            ),
          ],
        ),
        // floatingActionButton: Container(
        //   height: 80,
        //   width: 80,
        //   padding: EdgeInsets.only(bottom: 10, right: 10),
        //   child: FloatingActionButton(
        //     backgroundColor: Colors.orange[700],
        //     heroTag: "post",
        //     onPressed: () => showModalBottomSheet(
        //       context: context,
        //       useRootNavigator: true,
        //       builder: (builder) {
        //         return SelectPostTypeSheet();
        //       },
        //       backgroundColor: Colors.grey[850],
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.vertical(
        //           top: Radius.circular(25.0),
        //         ),
        //       ),
        //     ),
        //     child: Icon(
        //       Icons.add,
        //       size: 50,
        //     ),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class SelectPostTypeSheet extends StatelessWidget {
  const SelectPostTypeSheet({Key? key}) : super(key: key);

  void navigateToType(BuildContext context, String type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SendMessagePage(type: type)));
  }

  @override
  Widget build(BuildContext context) {
    double cardHeightWidth = kIsWeb ? 360 : 120;
    double iconSize = kIsWeb ? 120 : 60;

    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            child: SizedBox(
              height: cardHeightWidth,
              width: cardHeightWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.black,
                elevation: 16,
                child: Center(
                  child: Icon(
                    Icons.add_comment,
                    size: iconSize,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              // メッセージ作成画面orウィジェット
              navigateToType(context, 'text');
            },
          ),
          GestureDetector(
            child: SizedBox(
              height: cardHeightWidth,
              width: cardHeightWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.black,
                elevation: 16,
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: iconSize,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              // 画像選択画面orウィジェット
            },
          ),
          GestureDetector(
            child: SizedBox(
              height: cardHeightWidth,
              width: cardHeightWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.black,
                elevation: 16,
                child: Center(
                  child: Icon(
                    Icons.add_a_photo,
                    size: iconSize,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              // カメラ起動
            },
          ),
        ],
      ),
    );
  }
}

class _MessageInputField extends HookConsumerWidget {
  const _MessageInputField({
    required this.controller,
    required this.sendMessage,
  });

  final TextEditingController controller;
  final void Function()? sendMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_a_photo),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.image),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.grey.shade300,
            ),
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 5,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.orange,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                  left: 16,
                  right: 36,
                  top: 12,
                  bottom: 8,
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'メッセージを入力',
                hintStyle: TextStyle(color: Colors.grey.shade600),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
                suffixIconColor: Colors.orangeAccent.shade400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
