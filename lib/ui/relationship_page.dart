import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RelationshipPage extends StatefulWidget {
  const RelationshipPage({Key? key}) : super(key: key);

  @override
  State<RelationshipPage> createState() => _RelationshipPageState();
}

class _RelationshipPageState extends State<RelationshipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Text("送られたメッセージを表示"),
        ),
      ),
    );
  }
}
