import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/page/settings/survival_kits/add_item_page.dart';
import 'package:graduate_app/page/settings/survival_kits/confirmation_dialog.dart';
import 'package:intl/intl.dart';

class AddItemModel extends ChangeNotifier {
  String? title;
  String? _expirationDate = AddItemPage.nowData();
  String? userId = '';

  String? get expirationDate => _expirationDate;

  set expirationDate(String? value) {
    _expirationDate = value;
    notifyListeners();
  }

  Future<void> addItemToFirestore(BuildContext context) async {
    if (title == null || title!.isEmpty) {
      throw '名前が入力されていません';
    }

    if (expirationDate == null) {
      throw '保存期限が入力されていません';
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userId = user.uid;
      }

      final subDocumentReference = FirebaseFirestore.instance
          .collection('appUsers')
          .doc(userId)
          .collection('survivalKits')
          .doc('listData');

      // Fetch the existing list from Firestore
      final snapshot = await subDocumentReference.get();
      List<dynamic> existingList = [];

      if (snapshot.exists) {
        existingList = snapshot['list'] ?? [];
      }

      // Check if an item with the same name already exists
      final existingItemIndex = existingList.indexWhere(
        (item) => item['name'] == title,
      );

      // If an item with the same name exists, show a confirmation dialog
      if (existingItemIndex != -1) {
        ConfirmationDialog confirmationDialog = ConfirmationDialog();
        bool? overwrite = await confirmationDialog
            .showOverwriteConfirmationDialog(context, title);
        if (overwrite != null && overwrite) {
          // Update the existing item
          existingList[existingItemIndex] = {
            'time': 3,
            'isChecked': false,
            'name': title,
            'expirationDate': expirationDate,
          };
        } else {
          // User chose not to overwrite, do not proceed
          return;
        }
      } else {
        // If the item doesn't exist, add a new one
        existingList.add({
          'time': 3,
          'isChecked': false,
          'name': title,
          'expirationDate': expirationDate,
        });
      }

      // Update the Firestore document
      subDocumentReference.set({'list': existingList});

      final snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('アイテムが追加されました'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      throw 'アイテムを追加できませんでした: $e';
    }
  }

  String formattedExpirationDate() {
    return _expirationDate != null
        ? DateFormat('yyyy/MM/dd').format(_expirationDate! as DateTime)
        : 'null'.toString();
  }
}
