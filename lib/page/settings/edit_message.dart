import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduate_app/controller/message.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/dialog.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:graduate_app/widgets/message_bubble.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class EditMessagePage extends StatefulHookConsumerWidget {
  const EditMessagePage({Key? key}) : super(key: key);

  @override
  EditMessagePageState createState() => EditMessagePageState();
}

class EditMessagePageState extends ConsumerState<EditMessagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..listen<AsyncValue<void>>(
        createMessageControllerProvider,
        (_, state) async {
          if (state.isLoading) {
            ref.watch(overlayLoadingProvider.notifier).update((state) => true);
            return;
          }

          await state.when(
            data: (_) async {
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              ref
                  .read(scaffoldMessengerServiceProvider)
                  .showSnackBar('メッセージをを追加しました。');

              Navigator.of(context, rootNavigator: true).pop();
            },
            error: (e, s) async {
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              state.showAlertDialogOnError(context);
            },
            loading: () {
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => true);
            },
          );
        },
      )
      ..listen<AsyncValue<void>>(
        messageUpdateControllerProvider,
        (_, state) async {
          if (state.isLoading) {
            ref.watch(overlayLoadingProvider.notifier).update((state) => true);
            return;
          }

          await state.when(
            data: (_) async {
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              ref
                  .read(scaffoldMessengerServiceProvider)
                  .showSnackBar("メッセージを更新しました。");

              Navigator.of(context, rootNavigator: true).pop();
            },
            error: (e, s) async {
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              state.showAlertDialogOnError(context);
            },
            loading: () {
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => true);
            },
          );
        },
      )
      ..listen<AsyncValue<void>>(messageDeleteControllerProvider,
          (_, state) async {
        if (state.isLoading) {
          ref.watch(overlayLoadingProvider.notifier).update((state) => true);
          return;
        }

        await state.when(data: (_) async {
          ref.watch(overlayLoadingProvider.notifier).update((state) => false);

          ref
              .read(scaffoldMessengerServiceProvider)
              .showSnackBar("メッセージを削除しました。");

          Navigator.of(context, rootNavigator: true).pop();
        }, error: (e, s) async {
          ref.watch(overlayLoadingProvider.notifier).update((state) => false);
          state.showAlertDialogOnError(context);
        }, loading: () {
          ref.watch(overlayLoadingProvider.notifier).update((state) => true);
        });
      });

    final messages = ref.watch(messagesProvider).maybeWhen<List<Message>>(
          data: (data) {
            return data.sublist(0, data.length >= 20 ? 20 : data.length);
          },
          orElse: () => [],
        );

    final userId = ref.watch(authRepositoryImplProvider).currentUser?.uid;

    final useMessageController = useTextEditingController();
    final useReNameController = useTextEditingController();

    final theme = ref.watch(themeNotifierProvider);

    return GestureDetector(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            title: Text(
              context.topRoute.title(context),
            ),
            leading: BackButton(
              onPressed: () => context.popRoute(),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 110),
            child: Column(
              children: messages.map((msg) {
                return Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: MessageBubble(
                    message: msg,
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 140,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.edit,
                                    size: 40,
                                    color: Colors.grey.shade300,
                                  ),
                                  title: Text(
                                    "編集",
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  onTap: () async {
                                    useReNameController.text = msg.content;
                                    await editMessageDialog(
                                      context,
                                      useReNameController,
                                      onPressed: () async {
                                        final message = msg.copyWith(
                                            content:
                                                useReNameController.value.text);

                                        if (userId != null) {
                                          await ref
                                              .read(
                                                  messageUpdateControllerProvider
                                                      .notifier)
                                              .updateMessage(
                                                userId: userId,
                                                messageId: msg.messageId,
                                                message: message,
                                              );
                                        }
                                      },
                                    );

                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.delete,
                                    size: 40,
                                    color: Colors.grey.shade300,
                                  ),
                                  title: Text(
                                    "削除",
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  onTap: () async {
                                    await showActionDialog(
                                      context: context,
                                      title: 'メッセージを削除しますか?',
                                      buttonText: "はい",
                                      onPressed: () async {
                                        if (userId != null) {
                                          await ref
                                              .read(
                                                  messageDeleteControllerProvider
                                                      .notifier)
                                              .deleteMessage(
                                                userId: userId,
                                                messageId: msg.messageId,
                                                message: msg,
                                              );
                                        }
                                      },
                                    );

                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        floatingActionButton: Container(
          height: 100,
          width: 100,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 100),
          child: FloatingActionButton(
            onPressed: () async {
              await createMessageDialog(
                context,
                useMessageController,
                onPressed: () async {
                  // ref
                  //     .watch(overlayLoadingProvider.notifier)
                  //     .update((state) => true);

                  final message = Message(
                    content: useMessageController.value.text,
                    createdAt: DateTime.now(),
                  );

                  if (userId != null) {
                    await ref
                        .read(createMessageControllerProvider.notifier)
                        .createMessage(
                          userId: userId,
                          message: message,
                        );
                  }

                  useMessageController.clear();
                },
              );
            },
            backgroundColor: theme == Palette.darkModeAppTheme
                ? Palette.whiteColor
                : Palette.appColor,
            child: Icon(
              Icons.add_comment_rounded,
              color: theme == Palette.darkModeAppTheme
                  ? Palette.appColor
                  : Palette.whiteColor,
              size: 50,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }
}
