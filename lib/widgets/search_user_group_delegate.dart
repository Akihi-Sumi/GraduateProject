import 'package:flutter/material.dart';
import 'package:graduate_app/controller/group.dart';
import 'package:graduate_app/widgets/imitation_list_tile.dart';
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
    return buildSuggestions(context);
  }

  @override
  String? get searchFieldLabel => "ユーザー、グループを検索";

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(searchGroupProvider(query)).when(
          data: (groups) => ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                return ImitationListTile(
                  title: Text(group.groupName),
                  leading: CircleAvatar(),
                  onTap: () {},
                );
              }),
          error: (error, stackTrace) {
            return Text("An error occurred");
          },
          loading: () {
            return CircularProgressIndicator();
          },
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
