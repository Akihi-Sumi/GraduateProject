import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/group_controller/groups.dart';
import 'package:graduate_app/page/group/group_info_card.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/widgets/imitation_list_tile.dart';
import 'package:graduate_app/widgets/search_user_group_delegate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SearchRouterPage extends AutoRouter {
  const SearchRouterPage({super.key});

  static const path = 'search';
  static const location = path;
}

@RoutePage()
class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authRepositoryImplProvider).currentUser?.uid;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: SearchBox(),
            ),
            ListTile(
              title: Text(
                "参加済みグループ",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            ref.watch(groupsStreamProvider(userId ?? '')).when(
                  data: (groups) => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      final group = groups[index];
                      return ImitationListTile(
                        title: Text(
                          group.groupName,
                          style: TextStyle(fontSize: 20),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Palette.appColor,
                          child: Icon(
                            Icons.groups_sharp,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return GroupInfoCard(groupName: group.groupName);
                            },
                          );
                        },
                      );
                    },
                  ),
                  error: (error, stackTrace) => Text("error"),
                  loading: () => const Loader(),
                ),
          ],
        ),
      ),
    );
  }
}

class SearchBox extends ConsumerWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);

    return InkWell(
      child: Container(
        //width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: theme == Palette.darkModeAppTheme
              ? Color(0xFF393939)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey,
            width: 1.5,
          ),
        ),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "グループを検索",
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      onTap: () {
        showSearch(
          context: context,
          useRootNavigator: true,
          delegate: SearchUserGroupDelegate(ref),
        );
      },
    );
  }
}
