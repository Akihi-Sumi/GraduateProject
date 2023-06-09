import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  String name = ''; // 名前を保持するプロパティ
  String email = ''; // メールアドレスを保持するプロパティ
  String hinan = ''; // 避難場所を保持するプロパティ

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
    super.dispose();
  }

  void updateInputValue1(String value) {
    setState(() {
      name = value;
    });
  }

  void updateInputValue2(String value) {
    setState(() {
      email = value;
    });
  }

  void updateInputValue3(String value) {
    setState(() {
      hinan = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // キーボード外をタップで収納するよう変更 (済み)
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text(
              "個人設定",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.orange.shade700,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: textEditingController1,
                  onChanged: (value) {
                    updateInputValue1(value);
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: '名前を入力',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade700),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: textEditingController2,
                  onChanged: (value) {
                    updateInputValue2(value);
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'メールアドレスを入力',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade700),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress, // メールアドレス用のキーボードを表示する
                ),
                SizedBox(height: 20),
                TextField(
                  controller: textEditingController3,
                  onChanged: (value) {
                    updateInputValue3(value);
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: '避難場所を入力',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade700),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
               TextButton(
                onPressed: () {
                  // 保存ボタンが押された時の処理
                  String enteredEmail = textEditingController2.text;
                  if (!enteredEmail.contains('@') || !enteredEmail.contains('.')) {
                    // メールアドレスに@と.が含まれていない場合は処理を中断
                    return;
                  }
                  textEditingController1.clear(); // テキストフィールド1をクリア
                  textEditingController2.clear(); // テキストフィールド2をクリア
                  textEditingController3.clear(); // テキストフィールド3をクリア
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 背景色を白に指定
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)), // ボタンの最小サイズを指定（横幅: 120、高さ: 50）
                ),
                child: Text(
                  "保存",
                  style: TextStyle(fontSize: 25, color: Colors.black), // テキストのスタイルを指定
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}