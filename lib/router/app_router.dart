import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/auth/pages/authPage.dart';
import 'package:graduate_app/auth/pages/signupPage.dart';
import 'package:graduate_app/ui/home_screen.dart';
import 'package:graduate_app/ui/main_screen.dart';
import 'package:graduate_app/ui/relationshipPage.dart';
import 'package:graduate_app/ui/settings/address.dart';
import 'package:graduate_app/ui/settings/edit_message.dart';
import 'package:graduate_app/ui/settings/mypage.dart';
import 'package:graduate_app/ui/settings/survival_kit.dart';
import 'package:graduate_app/ui/settings_screen.dart';

part 'app_router.gr.dart';

var isAuthenticated = false;

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    if (!isAuthenticated) {
      router.replaceAll([AuthRoute()]);
    } else {
      resolver.next(true);
    }
  }
}

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  set isAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: AuthRoute.page,
          //initial: true,
          keepHistory: false,
          children: [
            AutoRoute(
              page: LoginRoute.page,
              path: 'login',
            ),
            AutoRoute(
              page: SignUpRoute.page,
              path: 'signup',
            ),
            AutoRoute(
              path: 'main',
              initial: true,
              page: MainScreenRoute.page,
              guards: [AuthGuard()],
              children: [
                RedirectRoute(path: '', redirectTo: 'home'),
                AutoRoute(
                  path: 'home',
                  page: HomeScreenRoute.page,
                  maintainState: true,
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
          ],
        ),
      ];
}
