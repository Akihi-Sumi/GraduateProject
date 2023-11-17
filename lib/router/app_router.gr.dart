// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:graduate_app/page/auth/auth_page.dart' as _i1;
import 'package:graduate_app/page/auth/get_started_page.dart' as _i3;
import 'package:graduate_app/page/auth/login_page.dart' as _i7;
import 'package:graduate_app/page/auth/signup_page.dart' as _i13;
import 'package:graduate_app/page/error/not_found_page.dart' as _i9;
import 'package:graduate_app/page/group/group_chat_page.dart' as _i4;
import 'package:graduate_app/page/group_page.dart' as _i5;
import 'package:graduate_app/page/home_page.dart' as _i6;
import 'package:graduate_app/page/search_page.dart' as _i11;
import 'package:graduate_app/page/settings/edit_message.dart' as _i2;
import 'package:graduate_app/page/settings/mypage.dart' as _i8;
import 'package:graduate_app/page/settings/survival_kit.dart' as _i14;
import 'package:graduate_app/page/settings_page.dart' as _i12;
import 'package:graduate_app/router/root_page.dart' as _i10;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthPage(),
      );
    },
    EditMessageRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.EditMessagePage(),
      );
    },
    GetStartedRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.GetStartedPage(),
      );
    },
    GroupChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupChatRouteArgs>(
          orElse: () =>
              GroupChatRouteArgs(groupId: pathParams.getString('groupId')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.GroupChatPage(
          key: args.key,
          groupId: args.groupId,
        ),
      );
    },
    GroupRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.GroupPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomePage(),
      );
    },
    HomeRouterRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomeRouterPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginPage(),
      );
    },
    MyProfileRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.MyProfilePage(),
      );
    },
    NotFoundRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.NotFoundPage(),
      );
    },
    RootRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.RootPage(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.SearchPage(),
      );
    },
    SearchRouterRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.SearchRouterPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.SettingsPage(),
      );
    },
    SettingsRouterRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsRouterRouteArgs>(
          orElse: () => const SettingsRouterRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.SettingsRouterPage(key: args.key),
      );
    },
    SignupRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SignupPage(),
      );
    },
    SurvivalKitRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.SurvivalKitPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i15.PageRouteInfo<void> {
  const AuthRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i2.EditMessagePage]
class EditMessageRoute extends _i15.PageRouteInfo<void> {
  const EditMessageRoute({List<_i15.PageRouteInfo>? children})
      : super(
          EditMessageRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditMessageRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GetStartedPage]
class GetStartedRoute extends _i15.PageRouteInfo<void> {
  const GetStartedRoute({List<_i15.PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.GroupChatPage]
class GroupChatRoute extends _i15.PageRouteInfo<GroupChatRouteArgs> {
  GroupChatRoute({
    _i16.Key? key,
    required String groupId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          GroupChatRoute.name,
          args: GroupChatRouteArgs(
            key: key,
            groupId: groupId,
          ),
          rawPathParams: {'groupId': groupId},
          initialChildren: children,
        );

  static const String name = 'GroupChatRoute';

  static const _i15.PageInfo<GroupChatRouteArgs> page =
      _i15.PageInfo<GroupChatRouteArgs>(name);
}

class GroupChatRouteArgs {
  const GroupChatRouteArgs({
    this.key,
    required this.groupId,
  });

  final _i16.Key? key;

  final String groupId;

  @override
  String toString() {
    return 'GroupChatRouteArgs{key: $key, groupId: $groupId}';
  }
}

/// generated route for
/// [_i5.GroupPage]
class GroupRoute extends _i15.PageRouteInfo<void> {
  const GroupRoute({List<_i15.PageRouteInfo>? children})
      : super(
          GroupRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomeRouterPage]
class HomeRouterRoute extends _i15.PageRouteInfo<void> {
  const HomeRouterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouterRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i15.PageRouteInfo<void> {
  const LoginRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.MyProfilePage]
class MyProfileRoute extends _i15.PageRouteInfo<void> {
  const MyProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          MyProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyProfileRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i9.NotFoundPage]
class NotFoundRoute extends _i15.PageRouteInfo<void> {
  const NotFoundRoute({List<_i15.PageRouteInfo>? children})
      : super(
          NotFoundRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotFoundRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i10.RootPage]
class RootRoute extends _i15.PageRouteInfo<void> {
  const RootRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SearchPage]
class SearchRoute extends _i15.PageRouteInfo<void> {
  const SearchRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SearchRouterPage]
class SearchRouterRoute extends _i15.PageRouteInfo<void> {
  const SearchRouterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SearchRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRouterRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.SettingsPage]
class SettingsRoute extends _i15.PageRouteInfo<void> {
  const SettingsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.SettingsRouterPage]
class SettingsRouterRoute extends _i15.PageRouteInfo<SettingsRouterRouteArgs> {
  SettingsRouterRoute({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          SettingsRouterRoute.name,
          args: SettingsRouterRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SettingsRouterRoute';

  static const _i15.PageInfo<SettingsRouterRouteArgs> page =
      _i15.PageInfo<SettingsRouterRouteArgs>(name);
}

class SettingsRouterRouteArgs {
  const SettingsRouterRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'SettingsRouterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.SignupPage]
class SignupRoute extends _i15.PageRouteInfo<void> {
  const SignupRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SurvivalKitPage]
class SurvivalKitRoute extends _i15.PageRouteInfo<void> {
  const SurvivalKitRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SurvivalKitRoute.name,
          initialChildren: children,
        );

  static const String name = 'SurvivalKitRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
