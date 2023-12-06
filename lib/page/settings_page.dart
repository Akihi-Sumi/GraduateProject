import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/controller/auth/sign_out.dart';
import 'package:graduate_app/page/settings/mypage.dart';
import 'package:graduate_app/repositories/survival_kits/list_collection_repository.dart';
import 'package:graduate_app/router/app_router.gr.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/dialog.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:graduate_app/widgets/imitation_list_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SettingsRouterPage extends AutoRouter {
  SettingsRouterPage({super.key});
}

@RoutePage()
class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const path = 'settings';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      signOutControllerProvider,
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
                .showSnackBar('ログアウトしました。');

            await AutoRouter.of(context).replaceAll([AuthRoute()]);
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
    final state = ref.watch(signOutControllerProvider);

    final ItemRepository itemRepository = ItemRepository();

    final userId = ref.watch(appUserFutureProvider).maybeWhen(
          data: (data) => data?.userId,
          orElse: () => null,
        );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            context.topRoute.title(context),
          ),
          leading: BackButton(
            onPressed: () => context.popRoute(),
          ),
        ),
      ),
      body: Column(
        children: [
          ImitationListTile(
            title: Text("アカウント", style: TextStyle(fontSize: 24)),
            leading: Icon(Icons.account_circle, size: 30),
            onTap: () => context.router.pushNamed(MyProfilePage.location(
              userId: userId ?? '',
            )),
          ),
          ImitationListTile(
            title: Text("メッセージ", style: TextStyle(fontSize: 24)),
            leading: Icon(Icons.message, size: 30),
            onTap: () => context.router.push(EditMessageRoute()),
          ),
          ImitationListTile(
            title: Text("防災グッズ", style: TextStyle(fontSize: 24)),
            leading: Icon(Icons.medical_services, size: 30),
            onTap: () => context.pushRoute(
              SurvivalKitRoute(itemRepository: itemRepository),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              await showActionDialog(
                context: context,
                title: 'ログアウトしますか？',
                buttonText: "ログアウト",
                onPressed: state.isLoading
                    ? null
                    : () async {
                        await ref
                            .read(signOutControllerProvider.notifier)
                            .signOut();
                      },
              );
            },
            child: Text(
              "ログアウト",
              style: TextStyle(fontSize: 18, color: Colors.deepOrange),
            ),
          ),
        ],
      ),
    );
  }
}
