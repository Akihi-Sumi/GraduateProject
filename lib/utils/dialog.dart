import 'package:flutter/material.dart';
import 'package:graduate_app/utils/utils.dart';
import 'package:graduate_app/widget/widget.dart';

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
  required String content,
  //required VoidCallback? onPressed,
  required void Function()? onPressed,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text('キャンセル'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text('OK'),
        ),
      ],
    ),
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
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orangeAccent,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.baseLight,
                    ),
                  ),
                  prefixIcon: Icon(Icons.message),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "キャンセル",
              style: TextStyles.p1(
                color: AppColors.baseLight,
              ),
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              "追加",
              style: TextStyles.p1(
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      );
    },
  );
}
