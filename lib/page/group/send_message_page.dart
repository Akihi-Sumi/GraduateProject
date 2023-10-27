import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/controller/group.dart';
import 'package:graduate_app/controller/group_dropdown.dart';
import 'package:graduate_app/controller/group_message.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/constants/app_colors.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/utils/json_converters/union_timestamp.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:graduate_app/widgets/rounded_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SendMessagePage extends StatefulHookConsumerWidget {
  const SendMessagePage({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  ConsumerState<SendMessagePage> createState() => _SendMessagePageState();
}

class _SendMessagePageState extends ConsumerState<SendMessagePage> {
  final messageTextController = TextEditingController();

  // List<GroupModel> groups = [];
  // GroupModel? selectedGroup;

  @override
  void dispose() {
    super.dispose();
    messageTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTypeText = widget.type == 'text';

    ref.listen<AsyncValue<void>>(sendMessageControllerProvider,
        (_, state) async {
      if (state.isLoading) {
        ref.watch(overlayLoadingProvider.notifier).update((state) => true);
        return;
      }

      await state.when(data: (_) async {
        ref.watch(overlayLoadingProvider.notifier).update((state) => false);
        ref.read(scaffoldMessengerServiceProvider).showSnackBar("送信しました");
        Navigator.of(context).pop();
      }, error: (e, s) async {
        ref.watch(overlayLoadingProvider.notifier).update((state) => false);
        state.showAlertDialogOnError(context);
      }, loading: () {
        ref.watch(overlayLoadingProvider.notifier).update((state) => true);
      });
    });

    final useMessageTextController = useTextEditingController();

    final selectedGroup = ref.watch(dropdownButtonGroupProvider);

    final userId = ref.watch(authRepositoryImplProvider).currentUser?.uid;
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );

    final groups = ref.watch(groupsProvider).maybeWhen<List<GroupModel>>(
          data: (data) {
            final groups = data.toList();
            return [initGroup, ...groups];
          },
          orElse: () => [initGroup],
        );

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
              Padding(
                padding: Measure.p_h8,
                child: _DropdownGroupSelectButton(
                  groupsList: groups,
                  selectedGroup: selectedGroup,
                  onChanged: (value) => ref
                      .read(dropdownButtonGroupProvider.notifier)
                      .selectedGroup(value),
                ),
              ),
              Measure.g_60,
              Padding(
                padding: Measure.p_h32,
                child: PrimaryRoundedButton(
                  text: "送信",
                  onTap: () async {
                    if (userId != null) {
                      ref
                          .watch(overlayLoadingProvider.notifier)
                          .update((state) => true);

                      final groupMessage = Message(
                        messageText: useMessageTextController.value.text,
                        type: 'text',
                        userId: userId,
                        userName: appUserName ?? '',
                        createdAt: UnionTimestamp.serverTimestamp(),
                        updatedAt: UnionTimestamp.serverTimestamp(),
                      );
                      await ref
                          .read(sendMessageControllerProvider.notifier)
                          .sendMessage(
                            groupMessage: groupMessage,
                            group: selectedGroup,
                          );
                    }
                  },
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
    required this.groupsList,
  });

  final GroupModel? selectedGroup;
  final void Function(GroupModel?)? onChanged;
  final List<GroupModel> groupsList;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: Measure.br_6,
        border: Border.all(
          color: selectedGroup == initGroup
              ? AppColors.baseLight
              : AppColors.secondary,
        ),
      ),
      child: SizedBox(
        width: 300,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<GroupModel?>(
            isExpanded: true,
            underline: Container(),
            dropdownColor: Colors.grey[800],
            value: selectedGroup,
            style: TextStyle(fontSize: 16, color: Colors.white),
            icon: Icon(
              Icons.expand_more,
              color: AppColors.secondary,
            ),
            onChanged: onChanged,
            items: groupsList.map<DropdownMenuItem<GroupModel?>>((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value.groupName),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
