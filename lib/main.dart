import 'package:flutter/material.dart';
import 'package:graduate_app/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authService = AuthService();
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Emergency Messenger',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.transparent,
      ),
      // builder: (_, router) {
      //   return ChangeNotifierProvider<AuthService>(
      //     create: (_) => authService,
      //   );
      // },
    );
  }
}
