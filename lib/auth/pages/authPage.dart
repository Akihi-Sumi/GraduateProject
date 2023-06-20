import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/auth/pages/loginOrSignup.dart';
import 'package:graduate_app/ui/main_screen.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainScreenPage();
          } else {
            return const LoginOrSignup();
          }
        },
      ),
    );
  }
}
