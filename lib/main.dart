import 'package:flutter/material.dart';

import 'ui/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Bottom Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureDetector(
        // use this property to change direction in whole app
        // CircularBottomNavigation will act accordingly
        onTap: () => primaryFocus?.unfocus(),
        //textDirection: TextDirection.ltr,
        child: MainScreen(title: 'circular_bottom_navigation'),
      ),
    );
  }
}
