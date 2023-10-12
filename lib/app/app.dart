import 'package:flutter/material.dart';
import 'package:graduate_app/app/app_router.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends HookConsumerWidget {
  App({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      //routerDelegate: _appRouter.delegate(),
      routerConfig: _appRouter.config(),
      title: 'Emergency Messenger App',
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeNotifierProvider),
      scaffoldMessengerKey: ref.watch(scaffoldMessengerKeyProvider),
    );
  }
}
