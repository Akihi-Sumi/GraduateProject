import 'package:flutter/material.dart';
import 'package:graduate_app/controller/auth.dart';
import 'package:graduate_app/page/auth/sign_in_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthDependentBuilder extends ConsumerWidget {
  const AuthDependentBuilder({
    super.key,
    required this.onAuthenticated,
    this.onUnAuthenticated,
  });

  final Widget Function(String userId) onAuthenticated;
  final Widget Function()? onUnAuthenticated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    if (userId == null) {
      if (onUnAuthenticated != null) {
        return onUnAuthenticated!();
      } else {
        return const SignedOut();
      }
    }
    return onAuthenticated(userId);
  }
}

class UserAuthDependentBuilder extends ConsumerWidget {
  const UserAuthDependentBuilder({
    super.key,
    required this.userId,
    required this.onAuthenticated,
    this.onUnAuthenticated,
  });

  final Widget Function(String userId, bool isUserAuthenticated)
      onAuthenticated;
  final Widget Function()? onUnAuthenticated;

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    if (userId == null) {
      if (onUnAuthenticated != null) {
        return onUnAuthenticated!();
      } else {
        return const SignedOut();
      }
    }
    return onAuthenticated(userId, userId == this.userId);
  }
}
