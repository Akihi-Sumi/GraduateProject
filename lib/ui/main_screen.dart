import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/router/app_router.dart';

@RoutePage()
class MainScreenPage extends StatelessWidget {
  MainScreenPage({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsScaffold(
        routes: const [
          HomeScreenRoute(),
          WeatherRoute(),
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
            backgroundColor: Colors.orange.shade700,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sunny),
                label: "Weather",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_sharp),
                label: "Settings",
              ),
            ],
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            selectedItemColor: Colors.white,
          );
        },
      ),
    );
  }
}
