// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:graduate_app/ui/home_screen.dart' as _i1;
import 'package:graduate_app/ui/main_screen.dart' as _i2;
import 'package:graduate_app/ui/relationshipPage.dart' as _i3;
import 'package:graduate_app/ui/settings/address.dart' as _i4;
import 'package:graduate_app/ui/settings/edit_message.dart' as _i5;
import 'package:graduate_app/ui/settings/mypage.dart' as _i6;
import 'package:graduate_app/ui/settings/survival_kit.dart' as _i7;
import 'package:graduate_app/ui/settings_screen.dart' as _i8;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreenPage(),
      );
    },
    MainScreenRoute.name: (routeData) {
      final args = routeData.argsAs<MainScreenRouteArgs>(
          orElse: () => const MainScreenRouteArgs());
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.MainScreenPage(key: args.key),
      );
    },
    RelationshipRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.RelationshipPage(),
      );
    },
    AddressRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AddressPage(),
      );
    },
    EditMessageRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.EditMessagePage(),
      );
    },
    MyRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.MyPage(),
      );
    },
    SurvivalKitRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SurvivalKitPage(),
      );
    },
    SettingsRouterRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsRouterRouteArgs>(
          orElse: () => const SettingsRouterRouteArgs());
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.SettingsRouterPage(key: args.key),
      );
    },
    SettingsScreenRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SettingsScreenPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeScreenPage]
class HomeScreenRoute extends _i9.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MainScreenPage]
class MainScreenRoute extends _i9.PageRouteInfo<MainScreenRouteArgs> {
  MainScreenRoute({
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          MainScreenRoute.name,
          args: MainScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MainScreenRoute';

  static const _i9.PageInfo<MainScreenRouteArgs> page =
      _i9.PageInfo<MainScreenRouteArgs>(name);
}

class MainScreenRouteArgs {
  const MainScreenRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'MainScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.RelationshipPage]
class RelationshipRoute extends _i9.PageRouteInfo<void> {
  const RelationshipRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RelationshipRoute.name,
          initialChildren: children,
        );

  static const String name = 'RelationshipRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AddressPage]
class AddressRoute extends _i9.PageRouteInfo<void> {
  const AddressRoute({List<_i9.PageRouteInfo>? children})
      : super(
          AddressRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EditMessagePage]
class EditMessageRoute extends _i9.PageRouteInfo<void> {
  const EditMessageRoute({List<_i9.PageRouteInfo>? children})
      : super(
          EditMessageRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditMessageRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MyPage]
class MyRoute extends _i9.PageRouteInfo<void> {
  const MyRoute({List<_i9.PageRouteInfo>? children})
      : super(
          MyRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SurvivalKitPage]
class SurvivalKitRoute extends _i9.PageRouteInfo<void> {
  const SurvivalKitRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SurvivalKitRoute.name,
          initialChildren: children,
        );

  static const String name = 'SurvivalKitRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SettingsRouterPage]
class SettingsRouterRoute extends _i9.PageRouteInfo<SettingsRouterRouteArgs> {
  SettingsRouterRoute({
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          SettingsRouterRoute.name,
          args: SettingsRouterRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SettingsRouterRoute';

  static const _i9.PageInfo<SettingsRouterRouteArgs> page =
      _i9.PageInfo<SettingsRouterRouteArgs>(name);
}

class SettingsRouterRouteArgs {
  const SettingsRouterRouteArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'SettingsRouterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.SettingsScreenPage]
class SettingsScreenRoute extends _i9.PageRouteInfo<void> {
  const SettingsScreenRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SettingsScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsScreenRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
