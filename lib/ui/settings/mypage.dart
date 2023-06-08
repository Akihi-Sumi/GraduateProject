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
  String name = ''; // 名前を保持するプロパティ
  String email = ''; // メールアドレスを保持するプロパティ

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
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
                Text(
                  '名前: $name',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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

                  // ！メールアドレス用のキーボードにする処理
                ),
                SizedBox(height: 20),
                Text(
                  'メールアドレス: $email',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                /*
								 * ！保存ボタンを押したら新しいページが出現するようになっているため修正。
								 * ！メールアドレスに不備があったら弾く処理(バリデーション)を追加。
								 * ！ボタンとテキストのサイズを調整
								 */
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPage(),
                      ),
                    );
                  },
                  child: Text("保存"),
                ),

                // ！避難場所を入力するフィールドを追加
              ],
            ),
          ),
        ));
  }
}
