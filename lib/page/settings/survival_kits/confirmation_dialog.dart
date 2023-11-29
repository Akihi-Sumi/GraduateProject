import 'package:flutter/material.dart';

class ConfirmationDialog {
  Future<bool?> showUpdateConfirmationDialog(
      BuildContext context, String itemName) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('更新の確認'),
          content: Text('更新しますか?。 \n\n $itemName'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> showOverwriteConfirmationDialog(
      BuildContext context, String? itemName) async {
    return await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('上書きの確認'),
          content: Text('$itemName は既に存在します。 \n\n 上書きしますか？'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Do not overwrite
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Overwrite
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
