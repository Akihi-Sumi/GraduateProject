import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/app/app_router.gr.dart';

@RoutePage()
class MainScreenPage extends StatefulWidget {
  MainScreenPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class RouteDestination {
  final PageRouteInfo route;
  final IconData icon;
  final String label;

  const RouteDestination({
    required this.route,
    required this.icon,
    required this.label,
  });
}

class _MainScreenPageState extends State<MainScreenPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsRouter(
        routes: const [
          HomeScreenRoute(),
          RelationshipRoute(),
          SettingsScreenRoute()
        ],
        builder: (context, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                title: Text(
                  context.topRoute.title(context),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
                leading: AutoLeadingButton(ignorePagelessRoutes: true),
                backgroundColor: Colors.black,
              ),
            ),
            body: child,
            bottomNavigationBar: buildBottomNav(context, context.tabsRouter),
          );
        },
      ),
    );
  }

  Widget buildBottomNav(BuildContext context, TabsRouter tabsRouter) {
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
      selectedItemColor: Colors.orange[700],
    );
  }
}
