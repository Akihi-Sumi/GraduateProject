import 'package:auto_route/auto_route.dart';
import 'package:graduate_app/page/group/group_chat_page.dart';
import 'package:graduate_app/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: AuthRoute.page,
          children: [
            AutoRoute(
              page: GetStartedRoute.page,
              path: 'start',
            ),
            AutoRoute(
              page: LoginRoute.page,
              path: 'login',
            ),
            AutoRoute(
              page: SignupRoute.page,
              path: 'signup',
            ),
            AutoRoute(
              path: '',
              page: RootRoute.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: HomeRouterRoute.page,
                  title: (ctx, _) => "ホーム",
                  children: [
                    AutoRoute(
                      initial: true,
                      page: HomeRoute.page,
                      title: (ctx, _) => "ホーム",
                    ),
                  ],
                ),
                AutoRoute(
                  path: 'search',
                  page: SearchRouterRoute.page,
                  title: (ctx, _) => "検索",
                  children: [
                    AutoRoute(
                      initial: true,
                      page: SearchRoute.page,
                      title: (ctx, _) => "検索",
                    ),
                  ],
                ),
                AutoRoute(
                  //initial: true,
                  page: GroupRoute.page,
                  title: (ctx, _) => "グループ",
                ),
              ],
            ),
            AutoRoute(
              path: 'settings',
              page: SettingsRouterRoute.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: SettingsRoute.page,
                  title: (ctx, _) => "設定",
                ),
                AutoRoute(
                  path: 'edit-message',
                  page: EditMessageRoute.page,
                  title: (ctx, _) => "メッセージ設定",
                ),
                AutoRoute(
                  path: 'my-page',
                  page: MyProfileRoute.page,
                  title: (ctx, _) => "マイページ",
                ),
                AutoRoute(
                  path: 'survival-kit',
                  page: SurvivalKitRoute.page,
                  title: (ctx, _) => "防災グッズ リスト",
                ),
              ],
            ),
            AutoRoute(
              path: GroupChatPage.path,
              page: GroupChatRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '*',
          page: NotFoundRoute.page,
        ),
        RedirectRoute(
          path: '*',
          redirectTo: '/',
        ),
      ];
}
