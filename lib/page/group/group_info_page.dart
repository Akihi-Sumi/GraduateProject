import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/group.dart';
import 'package:graduate_app/controllers/auth.dart';
import 'package:graduate_app/models/group/group_model.dart';
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

@RoutePage()
class GroupInfoPage extends ConsumerWidget {
  const GroupInfoPage({
    Key? key,
    @PathParam('groupName') required this.groupName,
  }) : super(key: key);

  //final String name;

  static const path = 'search/:groupName';

  static String location({required String groupName}) => 'search/$groupName';

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

    return Scaffold(
      body: ref.watch(getGroupByNameProvider(groupName)).when(
            data: (group) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 150,
                      floating: true,
                      snap: true,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(13),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Align(
                              alignment: Alignment.topLeft,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.amber,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  group.groupName,
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
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
                                          "モデレーターツール",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
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
                                            color:
                                                group.members.contains(userId)
                                                    ? Colors.redAccent
                                                    : Colors.blueAccent,
                                          ),
                                        ),
                                        onPressed: () {
                                          joinOrLeaveGroup(ref, group, context);
                                        },
                                      ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "${group.members.length} 人のメンバーが参加しています",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: FutureBuilder<List<Widget>>(
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
                            )
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: SizedBox(),
              );
            },
            error: (error, stackTrace) => Text("error"),
            loading: () => CircularProgressIndicator(),
          ),
    );
  }
}
