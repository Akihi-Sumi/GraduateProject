import 'package:flutter/material.dart';
import 'package:graduate_app/utils/constants/app_colors.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/widgets/textform_header.dart';

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  required String defaultActionText,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: <Widget>[
        if (cancelActionText != null)
          TextButton(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        TextButton(
          child: Text(defaultActionText),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
}

Future<bool?> showActionDialog({
  required BuildContext context,
  required String title,
  required void Function()? onPressed,
  required String buttonText,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        insetPadding: Measure.p_a16,
        content: SizedBox(
          width: 290,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "キャンセル",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent.shade700,
                fixedSize: Size(130, 40),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> createMessageDialog(
  BuildContext context,
  TextEditingController controller, {
  required VoidCallback onPressed,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: Measure.p_a16,
        content: SizedBox(
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextFormHeader(title: "メッセージを追加"),
              Measure.g_4,
              TextFormField(
                maxLength: 20,
                controller: controller,
                decoration: InputDecoration(hintText: "入力してください"),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 30,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "キャンセル",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 20,
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                fixedSize: Size(130, 40),
              ),
              child: Text(
                "追加",
                style: TextStyle(
                  color: AppColors.baseBlack,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> editMessageDialog(
  BuildContext context,
  TextEditingController controller, {
  required VoidCallback onPressed,
}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: Measure.p_a16,
        content: SizedBox(
          width: 280,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextFormHeader(title: "メッセージを編集"),
              Measure.g_4,
              TextFormField(
                maxLength: 20,
                controller: controller,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.edit_square,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 30,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "キャンセル",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 20,
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                fixedSize: Size(130, 40),
              ),
              child: Text(
                "編集",
                style: TextStyle(
                  color: AppColors.baseBlack,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
