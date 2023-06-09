//import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/features/app_user.dart';
import 'package:graduate_app/utils/constants/constants.dart';
import 'package:graduate_app/widget/userIcon.dart';
import 'package:graduate_app/widget/widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// @RoutePage()
class MyPage2 extends StatefulHookConsumerWidget {
  const MyPage2({Key? key}) : super(key: key);

  @override
  MyPage2State createState() => MyPage2State();
}

class MyPage2State extends ConsumerState<MyPage2> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController evacuationController =
      TextEditingController(text: "前回保存した避難場所");

  String name = ''; // 名前を保持するプロパティ
  String email = ''; // メールアドレスを保持するプロパティ
  String evacuation = ''; // 避難場所を保持するプロパティ

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    evacuationController.dispose();
    super.dispose();
  }

  void nameUpdateValue(String value) {
    setState(() {
      name = value;
    });
  }

  void emailUpdateValue(String value) {
    setState(() {
      email = value;
    });
  }

  void evacuationUpdateValue(String value) {
    setState(() {
      evacuation = value;
    });
  }

  final emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen(
          data: (data) => data?.userName,
          orElse: () => null,
        );
    TextEditingController userName = TextEditingController(text: appUserName);

    final appUserEmail = ref.watch(appUserFutureProvider).maybeWhen(
          data: (data) => data?.userEmail,
          orElse: () => null,
        );
    TextEditingController userEmail = TextEditingController(text: appUserEmail);

    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

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
                  controller: userName,
                  onChanged: (value) {
                    nameUpdateValue(value);
                  },
                  onPressed: () => userName.clear(),
                ),
                SizedBox(height: 20),
                _EditEmailTextForm(
                  controller: userEmail,
                  focusNode: emailFocus,
                  onChanged: (value) {
                    emailUpdateValue(value);
                  },
                  onPressed: () => userEmail.clear(),
                ),
                SizedBox(height: 20),
                _EditEvacuationTextForm(
                  controller: evacuationController,
                  onChanged: (value) {
                    evacuationUpdateValue(value);
                  },
                  onPressed: () => evacuationController.clear(),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 140,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (userName.text != appUserName ||
                            userEmail.text != appUserEmail ||
                            evacuationController.text != "前回保存した避難場所")
                        ? () {
                            //メールアドレスのバリデーション & 名前と避難場所の欄が空白じゃないとき
                            if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(userEmail.text) &&
                                userName.text.isNotEmpty &&
                                evacuationController.text.isNotEmpty) {
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
                            else if (userName.text.isEmpty ||
                                userEmail.text.isEmpty ||
                                evacuationController.text.isEmpty) {
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
                                        emailFocus.requestFocus();
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
    required this.onChanged,
    required this.onPressed,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;
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
            onChanged: onChanged,
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
                icon: Icon(Icons.clear),
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
    required this.focusNode,
    required this.onChanged,
    required this.onPressed,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
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
            focusNode: focusNode,
            onChanged: onChanged,
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
                icon: Icon(Icons.clear),
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
    required this.onChanged,
    required this.onPressed,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;
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
            onChanged: onChanged,
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
                icon: Icon(Icons.clear),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
