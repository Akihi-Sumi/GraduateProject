import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/model/people_data.dart';
import 'package:graduate_app/ui/profiles/profile_list.dart';

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
        child: SizedBox(
          child: ProfileList(profiles: profiles),
        ),
      ),
    );
  }
}
