import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduate_app/controller/auth/send_password_reset_email.dart';
import 'package:graduate_app/controller/auth/sign_in.dart';
import 'package:graduate_app/gen/assets.gen.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:graduate_app/utils/text_styles.dart';
import 'package:graduate_app/utils/textform_styles.dart';
import 'package:graduate_app/widgets/rounded_button.dart';
import 'package:graduate_app/widgets/textform_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen<AsyncValue<void>>(
        signInControllerProvider,
        (_, state) async {
          if (state.isLoading) {
            ref.watch(overlayLoadingProvider.notifier).update((state) => true);
            return;
          }

          await state.when(
            data: (_) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              // ログインできたらスナックバーでメッセージを表示してホーム画面に遷移する
              ref
                  .read(scaffoldMessengerServiceProvider)
                  .showSnackBar('ログインしました。');

              await context.popRoute();
            },
            error: (e, s) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              // エラーが発生したらエラーダイアログを表示する
              state.showAlertDialogOnError(context);
            },
            loading: () {
              // ローディングを表示する
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => true);
            },
          );
        },
      )
      ..listen<AsyncValue<void>>(
        sendPasswordResetEmailControllerProvider,
        (_, state) async {
          if (state.isLoading) {
            ref.watch(overlayLoadingProvider.notifier).update((state) => true);
            return;
          }

          await state.when(
            data: (_) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              Navigator.of(context).pop();

              // 送信できたらスナックバーでメッセージを表示して
              ref
                  .read(scaffoldMessengerServiceProvider)
                  .showSnackBar('メールを送信しました');
            },
            error: (e, s) async {
              // ローディングを非表示にする
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => false);

              // エラーが発生したらエラーダイアログを表示する
              state.showAlertDialogOnError(context);
            },
            loading: () {
              // ローディングを表示する
              ref
                  .watch(overlayLoadingProvider.notifier)
                  .update((state) => true);
            },
          );
        },
      );

    // Provider
    final signInstate = ref.watch(signInControllerProvider);
    final sendEmailState = ref.watch(sendPasswordResetEmailControllerProvider);

    // Hooks
    final isObscure = useState(true);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final sendEmailController = useTextEditingController();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text('Log in'),
              elevation: 0,
              automaticallyImplyLeading: true,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      Measure.g_24,
                      Assets.images.flutterIcon.image(
                        width: 200,
                        height: 200,
                      ),
                      Measure.g_24,
                      _EmailTextForm(
                        controller: emailController,
                      ),
                      Measure.g_16,
                      _PasswordTextForm(
                        controller: passwordController,
                        isObscure: isObscure,
                      ),
                      Measure.g_32,
                      _ForgetPasswordTextButton(
                        onTap: () async {
                          await _sendPasswordResetEmailSheet(
                            context,
                            sendEmailController,
                            sendEmailState,
                            ref,
                          );
                        },
                      ),
                      Measure.g_32,
                      Padding(
                        padding: Measure.p_h32,
                        child: PrimaryRoundedButton(
                          text: 'ログイン',
                          onTap: signInstate.isLoading
                              ? null
                              : () async {
                                  await ref
                                      .read(signInControllerProvider.notifier)
                                      .signIn(
                                        email: emailController.value.text,
                                        password: passwordController.value.text,
                                      );
                                },
                        ),
                      ),
                      Measure.g_32,
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
        ],
      ),
    );
  }

  Future<void> _sendPasswordResetEmailSheet(
    BuildContext context,
    TextEditingController useSendEmailController,
    AsyncValue<void> sendEmailState,
    WidgetRef ref,
  ) async {
    await showModalBottomSheet<bool>(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: AutofillGroup(
            child: Column(
              children: [
                Measure.g_60,
                const _ResetPasswordBackButton(),
                Measure.g_60,
                const Icon(
                  Icons.lock,
                  size: 80,
                  color: Palette.whiteColor,
                ),
                Measure.g_60,
                Text(
                  'パスワード再設定用のメールを送信',
                  style: TextStyles.p1(color: Palette.whiteColor),
                ),
                Measure.g_60,
                _ResetEmailTextForm(
                  controller: useSendEmailController,
                ),
                Measure.g_60,
                Padding(
                  padding: Measure.p_h32,
                  child: SecondaryRoundedButton(
                    text: '送信',
                    onTap: sendEmailState.isLoading
                        ? null
                        : () async {
                            await ref
                                .read(
                                  sendPasswordResetEmailControllerProvider
                                      .notifier,
                                )
                                .sendPasswordResetEmail(
                                  email: useSendEmailController.value.text,
                                );
                          },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Measure.r_16,
          topRight: Measure.r_16,
        ),
      ),
    );
  }
}

class _EmailTextForm extends StatelessWidget {
  const _EmailTextForm({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          const TextFormHeader(title: 'メールアドレス'),
          Measure.g_4,
          TextFormField(
            autofillHints: const [AutofillHints.email],
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: AppTextFormStyles.onGeneral(
              iconData: Icons.mail,
            ),
          ),
        ],
      ),
    );
  }
}

class _ForgetPasswordTextButton extends StatelessWidget {
  const _ForgetPasswordTextButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        'パスワードをお忘れの方',
        style: TextStyles.p1(color: Colors.amber),
      ),
    );
  }
}

class _PasswordTextForm extends StatelessWidget {
  const _PasswordTextForm({
    required this.controller,
    required this.isObscure,
  });

  final TextEditingController controller;
  final ValueNotifier<bool> isObscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          const TextFormHeader(title: 'パスワード'),
          Measure.g_4,
          TextFormField(
            autofillHints: const [AutofillHints.password],
            obscureText: isObscure.value,
            controller: controller,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            decoration: AppTextFormStyles.onPassword(
              isObscure: isObscure,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResetEmailTextForm extends StatelessWidget {
  const _ResetEmailTextForm({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          const TextFormHeader(
            title: 'メールアドレス',
            color: Palette.whiteColor,
          ),
          Measure.g_16,
          TextFormField(
            style: TextStyles.p1(),
            controller: controller,
            decoration: AppTextFormStyles.onResetPassword(
              iconData: Icons.mail,
            ),
            cursorColor: Palette.whiteColor,
          ),
        ],
      ),
    );
  }
}

class _ResetPasswordBackButton extends StatelessWidget {
  const _ResetPasswordBackButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.close,
          size: 32,
          color: Palette.whiteColor,
        ),
      ),
    );
  }
}
