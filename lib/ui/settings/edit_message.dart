import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduate_app/features/features.dart';
import 'package:graduate_app/models/models.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
// import 'package:graduate_app/ui/settings/create_message_page.dart';
import 'package:graduate_app/utils/utils.dart';
import 'package:graduate_app/widget/message_bubble.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class EditMessagePage extends HookConsumerWidget {
  const EditMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

              Navigator.of(context).pop();
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

              Navigator.of(context).pop();
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

          Navigator.of(context).pop();
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

    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 110),
            child: Column(
              children: messages
                  .map(
                    (msg) => Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: EditMessageBubble(
                        message: msg,
                        isSender: true,
                        onLongPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 140,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.edit, size: 40),
                                      title: Text(
                                        "編集",
                                        style: TextStyle(fontSize: 28),
                                      ),
                                      onTap: () async {
                                        useReNameController.text =
                                            msg.messageText;
                                        await editMessageDialog(
                                          context,
                                          useReNameController,
                                          onPressed: () async {
                                            final message = msg.copyWith(
                                                messageText: useReNameController
                                                    .value.text);

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
                                        ).then(
                                          (value) => Navigator.pop(context),
                                        );
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.delete, size: 40),
                                      title: Text(
                                        "削除",
                                        style: TextStyle(fontSize: 28),
                                      ),
                                      onTap: () async {
                                        await showActionDialog(
                                          context: context,
                                          title: 'メッセージを削除',
                                          content: 'メッセージを削除します。',
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
                                                  )
                                                  .then(
                                                    (value) =>
                                                        Navigator.pop(context),
                                                  );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        floatingActionButton: Container(
          height: 100,
          width: 100,
          padding: EdgeInsets.all(15),
          child: FloatingActionButton(
            onPressed: () async {
              await createMessageDialog(
                context,
                useMessageController,
                onPressed: () async {
                  ref
                      .watch(overlayLoadingProvider.notifier)
                      .update((state) => true);

                  final message = Message(
                    messageText: useMessageController.value.text,
                    createdAt: UnionTimestamp.serverTimestamp(),
                    updatedAt: UnionTimestamp.serverTimestamp(),
                  );

                  if (userId != null) {
                    await ref
                        .read(createMessageControllerProvider.notifier)
                        .createMessage(
                          userId: userId,
                          message: message,
                        );
                  }
                },
              );
            },
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add_comment_rounded,
              color: Colors.orange[700],
              size: 50,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }
}
