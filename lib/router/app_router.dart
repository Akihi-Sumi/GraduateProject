import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/auth/pages/authPage.dart';
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
      router.push(
        AuthRoute(
            //resolver.next();
            ),
      );
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
          path: '/auth',
          page: AuthRoute.page,
          initial: true,
          keepHistory: false,
        ),
        AutoRoute(
            path: '/main',
            //initial: true,
            page: MainScreenRoute.page,
            // guards: [
            //   authGuard
            // ],
            children: [
              AutoRoute(
                path: 'home',
                page: HomeScreenRoute.page,
              ),
              AutoRoute(
                path: 'friends',
                page: RelationshipRoute.page,
              ),
              AutoRoute(
                  path: 'settings',
                  page: SettingsRouterRoute.page,
                  children: [
                    AutoRoute(page: SettingsScreenRoute.page, initial: false),
                    AutoRoute(page: EditMessageRoute.page),
                    AutoRoute(page: AddressRoute.page),
                    AutoRoute(page: SurvivalKitRoute.page),
                    AutoRoute(page: MyRoute.page),
                  ])
            ])
      ];
}
