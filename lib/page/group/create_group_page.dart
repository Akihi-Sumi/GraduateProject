import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduate_app/controller/group_controller/group.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/repositories/auth/auth_repository_impl.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/utils/json_converters/union_timestamp.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:graduate_app/widgets/rounded_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateGroupPage extends StatefulHookConsumerWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends ConsumerState<CreateGroupPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(createGroupControllerProvider, (_, state) async {
      if (state.isLoading) {
        ref.watch(overlayLoadingProvider.notifier).update((state) => true);
        return;
      }

      await state.when(data: (_) {
        ref.watch(overlayLoadingProvider.notifier).update((state) => false);
        ref.read(scaffoldMessengerServiceProvider).showSnackBar("グループを作成しました");
        Navigator.of(context).pop();
      }, error: (e, s) async {
        ref.watch(overlayLoadingProvider.notifier).update((state) => false);
        state.showAlertDialogOnError(context);
      }, loading: () {
        ref.watch(overlayLoadingProvider.notifier).update((state) => true);
      });
    });

    final userId = ref.watch(authRepositoryImplProvider).currentUser?.uid;

    final useGroupNameController = useTextEditingController();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                title: Text(
                  "グループ作成",
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _GroupNameTextForm(controller: useGroupNameController),
                  Measure.g_24,
                  Padding(
                    padding: Measure.p_h32,
                    child: PrimaryRoundedButton(
                      text: "作成",
                      onTap: () async {
                        if (userId != null) {
                          ref
                              .watch(overlayLoadingProvider.notifier)
                              .update((state) => true);

                          final group = GroupModel(
                            groupId: useGroupNameController.value.text,
                            groupName: useGroupNameController.value.text,
                            createUserId: userId,
                            members: [userId],
                            mods: [userId],
                            createdAt: UnionTimestamp.serverTimestamp(),
                            updatedAt: UnionTimestamp.serverTimestamp(),
                          );

                          await ref
                              .read(createGroupControllerProvider.notifier)
                              .createGroup(group: group);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
        ],
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
