import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/app/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.handleConnectivity();

    return Scaffold(
      body: ref.watch(authUserProvider).when(
        data: (data) {
          if (data != null) {
            context.router.replaceAll([MainScreenRoute()]);
          } else {
            //return const GetStartedPage();
          }
        },
        error: (error, stackTrace) {
          //return const ErrorPage();
        },
        loading: () {
          //return const OverlayLoadingWidget();
        },
      ),
    );
  }
}
