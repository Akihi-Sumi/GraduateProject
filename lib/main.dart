import 'package:flutter/material.dart';
import 'package:graduate_app/router/app_router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Circular Bottom Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //   home: GestureDetector(
      //     // use this property to change direction in whole app
      //     // CircularBottomNavigation will act accordingly
      //     onTap: () => primaryFocus?.unfocus(),
      //     //textDirection: TextDirection.ltr,
      //     child: MainScreenPage(title: 'circular_bottom_navigation'),
      //   ),
    );
  }
}
