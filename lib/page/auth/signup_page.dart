import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduate_app/controller/auth/sign_up.dart';
import 'package:graduate_app/gen/assets.gen.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/constants/app_colors.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/utils/dialog.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:graduate_app/utils/text_styles.dart';
import 'package:graduate_app/utils/textform_styles.dart';
import 'package:graduate_app/widgets/app_bar.dart';
import 'package:graduate_app/widgets/rounded_button.dart';
import 'package:graduate_app/widgets/textform_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SignupPage extends HookConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      signUpControllerProvider,
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
                .showSnackBar('新しいアカウントを作成しました。');

            await context.popRoute();
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

    // Provider
    final state = ref.watch(signUpControllerProvider);

    // Hooks
    final isObscure = useState(true);
    final isCheckTerms = useState(false);
    final userNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

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
                        isObscure: isObscure,
                      ),
                      Measure.g_32,
                      _TermsAndPrivacyPolicyText(
                        isCheckTerms: isCheckTerms,
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
                                        isCheckTerms: isCheckTerms.value,
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

class _TermsAndPrivacyPolicyText extends HookConsumerWidget {
  const _TermsAndPrivacyPolicyText({
    required this.isCheckTerms,
  });

  final ValueNotifier<bool> isCheckTerms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: Measure.p_h48,
      child: Row(
        children: [
          Checkbox(
            activeColor: AppColors.secondary,
            checkColor: AppColors.baseWhite,
            value: isCheckTerms.value,
            onChanged: (value) => isCheckTerms.value = value!,
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
                            .watch(overlayLoadingProvider.notifier)
                            .update((state) => true);
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
                              .watch(overlayLoadingProvider.notifier)
                              .update((state) => false);
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
                            .watch(overlayLoadingProvider.notifier)
                            .update((state) => true);
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
                              .watch(overlayLoadingProvider.notifier)
                              .update((state) => false);
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
