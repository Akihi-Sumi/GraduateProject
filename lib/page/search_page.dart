import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controllers/group/groups.dart';
import 'package:graduate_app/page/group/group_info_page.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
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
              title: Text("参加済みグループ"),
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
                        leading: CircleAvatar(),
                        onTap: () => context.router.pushNamed(
                          GroupInfoPage.location(groupName: group.groupName),
                        ),
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
    return InkWell(
      child: Container(
        //width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFF393939),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFD0D0D0),
            width: 1.5,
          ),
        ),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "ユーザー、グループを検索",
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
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
