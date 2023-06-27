// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpPage(
          key: args.key,
          onTap: args.onTap,
        ),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreenPage(),
      );
    },
    MainScreenRoute.name: (routeData) {
      final args = routeData.argsAs<MainScreenRouteArgs>(
          orElse: () => const MainScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MainScreenPage(key: args.key),
      );
    },
    RelationshipRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RelationshipPage(),
      );
    },
    AddressRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddressPage(),
      );
    },
    EditMessageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditMessagePage(),
      );
    },
    MyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyPage(),
      );
    },
    SurvivalKitRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SurvivalKitPage(),
      );
    },
    SettingsRouterRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsRouterRouteArgs>(
          orElse: () => const SettingsRouterRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SettingsRouterPage(key: args.key),
      );
    },
    SettingsScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreenPage(),
      );
    },
  };
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    required dynamic Function()? onTap,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onTap: onTap,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onTap,
  });

  final Key? key;

  final dynamic Function()? onTap;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onTap: $onTap}';
  }
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    Key? key,
    required dynamic Function()? onTap,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(
            key: key,
            onTap: onTap,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<SignUpRouteArgs> page = PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({
    this.key,
    required this.onTap,
  });

  final Key? key;

  final dynamic Function()? onTap;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key, onTap: $onTap}';
  }
}

/// generated route for
/// [HomeScreenPage]
class HomeScreenRoute extends PageRouteInfo<void> {
  const HomeScreenRoute({List<PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreenPage]
class MainScreenRoute extends PageRouteInfo<MainScreenRouteArgs> {
  MainScreenRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MainScreenRoute.name,
          args: MainScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MainScreenRoute';

  static const PageInfo<MainScreenRouteArgs> page =
      PageInfo<MainScreenRouteArgs>(name);
}

class MainScreenRouteArgs {
  const MainScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MainScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [RelationshipPage]
class RelationshipRoute extends PageRouteInfo<void> {
  const RelationshipRoute({List<PageRouteInfo>? children})
      : super(
          RelationshipRoute.name,
          initialChildren: children,
        );

  static const String name = 'RelationshipRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddressPage]
class AddressRoute extends PageRouteInfo<void> {
  const AddressRoute({List<PageRouteInfo>? children})
      : super(
          AddressRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddressRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditMessagePage]
class EditMessageRoute extends PageRouteInfo<void> {
  const EditMessageRoute({List<PageRouteInfo>? children})
      : super(
          EditMessageRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditMessageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MyPage]
class MyRoute extends PageRouteInfo<void> {
  const MyRoute({List<PageRouteInfo>? children})
      : super(
          MyRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SurvivalKitPage]
class SurvivalKitRoute extends PageRouteInfo<void> {
  const SurvivalKitRoute({List<PageRouteInfo>? children})
      : super(
          SurvivalKitRoute.name,
          initialChildren: children,
        );

  static const String name = 'SurvivalKitRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsRouterPage]
class SettingsRouterRoute extends PageRouteInfo<SettingsRouterRouteArgs> {
  SettingsRouterRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SettingsRouterRoute.name,
          args: SettingsRouterRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SettingsRouterRoute';

  static const PageInfo<SettingsRouterRouteArgs> page =
      PageInfo<SettingsRouterRouteArgs>(name);
}

class SettingsRouterRouteArgs {
  const SettingsRouterRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SettingsRouterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SettingsScreenPage]
class SettingsScreenRoute extends PageRouteInfo<void> {
  const SettingsScreenRoute({List<PageRouteInfo>? children})
      : super(
          SettingsScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
