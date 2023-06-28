import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_app/app/app_router.gr.dart';
import 'package:graduate_app/features/auth/cubits/auth_cubit.dart';

@RoutePage()
class AuthWrapperPage extends StatelessWidget {
  const AuthWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AuthWrapperView();
  }
}

class AuthWrapperView extends StatelessWidget {
  const AuthWrapperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) => state.map(
        unauthenticated: (_) {
          //AutoRouter.of(context).replaceAll([const SignupRoute()]);
          context.router.replaceAll([const SignupRoute()]);
          return null;
        },
        authenticated: (state) {
          if (state.user != null) {
            //AutoRouter.of(context).replaceAll([const ChatsRoute()]);
            context.router.replaceAll([MainScreenRoute()]);
          } else {
            //AutoRouter.of(context).replaceAll([const SignupRoute()]);
            context.router.replaceAll([const SignupRoute()]);
          }
          return null;
        },
      ),
      child: const AutoRouter(),
    );
  }
}
