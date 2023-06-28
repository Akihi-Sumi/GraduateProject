import 'package:auto_route/auto_route.dart';
import 'package:graduate_app/app/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: AuthWrapperRoute.page,
          initial: true,
          children: [
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
              page: MainScreenRoute.page,
              children: [
                AutoRoute(
                  path: 'home',
                  page: HomeScreenRoute.page,
                  title: (ctx, _) => 'ホーム',
                ),
                AutoRoute(
                  path: 'relationship',
                  page: RelationshipRoute.page,
                  title: (ctx, _) => 'つながり',
                ),
                AutoRoute(
                  path: 'settings',
                  page: SettingsRouterRoute.page,
                  title: (ctx, _) => '設定',
                  children: [
                    AutoRoute(
                      page: SettingsScreenRoute.page,
                      title: (ctx, _) => '設定',
                    ),
                    AutoRoute(
                      page: EditMessageRoute.page,
                      title: (ctx, _) => 'メッセージ設定',
                    ),
                    AutoRoute(
                      page: AddressRoute.page,
                      title: (ctx, _) => '連絡先',
                    ),
                    AutoRoute(
                      page: SurvivalKitRoute.page,
                      title: (ctx, _) => '防災グッズチェックリスト',
                    ),
                    AutoRoute(
                      page: MyRoute.page,
                      title: (ctx, _) => '個人設定',
                    ),
                  ],
                ),
              ],
            ),
            RedirectRoute(
              path: '*',
              redirectTo: '/',
            ),
          ],
        ),
        RedirectRoute(
          path: '*',
          redirectTo: '/',
        ),
      ];
}
