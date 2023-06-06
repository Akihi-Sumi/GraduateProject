import 'dart:async';

import 'package:flutter/material.dart';

class SurvivalKitPage extends StatefulWidget {
  const SurvivalKitPage({Key? key}) : super(key: key);

  @override
  _SurvivalKitPageState createState() => _SurvivalKitPageState();
}

// "time"を追加。時間を指定。
class _SurvivalKitPageState extends State<SurvivalKitPage> {
  List<Map> _list = [
    {"name": "応急セット", "isChecked": false},
    {"name": "長期保存水", "isChecked": false},
    {"name": "緊急用呼口笛", "isChecked": false},
    {"name": "缶詰、備蓄パン", "isChecked": false},
    {"name": "レジャーシート", "isChecked": false},
    {"name": "食品加熱袋、加熱材", "isChecked": false},
    {"name": "防災折り畳みヘルメット", "isChecked": false},
    {"name": "ウェットボディタオル", "isChecked": false},
    {"name": "歯ブラシ", "isChecked": false},
    {"name": "非常用簡易トイレ", "isChecked": false},
    {"name": "布ガムテープ", "isChecked": false},
    {"name": "アルミブランケット、アルミシート", "isChecked": false},
    {"name": "レインコート", "isChecked": false},
    {"name": "アルコール除菌ジェル", "isChecked": false},
    {"name": "非常用カイロ", "isChecked": false},
    {"name": "マルチツール", "isChecked": false},
    {"name": "乾電池", "isChecked": false},
    {"name": "エアーピロー", "isChecked": false},
    {"name": "三角巾、ガーゼ", "isChecked": false},
    {"name": "折り畳み式スリッパ", "isChecked": false},
    {"name": "緊急用連絡シート", "isChecked": false},
    {"name": "非常用給水袋", "isChecked": false},
    {"name": "マスク", "isChecked": false},
    {"name": "ドライシャンプー", "isChecked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "防災グッズ",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.orange.shade700,
          actions: [],
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                  child: Text(
                    "防災グッズ チェックリスト",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Divider(),
                Column(
                    children: _list.map((goods) {
                  return CheckboxListTile(
                    tileColor: Colors.grey,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.orange.shade700,
                    contentPadding: EdgeInsets.only(
                        top: 10, right: 0, bottom: 10, left: 30),
                    value: goods["isChecked"],
                    title: Text(
                      goods["name"],
                      style: TextStyle(
                        color:
                            goods["isChecked"] ? Colors.blueGrey : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        decoration: goods["isChecked"]
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        goods["isChecked"] = value;
                        if (value as bool) {
                          Timer(Duration(days: goods["time"]), () {
                            setState(() {
                              goods["isChecked"] = false;
                            });
                          });
                        }
                      });
                    },
                  );
                }).toList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
