import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchUserGroupDelegate extends SearchDelegate {
  final WidgetRef ref;

  SearchUserGroupDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  String? get searchFieldLabel => "ユーザー、グループを検索";

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(),
      title: Text("結果"),
      onTap: () {},
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: Colors.black,
      dialogBackgroundColor: Colors.black,
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  void navigateToUserOrGroup(
      BuildContext context, String userName, String groupName) {}
}
