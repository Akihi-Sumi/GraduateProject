import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/models/item/item_model.dart';
import 'package:graduate_app/page/settings/survival_kits/add_item_page.dart';
import 'package:graduate_app/page/settings/survival_kits/edit_item_page.dart';
import 'package:graduate_app/repositories/survival_kits/list_collection_repository.dart';
import 'package:graduate_app/theme/palette.dart';

@RoutePage()
class SurvivalKitPage extends StatefulWidget {
  final ItemRepository itemRepository;

  SurvivalKitPage({required this.itemRepository});

  @override
  State<SurvivalKitPage> createState() =>
      _SurvivalKitPageState(itemRepository: itemRepository);
}

class _SurvivalKitPageState extends State<SurvivalKitPage>
    with AutomaticKeepAliveClientMixin {
  late ItemRepository itemRepository;
  List<ItemModel> _items = [];
  String userId = '';
  String itemId = '';
  bool _isDisposed = false;

  _SurvivalKitPageState({required this.itemRepository});

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
      fetchSurvivalKitsData(); // Fetch data when the user is retrieved
    }
  }

  Future<void> fetchSurvivalKitsData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('appUsers')
          .doc(userId)
          .collection('survivalKits')
          .doc('listData')
          .get();

      if (querySnapshot.exists) {
        final listData = querySnapshot.data();
        if (listData != null) {
          final list = listData['list'];

          final itemList = processData(list);
          if (mounted) {
            setState(() {
              _items = itemList;
            });
          }
        }
      } else {
        print('listData does not exist');
      }
    } catch (e) {
      print('Error fetching listData: $e');
    }
  }

  List<ItemModel> processData(dynamic listData) {
    if (listData is List) {
      List<ItemModel> items = listData.map((item) {
        return ItemModel(
          expirationDate: item['expirationDate'],
          name: item['name'],
          isChecked: item['isChecked'],
          time: item['time'],
        );
      }).toList();

      return items;
    } else {
      throw CustomException('Invalid data format');
    }
  }

  Future<void> showConfirmDialog(ItemModel list) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("削除してもよろしいですか \n\n ${list.name}"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () async {
                await itemRepository.deleteItemMap(
                  userId: userId,
                  itemName: list.name,
                );

                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("'${list.name}' 削除しました"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                // Wait for the asynchronous operation to complete before closing the dialog
                // You may adjust the duration based on your preference
                await Future.delayed(const Duration(milliseconds: 500));

                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.topRoute.title(context),
        ),
      ),
      body: _items.isEmpty
          ? Center(
              child: Text(
                '防災グッズリストがありません \n\n 追加ボタンを押してください',
              ),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Dismissible(
                  key: Key(item.name), // Use a unique key for each item
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      //color: Colors.white,
                    ),
                  ),
                  //指定したリストの削除
                  onDismissed: (direction) {
                    showConfirmDialog(item);
                  },
                  child: GestureDetector(
                    //指定したリストの更新
                    onLongPress: () async {
                      final bool? updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditItemPage(
                              item: item, itemRepository: itemRepository),
                        ),
                      );

                      if (updated != null && updated) {
                        fetchSurvivalKitsData();
                      }
                    },
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Palette.appColor,
                      contentPadding: EdgeInsets.only(
                          top: 10, right: 0, bottom: 10, left: 30),
                      value: item.isChecked,
                      title: Text(
                        item.name,
                        style: TextStyle(
                          color: item.isChecked
                              ? Colors.blueGrey
                              : Theme.of(context).colorScheme.onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: item.isChecked
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: item.time != 0 && item.isChecked
                          ? Text("保存期限 : ${item.expirationDate}",
                              style: TextStyle(
                                color: item.isChecked
                                    ? Colors
                                        .white // Change text color when checked
                                    : Colors.grey, // Default text color
                              ))
                          : null,
                      onChanged: (bool? value) async {
                        // Show a SnackBar when the checkbox is checked
                        if (value == true) {
                          final snackBar = SnackBar(
                            content: Text("保存期限: ${item.expirationDate}"),
                            duration:
                                Duration(seconds: 1), // Show for 5 seconds
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                        // Create a new Item instance with the updated isChecked value
                        ItemModel updatedItem =
                            item.copyWith(isChecked: value ?? false);

                        // Update the UI and perform other actions if needed
                        setState(() {
                          // Find the index of the item in the list
                          int index = _items.indexOf(item);

                          // Replace the old item with the updated one
                          if (index != -1) {
                            _items[index] = updatedItem;
                          }
                        });

                        // Perform other actions here if needed
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemPage(itemRepository: itemRepository),
              //fullscreenDialog: true,
            ),
          );

          fetchSurvivalKitsData();
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<List<ItemModel>> myAsyncFunction() async {
    List<ItemModel> result = await itemRepository.retrieveItem(userId: userId);
    return result;
  }

  void someAsyncOperation() {
    if (mounted) {
      myAsyncFunction().then((result) {
        if (!_isDisposed) {
          setState(() {
            _items = result;
          });
        }
      });
    }
  }
}
