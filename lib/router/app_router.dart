import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/ui/home_screen.dart';
import 'package:graduate_app/ui/main_screen.dart';
import 'package:graduate_app/ui/settings_screen.dart';
import 'package:graduate_app/ui/weather_earthquake.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            path: '/main',
            initial: true,
            page: MainScreenRoute.page,
            children: [
              AutoRoute(
                path: 'home',
                page: HomeScreenRoute.page,
              ),
              AutoRoute(
                path: 'weather',
                page: WeatherRoute.page,
              ),
              AutoRoute(
                path: 'settings',
                page: SettingsScreenRoute.page,
              )
            ])
      ];
}
