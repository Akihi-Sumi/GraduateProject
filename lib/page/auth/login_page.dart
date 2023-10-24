import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/features.dart';
import 'package:graduate_app/gen/assets.gen.dart';
import 'package:graduate_app/utils/utils.dart';
import 'package:graduate_app/widgets/widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provider
final _emailTextEditingController = Provider.autoDispose<TextEditingController>(
  (_) => TextEditingController(),
);

final _passwordTextEditingController =
    Provider.autoDispose<TextEditingController>(
  (_) => TextEditingController(),
);
final _sendEmailTextEditingController =
    Provider.autoDispose<TextEditingController>(
  (_) => TextEditingController(),
);

/// NotifierProvider
final _isObscureProvider =
    NotifierProvider.autoDispose<IsObscureNotifier, bool>(
  IsObscureNotifier.new,
);

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
            ref.read(overlayLoadingProvider.notifier).startLoading();
            return;
          }

          await state.when(
            data: (_) async {
              // ローディングを非表示にする
              ref.read(overlayLoadingProvider.notifier).endLoading();

              // ログインできたらスナックバーでメッセージを表示してホーム画面に遷移する
              ref
                  .read(scaffoldMessengerServiceProvider)
                  .showSnackBar('ログインしました。');

              await context.popRoute();
            },
            error: (e, s) async {
              // ローディングを非表示にする
              ref.read(overlayLoadingProvider.notifier).endLoading();

              // エラーが発生したらエラーダイアログを表示する
              state.showAlertDialogOnError(context);
            },
            loading: () {
              // ローディングを表示する
              ref.read(overlayLoadingProvider.notifier).startLoading();
            },
          );
        },
      )
      ..listen<AsyncValue<void>>(
        sendPasswordResetEmailControllerProvider,
        (_, state) async {
          if (state.isLoading) {
            ref.read(overlayLoadingProvider.notifier).startLoading();
            return;
          }

          await state.when(
            data: (_) async {
              // ローディングを非表示にする
              ref.read(overlayLoadingProvider.notifier).endLoading();

              Navigator.of(context).pop();

              // 送信できたらスナックバーでメッセージを表示して
              ref
                  .read(scaffoldMessengerServiceProvider)
                  .showSnackBar('メールを送信しました');
            },
            error: (e, s) async {
              // ローディングを非表示にする
              ref.read(overlayLoadingProvider.notifier).endLoading();

              // エラーが発生したらエラーダイアログを表示する
              state.showAlertDialogOnError(context);
            },
            loading: () {
              // ローディングを表示する
              ref.read(overlayLoadingProvider.notifier).startLoading();
            },
          );
        },
      );

    // Provider
    final signInstate = ref.watch(signInControllerProvider);
    final sendEmailState = ref.watch(sendPasswordResetEmailControllerProvider);
    final isObscureState = ref.watch(_isObscureProvider);
    final isObscureNotifier = ref.watch(_isObscureProvider.notifier);
    final emailController = ref.watch(_emailTextEditingController);
    final passwordController = ref.watch(_passwordTextEditingController);
    final sendEmailController = ref.watch(_sendEmailTextEditingController);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: const MyAppBar(
              title: 'Log in',
              elevation: 0,
              automaticallyImplyLeading: true,
            ),
            body: Stack(
              children: [
                //const GradationBackground(),
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
                        isObscureState: isObscureState,
                        notifier: isObscureNotifier,
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
      backgroundColor: AppColors.secondary,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: AutofillGroup(
            child: Column(
              children: [
                Measure.g_80,
                const _ResetPasswordBackButton(),
                Measure.g_60,
                const Icon(
                  Icons.lock,
                  size: 80,
                  color: AppColors.baseWhite,
                ),
                Measure.g_60,
                Text(
                  'パスワード再設定用のメールを送信',
                  style: TextStyles.h3(
                    color: AppColors.baseWhite,
                  ),
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
        style: TextStyles.p1(color: AppColors.secondary),
      ),
    );
  }
}

class _PasswordTextForm extends StatelessWidget {
  const _PasswordTextForm({
    required this.controller,
    required this.isObscureState,
    required this.notifier,
  });

  final TextEditingController controller;
  final bool isObscureState;
  final IsObscureNotifier notifier;

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
            obscureText: isObscureState,
            controller: controller,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            decoration: AppTextFormStyles.onPassword(
              state: isObscureState,
              notifier: notifier,
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
            color: AppColors.baseWhite,
          ),
          Measure.g_16,
          TextFormField(
            style: TextStyles.p1(
              color: AppColors.baseWhite,
            ),
            controller: controller,
            decoration: AppTextFormStyles.onGeneral(
              iconData: Icons.mail,
              color: AppColors.baseWhite,
            ),
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
          color: AppColors.baseDark,
        ),
      ),
    );
  }
}
