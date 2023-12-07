import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/gen/assets.gen.dart';
import 'package:graduate_app/page/auth/login_page.dart';
import 'package:graduate_app/page/auth/signup_page.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/utils/text_styles.dart';
import 'package:graduate_app/widgets/app_bar.dart';
import 'package:graduate_app/widgets/rounded_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class GetStartedPage extends ConsumerWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const MyAppBar(
          title: '',
          elevation: 0,
        ),
        body: Stack(
          children: [
            // const GradationBackground(
            //   startPoint: 0.75,
            // ),
            // キーボードを開いた状態でこの画面に pop すると画面幅の問題でエラーが出るため、
            // [SingleChildScrollView] を追加している。
            SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Measure.g_32,
                  Measure.g_32,
                  Assets.images.flutterIcon.image(
                    width: 200,
                    height: 200,
                  ),
                  Measure.g_32,
                  const _AppTitleText(),
                  Measure.g_32,
                  Padding(
                    padding: Measure.p_h32,
                    child: PrimaryRoundedButton(
                      text: 'Create account',
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          _fadeAnimationBuilder(widget: const SignupPage()),
                        );
                      },
                    ),
                  ),
                  Measure.g_16,
                  Padding(
                    padding: Measure.p_h32,
                    child: SecondaryRoundedButton(
                      text: 'Log in',
                      onTap: () async {
                        await Navigator.push<dynamic>(
                          context,
                          _fadeAnimationBuilder(widget: const LoginPage()),
                        );
                      },
                    ),
                  ),
                  Measure.g_16,
                  Consumer(builder: (context, ref, child) {
                    return IconButton(
                      onPressed: () {
                        ref.read(themeNotifierProvider.notifier).toggleTheme();
                      },
                      icon: Icon(
                        theme == Palette.darkModeAppTheme
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PageRouteBuilder<dynamic> _fadeAnimationBuilder({required Widget widget}) {
  return PageRouteBuilder<dynamic>(
    transitionDuration: const Duration(milliseconds: 400),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) {
      // 表示する画面のWidget
      return widget;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // 遷移時のアニメーションを指定
      const begin = 0.0;
      const end = 1.0;
      final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: Curves.easeInOut));
      final doubleAnimation = animation.drive<double>(tween);
      return FadeTransition(
        opacity: doubleAnimation,
        child: child,
      );
    },
  );
}

class _AppTitleText extends StatelessWidget {
  const _AppTitleText();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '緊急時用メッセンジャー',
        style: TextStyles.h2(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
