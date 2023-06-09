import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduate_app/features/features.dart';
import 'package:graduate_app/utils/utils.dart';
import 'package:graduate_app/widget/userIcon.dart';
import 'package:graduate_app/widget/widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MyPage extends StatefulHookConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends ConsumerState<MyPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      // text: ref.read(appUserFutureProvider).value?.userName ?? '',
      text: ref.read(userProvider)?.userName,
    );
    emailController = TextEditingController(
      text: ref.read(appUserFutureProvider).value?.userEmail ?? '',
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    final appUserName = ref.watch(appUserFutureProvider).maybeWhen(
          data: (data) => data?.userName,
          orElse: () => null,
        );
    final appUserEmail = ref.watch(appUserFutureProvider).maybeWhen(
          data: (data) => data?.userEmail,
          orElse: () => null,
        );

    final userEvacuation = useTextEditingController(text: "保存した避難場所");

    // キーボード外をタップで収納するよう変更 (済み)
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.only(bottom: bottomSpace),
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserIcon(),
                //SizedBox(height: 30),
                _EditUserNameTextForm(
                  controller: nameController,
                  onPressed: () => nameController.clear(),
                ),
                SizedBox(height: 20),
                _EditEmailTextForm(
                  controller: emailController,
                  onPressed: () => emailController.clear(),
                ),
                SizedBox(height: 20),
                _EditEvacuationTextForm(
                  controller: userEvacuation,
                  onPressed: () => userEvacuation.clear(),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 140,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (nameController.text != appUserName ||
                            emailController.text != appUserEmail ||
                            userEvacuation.text != "前回保存した避難場所")
                        ? () {
                            //メールアドレスのバリデーション & 名前と避難場所の欄が空白じゃないとき
                            if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(emailController.text) &&
                                nameController.text.isNotEmpty &&
                                userEvacuation.text.isNotEmpty) {
                              FocusScope.of(context).unfocus();
                              showDialog<void>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("変更内容を保存しました"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        FocusScope.of(context).unfocus();
                                      },
                                      child: Text(
                                        "閉じる",
                                        style: TextStyle(fontSize: 17.5),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            // 空欄があるとき
                            else if (nameController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                userEvacuation.text.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "未入力の項目があります",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 23.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "閉じる",
                                        style: TextStyle(fontSize: 17.5),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            // メールアドレスが無効なとき
                            else {
                              showDialog<void>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    "メールアドレスが無効です",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 23.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "編集を続ける",
                                        style: TextStyle(
                                          fontSize: 17.5,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.orange[700],
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(
                      "保存",
                      style: TextStyle(
                        color: Colors.black,
                        //fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EditUserNameTextForm extends StatelessWidget {
  const _EditUserNameTextForm({
    required this.controller,
    required this.onPressed,
  });

  final TextEditingController controller;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          TextFormHeader(title: "名前"),
          Measure.g_4,
          TextFormField(
            controller: controller,
            style: TextStyle(color: Colors.amber, fontSize: 18),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white, fontSize: 16),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade700),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.clear,
                  color: AppColors.baseLight,
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}

class _EditEmailTextForm extends StatelessWidget {
  const _EditEmailTextForm({
    required this.controller,
    required this.onPressed,
  });

  final TextEditingController controller;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          TextFormHeader(title: "メールアドレス"),
          Measure.g_4,
          TextFormField(
            controller: controller,
            style: TextStyle(color: Colors.amber, fontSize: 18),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white, fontSize: 16),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade700),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.clear,
                  color: AppColors.baseLight,
                ),
              ),
            ),
            // メールアドレス用のキーボードを表示する
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}

class _EditEvacuationTextForm extends StatelessWidget {
  const _EditEvacuationTextForm({
    required this.controller,
    required this.onPressed,
  });

  final TextEditingController controller;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          TextFormHeader(title: "避難場所"),
          Measure.g_4,
          TextFormField(
            controller: controller,
            style: TextStyle(color: Colors.amber, fontSize: 18),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white, fontSize: 16),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade700),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.clear,
                  color: AppColors.baseLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
