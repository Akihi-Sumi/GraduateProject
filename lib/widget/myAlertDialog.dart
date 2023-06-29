import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({
    Key? key,
    required this.title,
    required this.txt_cancel,
    required this.txt_ok,
    required this.txt_snack,
  }) : super(key: key);

  final String title;
  final String txt_cancel;
  final String txt_ok;
  final String txt_snack;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 21.5,
          fontWeight: FontWeight.bold,
        ),
      ),
      // content: SizedBox(
      //   height: 10,
      // ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: size.height * 0.075,
                width: size.width * 0.35,
                alignment: Alignment.center,
                child: Text(
                  txt_cancel,
                  style: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 17.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      txt_snack,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );

                Navigator.pop(context);
              },
              child: Container(
                height: size.height * 0.045,
                width: size.width * 0.3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  txt_ok,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
