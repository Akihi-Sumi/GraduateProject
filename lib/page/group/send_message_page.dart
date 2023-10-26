import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduate_app/controller/group_controller.dart';
import 'package:graduate_app/controller/group_message_controller.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/utils/constants/app_colors.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/widgets/rounded_button.dart';
import 'package:graduate_app/widgets/show_snack_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SendMessagePage extends StatefulHookConsumerWidget {
  const SendMessagePage({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  ConsumerState<SendMessagePage> createState() => _SendMessagePageState();
}

class _SendMessagePageState extends ConsumerState<SendMessagePage> {
  final messageTextController = TextEditingController();

  List<GroupModel> groups = [];
  GroupModel? selectedGroup;

  @override
  void dispose() {
    super.dispose();
    messageTextController.dispose();
  }

  void sendMessage() {
    if (widget.type == 'text' && messageTextController.text.isNotEmpty) {
      ref.read(groupMessageControllerProvider.notifier).sendTextMessage(
            context: context,
            selectedGroup: selectedGroup ?? groups[0],
            messageText: messageTextController.text.trim(),
          );

      messageTextController.clear();

      Navigator.of(context).pop();
    } else {
      showSnackBar(context, "項目を全て入力してください");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTypeText = widget.type == 'text';

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            title: Text(
              "テキストを送信",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (isTypeText)
                _MessageTextForm(controller: messageTextController),
              Measure.g_24,
              const Align(
                alignment: Alignment.topLeft,
                child: Text("グループを選択"),
              ),
              Measure.g_16,
              ref.watch(userGroupsProvider).when(
                    data: (data) {
                      groups = data;

                      if (data.isEmpty) {
                        return const SizedBox();
                      }

                      return _DropdownGroupSelectButton(
                        selectedGroup: selectedGroup ?? data[0],
                        onChanged: (value) {
                          setState(() {
                            selectedGroup = value;
                          });
                        },
                        items: data
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: Center(
                                  child: Text(e.groupName),
                                )))
                            .toList(),
                      );
                    },
                    error: (error, stackTrace) => ErrorText(
                      error: error.toString(),
                    ),
                    loading: () => const Loader(),
                  ),
              Measure.g_60,
              Padding(
                padding: Measure.p_h32,
                child: PrimaryRoundedButton(
                  text: "送信",
                  onTap: sendMessage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageTextForm extends StatelessWidget {
  const _MessageTextForm({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: "メッセージを入力してください",
        filled: true,
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(18),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      maxLength: 100,
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText({Key? key, required this.error}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}

class _DropdownGroupSelectButton extends HookWidget {
  const _DropdownGroupSelectButton({
    required this.selectedGroup,
    required this.onChanged,
    required this.items,
  });

  final GroupModel? selectedGroup;
  final void Function(GroupModel?)? onChanged;
  final List<DropdownMenuItem<GroupModel?>>? items;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: Measure.br_6,
        border: Border.all(
          color: AppColors.secondary,
        ),
      ),
      child: SizedBox(
        width: 300,
        child: DropdownButton<GroupModel?>(
          isExpanded: true,
          underline: Container(),
          dropdownColor: Colors.grey[800],
          hint: Text("選択されていません"),
          value: selectedGroup,
          style: TextStyle(fontSize: 16, color: Colors.white),
          icon: Icon(
            Icons.expand_more,
            color: AppColors.secondary,
          ),
          onChanged: onChanged,
          items: items,
        ),
      ),
    );
  }
}
