import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class RootNavigationBar extends StatelessWidget {
  const RootNavigationBar({Key? key, required this.tabsRouter})
      : super(key: key);

  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
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
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: "検索",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group_outlined),
          activeIcon: Icon(Icons.group),
          label: "グループ",
        ),
      ],
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      selectedItemColor: Colors.orange[700],
    );
  }
}
