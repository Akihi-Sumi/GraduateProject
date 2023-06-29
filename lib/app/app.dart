import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_app/app/app_router.dart';
import 'package:graduate_app/features/features.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp.router(
        //routerDelegate: _appRouter.delegate(),
        routerConfig: _appRouter.config(),
        title: 'Emergency Messenger App',
        debugShowCheckedModeBanner: false,
        builder: (_, child) => _Unfocused(child: child!),
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          canvasColor: Colors.transparent,
        ),
      ),
    );
  }
}

// Wrap widgets in `_Unfocus` to enable the user
// to unfocus the keyboard by tapping anywhere.
class _Unfocused extends StatelessWidget {
  const _Unfocused({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
