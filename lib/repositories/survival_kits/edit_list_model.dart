import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/models/item/item_model.dart';
import 'package:graduate_app/page/settings/survival_kits/add_item_page.dart';
import 'package:graduate_app/page/settings/survival_kits/edit_item_page.dart';
import 'package:graduate_app/repositories/survival_kits/list_collection_repository.dart';

class EditItemModel extends ChangeNotifier {
  final ItemRepository itemRepository;
  final Item item;

  final nameController = TextEditingController();
  final expirationDateController = TextEditingController();

  String? title;
  String? expirationDate;
  String? itemExpirationDate;
  String? userId;
  late bool isExpirationDateSet;
  late TextEditingController _textEditingController;

  EditItemModel(this.itemRepository, this.item) {
    nameController.text = item.name;
    itemExpirationDate = item.expirationDate;

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }

    if (item.name == EditItemPage.getName(item)) {
      title = EditItemPage.getName(item);
      _textEditingController =
          TextEditingController(text: EditItemPage.getName(item));
    } else {
      title = item.name;
      _textEditingController = TextEditingController(text: title);
    }

    if (item.expirationDate == '保存期限なし') {
      expirationDate = '保存期限なし';
      isExpirationDateSet = false;
      print('保存期限なし');
      _textEditingController =
          TextEditingController(text: AddItemPage.nowData());
    } else {
      expirationDate = item.expirationDate;
      isExpirationDateSet = true;
      print(expirationDate);
      print('↑ 保存期限あり');
      _textEditingController = TextEditingController(text: expirationDate);
    }

    expirationDateController.text = expirationDate ?? '';
  }

  void toggleExpirationDate() {
    setIsExpirationDateSet(!isExpirationDateSet);
  }

  void setTitle(String title) {
    this.title = title;
    nameController.text = title; // Update the nameController text
    notifyListeners();
  }

  void setExpirationDate(String expirationDate) {
    this.expirationDate = expirationDate;
    expirationDateController.text =
        expirationDate; // Update the expirationDateController text
    notifyListeners();
  }

  void setIsExpirationDateSet(bool value) {
    isExpirationDateSet = value;

    if (isExpirationDateSet) {
      expirationDate = item.expirationDate;
      title = item.name;
      _textEditingController.text = expirationDate ?? '';
    } else {
      expirationDate = '保存期限なし';
      expirationDateController.clear();
      _textEditingController.text = AddItemPage.nowData();
    }

    notifyListeners();
  }

  Future<void> update() async {
    title = nameController.text;
    if (isExpirationDateSet && expirationDate == '保存期限なし') {
      expirationDate = AddItemPage.nowData();
    }
    print("expirationDate :: :: $expirationDate");

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }

    Item updatedItem = Item(
      expirationDate: expirationDate!,
      name: title!,
      isChecked: item.isChecked,
      time: item.time,
    );

    try {
      // Check for duplicate item name before updating
      bool isDuplicate = await itemRepository.doesItemExist(userId!, title!);

      if (isDuplicate && itemExpirationDate == expirationDate) {
        // Delete the existing item with the same name
        await itemRepository.deleteItemMap(
          userId: userId!,
          itemName: title!,
        );
      }

      // Update both name and other fields in Firestore
      await itemRepository.updateItemMap(
        userId: userId!,
        itemName: item.name,
        newItem: updatedItem,
      );
    } catch (e) {
      print('Error updating item: $e');
      rethrow;
    }
  }

  Future<bool?> showOverwriteConfirmationDialog(
      BuildContext context, String itemName) async {
    try {
      // Check for null on itemRepository
      // if (itemRepository == null) {
      //   print('Error: itemRepository is null');
      //   return null;
      // }

      // Check for null on userId
      if (userId == null) {
        print('Error: userId is null');
        return null;
      }

      // Check if the item name has changed
      bool isNameChanged = itemName != item.name;

      if (isNameChanged) {
        // Handle the case where the item name is changed
        // Check for duplicate item name before showing the dialog
        bool isDuplicate =
            await itemRepository.doesItemExist(userId!, itemName);

        if (isDuplicate && itemExpirationDate == expirationDate) {
          return await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('重複の確認'),
                content: Text('同じアイテムが既に存在します。上書きしてもよろしいですか？'),
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
        } else {
          // No duplicate, proceed with the confirmation dialog
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
      } else {
        // Item name hasn't changed, return true directly
        return true;
      }
    } catch (e) {
      print('Error in showOverwriteConfirmationDialog: $e');
      return null; // Handle the error and return null or a default value
    }
  }
}
