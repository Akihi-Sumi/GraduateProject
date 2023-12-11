import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/user_profile/user.dart';
import 'package:graduate_app/page/auth/auth_dependent_builder.dart';
import 'package:graduate_app/page/settings/edit_profile_mobile.dart';
import 'package:graduate_app/page/settings/edit_profile_web.dart';
import 'package:graduate_app/utils/enum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MyProfilePage extends ConsumerWidget {
  const MyProfilePage({
    Key? key,
    @PathParam('userId') required this.userId,
  }) : super(key: key);

  static const path = 'settings/:userId';
  static String location({required String userId}) => 'settings/$userId';

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    final userAsyncValue = ref.watch(userFutureProvider(userId));
    final user = userAsyncValue.valueOrNull;
    final isLoading = userAsyncValue.isLoading;

    if (user == null) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            title: Text(
              context.topRoute.title(context),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            leading: BackButton(
              onPressed: () => context.popRoute(),
            ),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Center(
                child: Text("ユーザーが存在しません。"),
              ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            title: Text(
              context.topRoute.title(context),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            leading: BackButton(
              onPressed: () => context.popRoute(),
            ),
          ),
        ),
        body: UserAuthDependentBuilder(
          userId: userId,
          onAuthenticated: (userId, isUserAuthenticated) {
            if (!isUserAuthenticated) {
              return const Center(
                child: Text("このユーザーは編集できません。"),
              );
            }
            if (!kIsWeb) {
              return EditProfileMobile(
                userId: userId,
                user: user,
              );
            } else {
              if (screenWidth > 700) {
                return EditProfileWeb(
                  key: const ValueKey('desktop'),
                  userId: userId,
                  user: user,
                  displayStyle: PageDisplayStyle.desktop,
                );
              } else {
                return EditProfileWeb(
                  key: const ValueKey('mobile'),
                  userId: userId,
                  user: user,
                  displayStyle: PageDisplayStyle.mobile,
                );
              }
            }
          },
        ),
      ),
    );
  }
}
