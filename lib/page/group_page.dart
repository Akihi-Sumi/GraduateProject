import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduate_app/controller/group_controller/groups.dart';
import 'package:graduate_app/page/auth/auth_dependent_builder.dart';
import 'package:graduate_app/page/group/group_chat_page.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:graduate_app/utils/extensions/date_time.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class GroupPage extends ConsumerWidget {
  const GroupPage({Key? key}) : super(key: key);

  static const path = 'group';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: AuthDependentBuilder(
          onAuthenticated: ((userId) {
            final readGroups = ref.watch(groupsStreamProvider(userId));
            return readGroups.when(
              data: (groups) {
                if (groups.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(36),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.chat,
                            size: 80,
                          ),
                          const Gap(16),
                          const Text(
                            "グループがありません。\n"
                            "作成するか参加してみましょう",
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    final latestMessage =
                        ref.watch(latestMessageProvider(group.groupId));
                    return GenericGroupCard(
                      title: group.groupName,
                      latestMessage: latestMessage?.content,
                      onTap: () => context.router.pushNamed(
                        GroupChatPage.location(groupId: group.groupId),
                      ),
                      updatedAt: latestMessage?.createdAt,
                      // unReadCountString: ref.watch(
                      //   unReadCountStringProvider(group),
                      // ),
                      isMyMessage: latestMessage?.senderId == userId,
                    );
                  },
                );
              },
              loading: () => const SizedBox(),
              error: (_, __) => const Text("error"),
            );
          }),
        ),
      ),
    );
  }
}

class GenericGroupCard extends StatelessWidget {
  const GenericGroupCard({
    super.key,
    required this.title,
    this.latestMessage,
    this.onTap,
    //this.unReadCountString,
    this.updatedAt,
    required this.isMyMessage,
    this.imageSize = 54,
  });

  final double imageSize;
  final String? latestMessage;
  final String title;
  final VoidCallback? onTap;
  //final String? unReadCountString;
  final DateTime? updatedAt;
  final bool isMyMessage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: imageSize / 2,
              backgroundColor: Palette.appColor,
              child: Icon(
                Icons.groups_3_sharp,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 32,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(3),
                    if (latestMessage != null)
                      Text(
                        latestMessage!,
                        style: TextStyle(color: Palette.greyColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                if (updatedAt != null)
                  Text(
                    updatedAt!.formatRelativeDate(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                // Gap(5),
                // if (!isMyMessage) ...[
                //   if ((unReadCountString ?? '').isNotEmpty)
                //     Container(
                //       width: 30,
                //       height: 30,
                //       decoration: BoxDecoration(
                //         color: Palette.redColor,
                //         shape: BoxShape.circle,
                //       ),
                //       child: Center(
                //         child: Text(
                //           unReadCountString!,
                //         ),
                //       ),
                //     ),
                // ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
