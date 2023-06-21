import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/widget/message.dart';

@RoutePage()
class HomeScreenPage extends StatelessWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Message(isSender: true, text: "助けて"),
          ),
        ),
      ],
    );
  }
}
