import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/models/item/item_model.dart';
import 'package:graduate_app/page/settings/survival_kits/add_item_page.dart';
import 'package:graduate_app/repositories/survival_kits/edit_list_model.dart';
import 'package:graduate_app/repositories/survival_kits/list_collection_repository.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/widgets/date_picker_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditItemPage extends StatelessWidget {
  final ItemRepository itemRepository;
  final ItemModel item;

  const EditItemPage({
    super.key,
    required this.item,
    required this.itemRepository,
  });

  // late TextEditingController _textEditingController;

  // EditItemPage({required this.itemRepository, required this.item}) {
  //   _textEditingController =
  //       TextEditingController(text: getExpirationDate(item));
  // }

  String getExpirationDate(ItemModel item) {
    String expirationDate = item.expirationDate;
    if (item.expirationDate == '保存期限なし') {
      expirationDate = AddItemPage.nowData();
    }

    return expirationDate;
  }

  static String getName(ItemModel item) {
    final String itemName = item.name;
    return itemName;
  }

  @override
  Widget build(BuildContext context) {
    DatePickerState datePickerState = DatePickerState();
    TextEditingController itemNameController;
    itemNameController = TextEditingController(text: getName(item));
    TextEditingController expirationDateController;
    expirationDateController =
        TextEditingController(text: getExpirationDate(item));

    return ChangeNotifierProvider<EditItemModel>(
      create: (_) => EditItemModel(itemRepository, item),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "アイテムを編集",
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Consumer<EditItemModel>(
              builder: (context, model, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          //hintText: '商品名',
                          labelText: 'アイテム名',
                        ),
                        controller: itemNameController,
                        onChanged: (text) {
                          model.setTitle(text);
                        },
                      ),
                      Measure.g_12,
                      Row(
                        children: [
                          CupertinoSwitch(
                            value: model.isExpirationDateSet,
                            onChanged: (value) {
                              if (value) {
                                // Update expiration date only if switching from false to true
                                model.expirationDateController.text =
                                    AddItemPage.nowData();
                              }
                              model.setIsExpirationDateSet(value);
                            },
                          ),
                          Text('期限あり'),
                        ],
                      ),
                      Measure.g_12,
                      if (model.isExpirationDateSet)
                        TextField(
                            decoration: InputDecoration(
                              labelText: '保存期限',
                            ),
                            controller: expirationDateController,
                            enabled: model.isExpirationDateSet,
                            onTap: () async {
                              DateTime? pickedDate = await datePickerState
                                  .showCustomDatePicker(context);

                              if (pickedDate != null) {
                                String formattedDate = DateFormat('yyyy年MM月dd日')
                                    .format(pickedDate);
                                model.setExpirationDate(formattedDate);
                                expirationDateController =
                                    TextEditingController(text: formattedDate);
                              }
                            },
                            onChanged: (text) {
                              model.setExpirationDate(text);
                              expirationDateController =
                                  TextEditingController(text: text);
                            }),
                      Measure.g_12,
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            final confirmationResult =
                                await Provider.of<EditItemModel>(
                              context,
                              listen: false,
                            ).showOverwriteConfirmationDialog(
                                    context, itemNameController.text);

                            if (confirmationResult != null &&
                                confirmationResult) {
                              await model.update();
                              final snackBar = SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('アイテムが更新されました'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.of(context).pop(true);
                            }
                          } catch (e) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('アイテムを更新できませんでした'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                        child: Text('更新する'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
