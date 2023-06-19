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
          RelationshipRoute(),
          SettingsScreenRoute()
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (int index) {
              if (tabsRouter.activeIndex != index) {
                tabsRouter.setActiveIndex(index);
              } else {
                tabsRouter
                    .innerRouterOf<StackRouter>(tabsRouter.current.name)
                    ?.popUntilRoot();
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "ホーム",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group_outlined),
                activeIcon: Icon(Icons.group),
                label: "つながり",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: "設定",
              ),
            ],
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          );
        },
      ),
      //),
    );
  }
}
