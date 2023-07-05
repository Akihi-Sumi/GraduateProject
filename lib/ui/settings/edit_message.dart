import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/features/features.dart';
import 'package:graduate_app/models/models.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/ui/settings/create_message_page.dart';
import 'package:graduate_app/utils/utils.dart';
import 'package:graduate_app/widget/message_bubble.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class EditMessagePage extends HookConsumerWidget {
  const EditMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(messageDeleteControllerProvider,
        (_, state) async {
      if (state.isLoading) {
        ref.watch(overlayLoadingProvider.notifier).update((state) => true);
        return;
      }

      await state.when(data: (_) async {
        ref.watch(overlayLoadingProvider.notifier).update((state) => false);
        // ref
        //     .read(scaffoldMessengerServiceProvider)
        //     .showSnackBar("メッセージを削除しました");
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

    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: messages
                  .map(
                    (message) => MessageBubble(
                      message: message,
                      isSender: true,
                      isEditor: true,
                      changeEnable: false,
                      execution: () async {
                        if (userId != null) {
                          await ref
                              .read(messageDeleteControllerProvider.notifier)
                              .deleteMessage(
                                userId: userId,
                                messageId: message.messageId,
                                message: message,
                              );
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              _sliderAnimationBuilder(
                widget: CreateMessagePage(),
              ),
            );
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_comment_rounded,
            color: Colors.orange[700],
            size: 40,
          ),
        ),
      ),
    );
  }
}

PageRouteBuilder _sliderAnimationBuilder({required Widget widget}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    fullscreenDialog: true,
    pageBuilder: (context, animation, secondaryAnimation) {
      // 表示する画面のWidget
      return widget;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1); // 下から上
      // final Offset begin = Offset(0.0, -1.0); // 上から下
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: Curves.easeInOut));
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
