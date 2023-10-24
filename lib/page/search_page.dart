import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/widgets/search_user_group_delegate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SearchRouterPage extends AutoRouter {
  const SearchRouterPage({super.key});
}

@RoutePage()
class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              SearchBox(),
              const SizedBox(height: 10),
              ListTile(
                title: Text("参加済みグループ"),
              ),
              ListTile(
                title: Text("グループ名"),
                leading: CircleAvatar(),
                onTap: () {},
              )
            ],
          ),
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
