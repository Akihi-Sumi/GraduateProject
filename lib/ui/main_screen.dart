import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/app/app_router.gr.dart';
import 'package:graduate_app/features/features.dart';
import 'package:graduate_app/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MainScreenPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      signOutControllerProvider,
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
                .showSnackBar('Complete to log out!');

            await AutoRouter.of(context).replaceAll([AuthRoute()]);
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
    final state = ref.watch(signOutControllerProvider);

    return AutoTabsRouter(
      routes: const [
        HomeScreenRoute(),
        RelationshipRoute(),
        SettingsScreenRoute()
      ],
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                title: Text(
                  context.topRoute.title(context),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
                leading: AutoLeadingButton(ignorePagelessRoutes: true),
                actions: [
                  IconButton(
                    onPressed: () async {
                      await showActionDialog(
                        context: context,
                        title: 'Log Out',
                        content: 'Do you want to log out ?',
                        onPressed: state.isLoading
                            ? null
                            : () async {
                                await ref
                                    .read(signOutControllerProvider.notifier)
                                    .signOut();
                              },
                      );
                    },
                    icon: Icon(Icons.logout),
                  ),
                ],
                backgroundColor: Colors.black,
              ),
            ),
            body: child,
            bottomNavigationBar: buildBottomNav(context, context.tabsRouter),
          ),
        );
      },
    );
  }

  Widget buildBottomNav(BuildContext context, TabsRouter tabsRouter) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: tabsRouter.activeIndex,
      onTap: (int index) {
        if (tabsRouter.activeIndex != index) {
          tabsRouter.setActiveIndex(index);
        } else {
          tabsRouter
              .innerRouterOf<StackRouter>(tabsRouter.current.name)
              ?.popUntilRoot();
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "ホーム",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group_outlined),
          activeIcon: Icon(Icons.group),
          label: "つながり",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: "設定",
        ),
      ],
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      selectedItemColor: Colors.orange[700],
    );
  }
}
