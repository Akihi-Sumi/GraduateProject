import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/features/features.dart';
import 'package:graduate_app/gen/assets.gen.dart';
import 'package:graduate_app/utils/utils.dart';
import 'package:graduate_app/widgets/widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _nameEmailTextEditingController =
    Provider.autoDispose<TextEditingController>(
  (_) => TextEditingController(),
);

final _emailTextEditingController = Provider.autoDispose<TextEditingController>(
  (_) => TextEditingController(),
);

final _passwordTextEditingController =
    Provider.autoDispose<TextEditingController>(
  (_) => TextEditingController(),
);

/// NotifierProvider
final _isObscureProvider =
    NotifierProvider.autoDispose<IsObscureNotifier, bool>(
  IsObscureNotifier.new,
);

final _isCheckTermsProvider =
    NotifierProvider.autoDispose<IsCheckTermsNotifier, bool>(
  IsCheckTermsNotifier.new,
);

@RoutePage()
class SignupPage extends HookConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      signUpControllerProvider,
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
                .showSnackBar('新しいアカウントを作成しました。');

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
    );

    // Provider
    final state = ref.watch(signUpControllerProvider);

    // Hooks
    final isCheckTermsState = ref.watch(_isCheckTermsProvider);
    final isCheckTermsNotifier = ref.watch(_isCheckTermsProvider.notifier);
    final isObscureState = ref.watch(_isObscureProvider);
    final isObscureNotifier = ref.watch(_isObscureProvider.notifier);
    final userNameController = ref.watch(_nameEmailTextEditingController);
    final emailController = ref.watch(_emailTextEditingController);
    final passwordController = ref.watch(_passwordTextEditingController);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: const MyAppBar(
              title: 'Create a account',
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
                      _UserNameTextForm(
                        controller: userNameController,
                      ),
                      Measure.g_16,
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
                      _TermsAndPrivacyPolicyText(
                        state: isCheckTermsState,
                        notifier: isCheckTermsNotifier,
                      ),
                      Measure.g_32,
                      Padding(
                        padding: Measure.p_h32,
                        child: PrimaryRoundedButton(
                          text: 'アカウントを作成',
                          onTap: state.isLoading
                              ? null
                              : () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  await ref
                                      .read(signUpControllerProvider.notifier)
                                      .signUp(
                                        isCheckTerms: isCheckTermsState,
                                        userName: userNameController.value.text,
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
}

class _UserNameTextForm extends StatelessWidget {
  const _UserNameTextForm({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          const TextFormHeader(title: 'ユーザー名'),
          Measure.g_4,
          TextFormField(
            maxLength: 20,
            controller: controller,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: AppTextFormStyles.onGeneral(
              iconData: Icons.account_circle,
            ),
          ),
        ],
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

class _TermsAndPrivacyPolicyText extends HookConsumerWidget {
  const _TermsAndPrivacyPolicyText({
    required this.state,
    required this.notifier,
  });

  final bool state;
  final IsCheckTermsNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: Measure.p_h48,
      child: Row(
        children: [
          Checkbox(
            activeColor: AppColors.secondary,
            checkColor: AppColors.baseWhite,
            value: state,
            onChanged: (value) => notifier.changeState(value: value!),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '利用規約 ',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        ref
                            .read(
                              overlayLoadingProvider.notifier,
                            )
                            .startLoading();
                        try {
                          // App users will check Terms of service
                          // with the web url or text in the app.
                        } on AppException catch (e) {
                          await showAlertDialog(
                            context: context,
                            title: 'Error',
                            content: e.message,
                            defaultActionText: 'OK',
                          );
                        } finally {
                          ref
                              .read(
                                overlayLoadingProvider.notifier,
                              )
                              .endLoading();
                        }
                      },
                    style: TextStyles.p2(
                      color: AppColors.secondary,
                    ),
                  ),
                  TextSpan(
                    text: 'および',
                    style: TextStyles.p2(),
                  ),
                  TextSpan(
                    text: ' プライバシーポリシー',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        ref
                            .read(
                              overlayLoadingProvider.notifier,
                            )
                            .startLoading();
                        try {
                          // App users will check Privacy Policy.
                          // with the web url or text in the app.
                        } on AppException catch (e) {
                          await showAlertDialog(
                            context: context,
                            title: 'Error',
                            content: e.message,
                            defaultActionText: 'OK',
                          );
                        } finally {
                          ref
                              .read(
                                overlayLoadingProvider.notifier,
                              )
                              .endLoading();
                        }
                      },
                    style: TextStyles.p2(
                      color: AppColors.secondary,
                    ),
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
