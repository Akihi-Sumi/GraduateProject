import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/group.dart';
import 'package:graduate_app/controllers/auth.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<String?> fetchUserData(String userId) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final userDocs =
      await db.collection("appUsers").where("userId", isEqualTo: userId).get();
  if (userDocs.docs.isNotEmpty) {
    var userData = userDocs.docs.first.data();
    String userName = userData["userName"];
    return userName;
  } else {
    return null;
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

class GroupInfoCard extends StatelessWidget {
  const GroupInfoCard({Key? key, required this.groupName}) : super(key: key);

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ContentBox(
        groupName: groupName,
      ),
    );
  }
}

class ContentBox extends ConsumerWidget {
  const ContentBox({super.key, required this.groupName});

  final String groupName;

  void joinOrLeaveGroup(WidgetRef ref, GroupModel group, BuildContext context) {
    ref.read(groupControllerProvider.notifier).joinOrLeaveGroup(group, context);
  }

  Future<List<Widget>> _fetchUserDataForGroupMembers(
      List<String> members) async {
    List<Widget> userDataWidgets = [];
    for (var member in members) {
      String? userData = await fetchUserData(member);
      if (userData != null) {
        userDataWidgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              userData,
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    }
    return userDataWidgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: Constants.padding,
            top: Constants.avatarRadius + Constants.padding,
            right: Constants.padding,
            bottom: Constants.padding,
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: ref.watch(getGroupByNameProvider(groupName)).when(
                data: (group) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        group.groupName,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Measure.g_12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (group.members.contains(userId))
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.message_outlined,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          group.mods.contains(userId)
                              ? OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "管理者ツール",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellowAccent,
                                    ),
                                  ),
                                )
                              : OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Text(
                                    group.members.contains(userId)
                                        ? "退会"
                                        : "参加",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: group.members.contains(userId)
                                          ? Colors.redAccent
                                          : Colors.greenAccent,
                                    ),
                                  ),
                                  onPressed: () {
                                    joinOrLeaveGroup(ref, group, context);
                                  },
                                ),
                        ],
                      ),
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: ExpansionTile(
                            title: Text("${group.members.length} 人のメンバーが参加"),
                            textColor: Colors.white,
                            iconColor: Colors.white,
                            children: <Widget>[
                              FutureBuilder<List<Widget>>(
                                future: _fetchUserDataForGroupMembers(
                                    group.members),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text("Error: ${snapshot.error}");
                                  } else if (snapshot.hasData) {
                                    return Column(children: snapshot.data!);
                                  } else {
                                    return Text("メンバーが居ません");
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("閉じる"),
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) => Text("error"),
                loading: () => CircularProgressIndicator(),
              ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(Constants.avatarRadius),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
