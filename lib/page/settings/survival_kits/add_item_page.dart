import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/repositories/survival_kits/add_list_model.dart';
import 'package:graduate_app/repositories/survival_kits/list_collection_repository.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/widgets/date_picker_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddItemPage extends StatelessWidget {
  final ItemRepository
      itemRepository; // Define the itemRepository as a final variable

  // Constructor that takes the ItemRepository as a named parameter
  const AddItemPage({Key? key, required this.itemRepository}) : super(key: key);

  static String nowData() {
    final String currentDate = DateFormat('yyyy年M月d日')
        .format(DateTime.now())
        .toString(); // 現在の日付をフォーマットする
    return currentDate;
  }

  @override
  Widget build(BuildContext context) {
    DatePickerState datePickerState = DatePickerState();
    TextEditingController textEditingController;
    textEditingController =
        TextEditingController(text: nowData()); // 保存期限の初期値をセット
    FocusNode focusNode = FocusNode();

    return ChangeNotifierProvider<AddItemModel>(
      create: (_) => AddItemModel(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "アイテムを追加",
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Consumer<AddItemModel>(builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: '名前を入力',
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: '名前',
                      ),
                      onChanged: (text) {
                        model.title = text;
                      },
                      focusNode: focusNode,
                    ),
                    Measure.g_12,
                    Row(
                      children: [
                        CupertinoSwitch(
                          value: model.expirationDate != '保存期限なし',
                          onChanged: (value) {
                            model.expirationDate =
                                value ? textEditingController.text : '保存期限なし';
                          },
                        ),
                        Text('期限あり'),
                      ],
                    ),
                    Measure.g_12,
                    TextField(
                      decoration: InputDecoration(
                        labelText: '保存期限',
                      ),
                      controller: textEditingController,
                      enabled: model.expirationDate != '保存期限なし',
                      onTap: () async {
                        DateTime? pickedDate =
                            await datePickerState.showCustomDatePicker(context);

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy年MM月dd日').format(pickedDate);
                          textEditingController =
                              TextEditingController(text: formattedDate);
                          model.expirationDate = formattedDate;
                        }
                      },
                      onChanged: (text) {
                        // Save the cursor position
                        final cursorPosition =
                            textEditingController.selection.baseOffset;

                        // Update the controller text
                        textEditingController.text = text;

                        // Restore the cursor position
                        textEditingController.selection =
                            TextSelection.fromPosition(
                          TextPosition(offset: cursorPosition),
                        );

                        if (model.expirationDate != '保存期限なし') {
                          model.expirationDate = text;
                        }
                      },
                    ),
                    Measure.g_12,
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          // Firestore にアイテムを追加する
                          await model.addItemToFirestore(context);

                          // アイテムが追加されたらページを閉じる
                          Navigator.of(context).pop(true);
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text('追加する'),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
