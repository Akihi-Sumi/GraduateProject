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
      title: 'Emergency Messenger',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          accentColor: Colors.orange.shade700,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.transparent,
      ),
    );
  }
}
