import 'package:flutter/material.dart';
import 'package:graduate_app/widget/myAlertDialog.dart';

class PopupMenuButtonSample extends StatelessWidget {
  const PopupMenuButtonSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: const Color(0xFF424242),
      icon: const Icon(
        Icons.more_vert_rounded,
        color: Colors.grey,
        size: 40,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              Text(
                "編集",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              Text(
                "削除",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return MyAlertDialog(
                  title: "削除しますか？",
                  txt_cancel: "キャンセル",
                  txt_ok: "削除",
                  txt_snack: "削除しました",
                );
              },
            );
          },
        ),
      ],
    );
  }
}
