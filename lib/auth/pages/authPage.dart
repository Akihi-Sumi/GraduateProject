import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/auth/pages/loginPage.dart';
import 'package:graduate_app/auth/pages/signupPage.dart';
import 'package:graduate_app/ui/main_screen.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainScreenPage();
          } else {
            return showLoginPage
                ? LoginPage(
                    onTap: togglePage,
                  )
                : SignUpPage(
                    onTap: togglePage,
                  );
          }
        },
      ),
    );
  }
}
