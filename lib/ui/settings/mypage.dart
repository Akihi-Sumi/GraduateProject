import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/features/app_user.dart';
import 'package:graduate_app/utils/constants/constants.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController =
      TextEditingController(text: "前回保存したメアド");
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
                SizedBox(height: 30),
                TextFormHeader(title: "名前"),
                Measure.g_4,
                TextField(
                  controller: userName,
                  onChanged: (value) {
                    nameUpdateValue(value);
                  },
                  style: TextStyle(color: Colors.amber, fontSize: 18),
                  cursorColor: Colors.white,
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
                      onPressed: () => nameController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20),
                TextFormHeader(title: "メールアドレス"),
                Measure.g_4,
                TextField(
                  controller: emailController,
                  focusNode: emailFocus,
                  onChanged: (value) {
                    emailUpdateValue(value);
                  },
                  style: TextStyle(color: Colors.amber, fontSize: 18),
                  cursorColor: Colors.white,
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
                      onPressed: () => emailController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  // メールアドレス用のキーボードを表示する
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20),
                TextFormHeader(title: "避難場所"),
                Measure.g_4,
                TextField(
                  controller: evacuationController,
                  onChanged: (value) {
                    evacuationUpdateValue(value);
                  },
                  style: TextStyle(color: Colors.amber, fontSize: 18),
                  cursorColor: Colors.white,
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
                      onPressed: () => evacuationController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 140,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (nameController.text != "前回保存した名前" ||
                            emailController.text != "前回保存したメアド" ||
                            evacuationController.text != "前回保存した避難場所")
                        ? () {
                            //メールアドレスのバリデーション & 名前と避難場所の欄が空白じゃないとき
                            if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(emailController.text) &&
                                nameController.text.isNotEmpty &&
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
                            else if (nameController.text.isEmpty ||
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
