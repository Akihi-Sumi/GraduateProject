import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  TextEditingController nameController =
      TextEditingController(text: "前回保存した名前");
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

  @override
  Widget build(BuildContext context) {
    // キーボード外をタップで収納するよう変更 (済み)
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          //backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              "個人設定",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: nameController,
                  onChanged: (value) {
                    nameUpdateValue(value);
                  },
                  style: TextStyle(color: Colors.amber, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: '名前を入力',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade700),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  onChanged: (value) {
                    emailUpdateValue(value);
                  },
                  style: TextStyle(color: Colors.amber, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'メールアドレスを入力',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade700),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  // メールアドレス用のキーボードを表示する
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: evacuationController,
                  onChanged: (value) {
                    evacuationUpdateValue(value);
                  },
                  style: TextStyle(color: Colors.amber, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: '避難場所を入力',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade700),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    String enteredEmail = emailController.text;
                    if (!enteredEmail.contains('@') ||
                        !enteredEmail.contains('.')) {
                      // メールアドレスに@と.が含まれていない場合は処理を中断
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
                                "閉じる",
                                style: TextStyle(fontSize: 17.5),
                              ),
                            ),
                          ],
                        ),
                      );
                      return;
                    } else {
                      FocusScope.of(context).unfocus();
                      showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("変更内容を保存しました"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFF57C00)),
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  ),
                  child: Text(
                    "保存",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
