import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/controller/group_message.dart';
import 'package:graduate_app/controller/message.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/dialog.dart';
import 'package:graduate_app/utils/json_converters/union_timestamp.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:graduate_app/widgets/message_bubble.dart';
import 'package:graduate_app/widgets/send_location.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomeRouterPage extends AutoRouter {
  const HomeRouterPage({super.key});
}

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(sendMessageControllerProvider,
        (_, state) async {
      if (state.isLoading) {
        ref.watch(overlayLoadingProvider.notifier).update((state) => true);
        return;
      }

      await state.when(
        data: (_) async {
          ref.watch(overlayLoadingProvider.notifier).update((state) => false);
          ref
              .read(scaffoldMessengerServiceProvider)
              .showSnackBar("メッセージを送信しました");
          //Navigator.of(context).pop();
        },
        error: (e, s) async {
          ref.watch(overlayLoadingProvider.notifier).update((state) => false);
          state.showAlertDialogOnError(context);
        },
        loading: () {
          ref.watch(overlayLoadingProvider.notifier).update((state) => true);
        },
      );
    });

    final messages = ref.watch(messagesProvider).maybeWhen<List<Message>>(
          data: (data) {
            return data.sublist(0, data.length >= 20 ? 20 : data.length);
          },
          orElse: () => [],
        );

    final userId = ref.watch(authRepositoryImplProvider).currentUser?.uid;
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 110),
          child: Column(
            children: messages
                .map(
                  (message) => Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: MessageBubble(
                      message: message,
                      isSender: true,
                      //isUser: true,
                      changeEnable: false,
                      exe: () async {
                        await showActionDialog(
                          context: context,
                          title: "メッセージを送信しますか",
                          buttonText: "送信",
                          onPressed: () async {
                            ref
                                .watch(overlayLoadingProvider.notifier)
                                .update((state) => true);

                            final groupMessage = Message(
                              messageText: message.messageText,
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

                            // if (context.mounted) {
                            //   Navigator.of(context).pop();
                            // }
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
      floatingActionButton: SendLocation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
