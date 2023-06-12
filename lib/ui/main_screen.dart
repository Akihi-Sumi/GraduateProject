import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/router/app_router.dart';

@RoutePage()
class MainScreenPage extends StatefulWidget {
  MainScreenPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsScaffold(
        routes: const [
          HomeScreenRoute(),
          FriendsRoute(),
          SettingsScreenRoute()
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: (int index) {
              if (tabsRouter.activeIndex != index) {
                tabsRouter.setActiveIndex(index);
              } else {
                tabsRouter
                    .innerRouterOf<StackRouter>(tabsRouter.current.name)
                    ?.popUntilRoot();
              }
            },
            backgroundColor: Colors.grey[900],
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: Colors.grey),
                selectedIcon: Icon(Icons.home, color: Colors.white),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.group_outlined, color: Colors.grey),
                selectedIcon: Icon(Icons.group, color: Colors.white),
                label: "Friend",
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined, color: Colors.grey),
                selectedIcon: Icon(Icons.settings, color: Colors.white),
                label: "Settings",
              ),
            ],
          );
        },
      ),
    );
  }
}
