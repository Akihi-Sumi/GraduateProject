import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/ui/auth/error_page.dart';
import 'package:graduate_app/ui/auth/get_started_page.dart';
import 'package:graduate_app/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.handleConnectivity();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ref.watch(authUserProvider).when(
        data: (data) {
          if (data != null) {
            return AutoRouter();
          } else {
            return GetStartedPage();
          }
        },
        error: (error, stackTrace) {
          return const ErrorPage();
        },
        loading: () {
          return const OverlayLoadingWidget();
        },
      ),
    );
  }
}
