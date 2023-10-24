import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/group_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateGroupPage extends StatefulHookConsumerWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends ConsumerState<CreateGroupPage> {
  final groupNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
  }

  void createGroup() {
    ref.read(groupControllerProvider.notifier).createGroup(
          groupNameController.text.trim(),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            "グループ作成",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: BackButton(
            onPressed: () => context.popRoute(),
          ),
          backgroundColor: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [_GroupNameTextForm(controller: groupNameController)],
        ),
      ),
    );
  }
}

class _GroupNameTextForm extends StatelessWidget {
  const _GroupNameTextForm({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "グループ名を入力してください",
        filled: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(18),
      ),
      maxLength: 20,
    );
  }
}
