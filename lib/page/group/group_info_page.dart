import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controllers/group/group.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class GroupInfoPage extends ConsumerStatefulWidget {
  const GroupInfoPage({Key? key, required this.groupId}) : super(key: key);

  static const path = 'group/:groupId';

  static String location({required String groupId}) => 'group/$groupId';

  final String groupId;

  @override
  ConsumerState<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends ConsumerState<GroupInfoPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(groupStateNotifierProvider(widget.groupId));
    return Container();
  }
}
