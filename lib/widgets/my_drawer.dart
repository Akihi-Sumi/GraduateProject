import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/controller/auth.dart';
import 'package:graduate_app/controller/group_controller/groups.dart';
import 'package:graduate_app/controller/user_profile/user.dart';
import 'package:graduate_app/models/user/user_model.dart';
import 'package:graduate_app/page/group/create_group_page.dart';
import 'package:graduate_app/page/group/group_info_card.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/widgets/imitation_list_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyDrawer extends HookConsumerWidget {
  const MyDrawer({
    Key? key,
    required this.toSettings,
    required this.user,
  }) : super(key: key);

  final Function()? toSettings;

  final ReadUser? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );

    final userId = ref.watch(userIdProvider)!;
    final userImage = ref.watch(userImageProfileProvider(userId));

    final theme = ref.watch(themeNotifierProvider);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  if (userImage != '')
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(userImage),
                    ),
                  if (userImage == '')
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Palette.appColor,
                      child: Icon(
                        Icons.person_sharp,
                        color: Theme.of(context).iconTheme.color,
                        size: 120,
                      ),
                    ),
                  Gap(10),
                  Text(
                    appUserName ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text("グループ", style: TextStyle(fontSize: 26)),
                      leading: Icon(Icons.group),
                      children: <Widget>[
                        ref.watch(groupsStreamProvider(userId)).when(
                              data: (groups) => ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: groups.length,
                                itemBuilder: (context, index) {
                                  final group = groups[index];
                                  return ImitationListTile(
                                    title: Text(
                                      group.groupName,
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    leading: CircleAvatar(
                                      backgroundColor: Palette.appColor,
                                      child: Icon(
                                        Icons.groups,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return GroupInfoCard(
                                            groupName: group.groupName,
                                          );
                                        },
                                      );
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                              error: (error, stackTrace) =>
                                  ErrorText(error: error.toString()),
                              loading: () => const OverlayLoadingWidget(),
                            ),
                        TextButton(
                          child: Text("グループを作成",
                              style: TextStyle(
                                  color: Colors.orange, fontSize: 16)),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateGroupPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ImitationListTile(
                    title: Text("設定", style: TextStyle(fontSize: 24)),
                    leading: Icon(Icons.settings),
                    onTap: toSettings,
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return IconButton(
                  onPressed: () {
                    ref.read(themeNotifierProvider.notifier).toggleTheme();
                  },
                  icon: Icon(
                    theme == Palette.darkModeAppTheme
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class MyAccountIcon extends StatelessWidget {
//   const MyAccountIcon({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Image(
//       image: AssetImage('assets/images/account_dark.png'),
//       width: 180,
//     );
//   }
// }

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key, required this.error}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
