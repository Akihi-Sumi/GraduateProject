import 'package:flutter/material.dart';
import 'package:graduate_app/controller/group.dart';
import 'package:graduate_app/controllers/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GroupInfoPage extends ConsumerWidget {
  const GroupInfoPage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);

    return Scaffold(
      body: ref.watch(getGroupByNameProvider(name)).when(
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
                                        onPressed: () {},
                                        child: Text(
                                          "モデレーターツール",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      )
                                    : OutlinedButton(
                                        child: Text(
                                          group.members.contains(userId)
                                              ? "参加済み"
                                              : "参加",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                group.members.contains(userId)
                                                    ? Colors.blue
                                                    : Colors.orangeAccent,
                                          ),
                                        ),
                                        onPressed: () {
                                          group.members.contains(userId)
                                              ? null
                                              : print("debug");
                                        },
                                      ),
                              ],
                            ),
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
