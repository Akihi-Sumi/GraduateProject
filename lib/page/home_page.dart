import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/controller/auth.dart';
import 'package:graduate_app/controller/group_message.dart';
import 'package:graduate_app/controller/message.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/dialog.dart';
import 'package:graduate_app/utils/firestore_refs/group_message_ref.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:graduate_app/widgets/message_bubble.dart';
import 'package:graduate_app/widgets/send_action_button.dart';
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
    ref.listen<AsyncValue<void>>(sendMessageAllGroupControllerProvider,
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
          //Navigator.of(context, rootNavigator: true).pop();
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

    final userId = ref.watch(userIdProvider);
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );

    final sendAllGroupState = ref.watch(sendMessageAllGroupControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 110),
          child: Column(
            children: messages.map((message) {
              return Container(
                margin: EdgeInsets.only(bottom: 30),
                child: MessageBubble(
                  message: message,
                  onTap: () async {
                    await showActionDialog(
                      context: context,
                      title: "メッセージを送信しますか",
                      buttonText: "送信",
                      onPressed: sendAllGroupState.isLoading
                          ? null
                          : () async {
                              final groupMessage = CreateGroupMessage(
                                content: message.content,
                                senderId: appUserName ?? '',
                                //createdAt: DateTime.now(),
                              );

                              await ref
                                  .read(sendMessageAllGroupControllerProvider
                                      .notifier)
                                  .sendMessageAllGroup(
                                    groupMessage: groupMessage,
                                    userId: userId ?? '',
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
      // floatingActionButton: SendLocation(),
      floatingActionButton: SendActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
