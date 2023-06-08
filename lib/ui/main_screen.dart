import 'package:flutter/material.dart';
import 'package:graduate_app/ui/home_screen.dart';
import 'package:graduate_app/ui/settings_screen.dart';
import 'package:graduate_app/ui/weather_earthquake.dart';

import 'navbar/circular_bottom_navigation.dart';
import 'navbar/tab_item.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.home,
      "Home",
      Colors.black,
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.sunny,
      "Weather",
      Colors.black,
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    TabItem(
      Icons.settings_sharp,
      "Settings",
      Colors.black,
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ]);

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: bottomNavBarHeight),
              child: bodyContainer(),
            ),
            Align(alignment: Alignment.bottomCenter, child: bottomNav())
          ],
        ),
      ),
    );
  }

  Widget bodyContainer() {
    // Color? selectedColor = tabItems[selectedPos].circleColor;
    switch (selectedPos) {
      case 0:
        return HomeScreen();
      case 1:
        return MessageScreen();
      case 2:
        return SettingsScreenPage();
      default:
        return HomeScreen();
    }
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.orange.shade700,
      backgroundBoxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
          print(_navigationController.value);
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
