import 'package:flutter/material.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/controller/group.dart';
import 'package:graduate_app/page/group/create_group_page.dart';
import 'package:graduate_app/page/group/send_message_page.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/widgets/imitation_list_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyDrawer extends HookConsumerWidget {
  const MyDrawer({Key? key, required this.toSettings}) : super(key: key);

  final Function()? toSettings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),
            MyAccountIcon(),
            const SizedBox(height: 15),
            Text(
              appUserName ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text("グループ", style: TextStyle(fontSize: 26)),
                textColor: Colors.white,
                leading: Icon(Icons.group, color: Colors.white),
                iconColor: Colors.white,
                children: <Widget>[
                  ref.watch(groupsProvider).when(
                        data: (groups) =>
                            // Expanded(
                            //   child:
                            ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: groups.length,
                          itemBuilder: (context, index) {
                            final group = groups[index];
                            return ImitationListTile(
                              title: Text(group.groupName,
                                  style: TextStyle(fontSize: 24)),
                              leading: CircleAvatar(),
                              onTap: () {
                                Navigator.of(context).pop();
                                // グループ画面へ
                              },
                            );
                          },
                        ),
                        //),
                        error: (error, stackTrace) =>
                            ErrorText(error: error.toString()),
                        loading: () => const OverlayLoadingWidget(),
                      ),
                  TextButton(
                    child: Text("グループを作成",
                        style: TextStyle(color: Colors.orange, fontSize: 16)),
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
            )
          ],
        ),
      ),
    );
  }
}

class MyAccountIcon extends StatelessWidget {
  const MyAccountIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 60,
        ),
        RawMaterialButton(
          shape: CircleBorder(),
          elevation: 0.0,
          child: SizedBox(width: 120, height: 120),
          onPressed: () {
            // ユーザー画面へ
          },
        ),
      ],
    );
  }
}
