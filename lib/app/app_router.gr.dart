// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:graduate_app/ui/auth/auth_page.dart' as _i9;
import 'package:graduate_app/ui/auth/get_started_page.dart' as _i1;
import 'package:graduate_app/ui/auth/login_page.dart' as _i10;
import 'package:graduate_app/ui/auth/signup_page.dart' as _i11;
import 'package:graduate_app/ui/home_screen.dart' as _i2;
import 'package:graduate_app/ui/main_screen.dart' as _i3;
import 'package:graduate_app/ui/relationship_page.dart' as _i12;
import 'package:graduate_app/ui/settings/address.dart' as _i4;
import 'package:graduate_app/ui/settings/edit_message.dart' as _i5;
import 'package:graduate_app/ui/settings/mypage.dart' as _i6;
import 'package:graduate_app/ui/settings/survival_kit.dart' as _i7;
import 'package:graduate_app/ui/settings_screen.dart' as _i8;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    GetStartedRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.GetStartedPage(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreenPage(),
      );
    },
    MainScreenRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.MainScreenPage(),
      );
    },
    AddressRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AddressPage(),
      );
    },
    EditMessageRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.EditMessagePage(),
      );
    },
    MyRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.MyPage(),
      );
    },
    SurvivalKitRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SurvivalKitPage(),
      );
    },
    SettingsRouterRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsRouterRouteArgs>(
          orElse: () => const SettingsRouterRouteArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.SettingsRouterPage(key: args.key),
      );
    },
    SettingsScreenRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SettingsScreenPage(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.AuthPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LoginPage(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.SignupPage(),
      );
    },
    RelationshipRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.RelationshipPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.GetStartedPage]
class GetStartedRoute extends _i13.PageRouteInfo<void> {
  const GetStartedRoute({List<_i13.PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreenPage]
class HomeScreenRoute extends _i13.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MainScreenPage]
class MainScreenRoute extends _i13.PageRouteInfo<void> {
  const MainScreenRoute({List<_i13.PageRouteInfo>? children})
      : super(
          MainScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainScreenRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AddressPage]
class AddressRoute extends _i13.PageRouteInfo<void> {
  const AddressRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AddressRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EditMessagePage]
class EditMessageRoute extends _i13.PageRouteInfo<void> {
  const EditMessageRoute({List<_i13.PageRouteInfo>? children})
      : super(
          EditMessageRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditMessageRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MyPage]
class MyRoute extends _i13.PageRouteInfo<void> {
  const MyRoute({List<_i13.PageRouteInfo>? children})
      : super(
          MyRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SurvivalKitPage]
class SurvivalKitRoute extends _i13.PageRouteInfo<void> {
  const SurvivalKitRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SurvivalKitRoute.name,
          initialChildren: children,
        );

  static const String name = 'SurvivalKitRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SettingsRouterPage]
class SettingsRouterRoute extends _i13.PageRouteInfo<SettingsRouterRouteArgs> {
  SettingsRouterRoute({
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          SettingsRouterRoute.name,
          args: SettingsRouterRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SettingsRouterRoute';

  static const _i13.PageInfo<SettingsRouterRouteArgs> page =
      _i13.PageInfo<SettingsRouterRouteArgs>(name);
}

class SettingsRouterRouteArgs {
  const SettingsRouterRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'SettingsRouterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.SettingsScreenPage]
class SettingsScreenRoute extends _i13.PageRouteInfo<void> {
  const SettingsScreenRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SettingsScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsScreenRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.AuthPage]
class AuthRoute extends _i13.PageRouteInfo<void> {
  const AuthRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LoginPage]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SignupPage]
class SignupRoute extends _i13.PageRouteInfo<void> {
  const SignupRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i12.RelationshipPage]
class RelationshipRoute extends _i13.PageRouteInfo<void> {
  const RelationshipRoute({List<_i13.PageRouteInfo>? children})
      : super(
          RelationshipRoute.name,
          initialChildren: children,
        );

  static const String name = 'RelationshipRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}
