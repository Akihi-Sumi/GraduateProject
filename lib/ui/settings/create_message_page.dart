import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduate_app/features/message.dart';
import 'package:graduate_app/models/models.dart';
import 'package:graduate_app/repositories/repositories.dart';
import 'package:graduate_app/utils/utils.dart';
import 'package:graduate_app/widget/widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _messageTextEditingContrller =
    Provider.autoDispose<TextEditingController>(
  (_) => TextEditingController(),
);

class CreateMessagePage extends HookConsumerWidget {
  const CreateMessagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      createMessageControllerProvider,
      (_, state) async {
        if (state.isLoading) {
          ref.watch(overlayLoadingProvider.notifier).update((state) => true);
          return;
        }

        await state.when(
          data: (_) async {
            // ローディングを非表示にする
            ref.watch(overlayLoadingProvider.notifier).update((state) => false);

            // ログインできたらスナックバーでメッセージを表示してホーム画面に遷移する
            ref
                .read(scaffoldMessengerServiceProvider)
                .showSnackBar('メッセージをを追加しました！');

            Navigator.of(context).pop();
          },
          error: (e, s) async {
            // ローディングを非表示にする
            ref.watch(overlayLoadingProvider.notifier).update((state) => false);

            // エラーが発生したらエラーダイアログを表示する
            state.showAlertDialogOnError(context);
          },
          loading: () {
            // ローディングを表示する
            ref.watch(overlayLoadingProvider.notifier).update((state) => true);
          },
        );
      },
    );

    final userId = ref.watch(authRepositoryImplProvider).currentUser?.uid;
    final messageController = ref.watch(_messageTextEditingContrller);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('閉じる'),
              automaticallyImplyLeading: true,
              backgroundColor: Colors.black,
              centerTitle: false,
            ),
            body: Padding(
              padding: Measure.p_a16,
              child: Column(
                children: [
                  Gap(24),
                  _MessageTextForm(controller: messageController),
                  SizedBox(height: 40),
                  PrimaryRoundedButton(
                    text: "追加",
                    onTap: () async {
                      ref
                          .watch(overlayLoadingProvider.notifier)
                          .update((state) => true);

                      final message = Message(
                        messageText: messageController.value.text,
                        createdAt: UnionTimestamp.serverTimestamp(),
                        updatedAt: UnionTimestamp.serverTimestamp(),
                      );

                      if (userId != null) {
                        await ref
                            .read(createMessageControllerProvider.notifier)
                            .createMessage(
                              userId: userId,
                              message: message.copyWith(
                                messageText: messageController.value.text,
                              ),
                            );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageTextForm extends StatelessWidget {
  const _MessageTextForm({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          Measure.g_4,
          TextFormField(
            controller: controller,
            decoration: AppTextFormStyles.onGeneral(
              color: AppColors.baseWhite,
              iconData: Icons.message,
            ),
          ),
        ],
      ),
    );
  }
}
