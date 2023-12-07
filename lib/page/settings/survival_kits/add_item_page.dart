import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/repositories/survival_kits/add_list_model.dart';
import 'package:graduate_app/repositories/survival_kits/list_collection_repository.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/widgets/date_picker_state.dart';
import 'package:graduate_app/widgets/rounded_button.dart';
import 'package:graduate_app/widgets/textform_header.dart';
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
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Consumer<AddItemModel>(builder: (context, model, child) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.backpack_sharp,
                        size: 180,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      Measure.g_24,
                      _ItemNameTextForm(
                        onChanged: (text) => model.title = text,
                      ),
                      // TextField(
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //   ),
                      //   decoration: InputDecoration(
                      //     floatingLabelBehavior: FloatingLabelBehavior.always,
                      //     hintText: '名前を入力',
                      //     hintStyle: TextStyle(color: Colors.grey),
                      //     labelText: '名前',
                      //   ),
                      //   onChanged: (text) {
                      //     model.title = text;
                      //   },
                      // ),
                      Measure.g_12,
                      Row(
                        children: [
                          CupertinoSwitch(
                            value: model.expirationDate != '保存期限なし',
                            onLabelColor: Palette.appColor,
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
                        readOnly: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: '保存期限',
                        ),
                        controller: textEditingController,
                        enabled: model.expirationDate != '保存期限なし',
                        onTap: () async {
                          DateTime? pickedDate = await datePickerState
                              .showCustomDatePicker(context);

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
                      Measure.g_32,
                      PrimaryRoundedButton(
                        width: 160,
                        onTap: () async {
                          try {
                            // Firestore にアイテムを追加する
                            await model.addItemToFirestore(context);

                            // アイテムが追加されたらページを閉じる
                            Navigator.of(context).pop(true);
                          } catch (e) {
                            final snackBar = SnackBar(
                              content: Text(e.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        text: '追加',
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemNameTextForm extends StatelessWidget {
  const _ItemNameTextForm({
    required this.onChanged,
  });

  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextFormHeader(title: 'アイテム名'),
        Measure.g_4,
        TextFormField(
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
