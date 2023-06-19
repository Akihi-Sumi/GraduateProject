import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/model/people_model.dart';
import 'package:graduate_app/ui/profiles/profile_list.dart';

@RoutePage()
class RelationshipPage extends StatefulWidget {
  const RelationshipPage({Key? key}) : super(key: key);

  @override
  State<RelationshipPage> createState() => _RelationshipPageState();
}

class _RelationshipPageState extends State<RelationshipPage> {
  final List<ProfileCard> profiles = [
    ProfileCard(
      name: "墨明飛",
      image:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80",
      email: "nkc20214016@denpa.jp",
      evacuation: "西陵高校",
    ),
    ProfileCard(
      name: "沓名",
      image:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80",
      email: "nkc20214016@denpa.jp",
      evacuation: "西陵高校",
    ),
    ProfileCard(
      name: "高以良",
      image:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80",
      email: "nkc20214016@denpa.jp",
      evacuation: "西陵高校",
    ),
    ProfileCard(
      name: "浅井",
      image:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80",
      email: "nkc20214016@denpa.jp",
      evacuation: "西陵高校",
    ),
    ProfileCard(
      name: "祖父江",
      image:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80",
      email: "nkc20214016@denpa.jp",
      evacuation: "西陵高校",
    ),
    ProfileCard(
      name: "大野",
      image:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80",
      email: "nkc20214016@denpa.jp",
      evacuation: "西陵高校",
    ),
    ProfileCard(
      name: "鈴木",
      image:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80",
      email: "nkc20214016@denpa.jp",
      evacuation: "西陵高校",
    ),
    ProfileCard(
      name: "田中",
      image:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80",
      email: "nkc20214016@denpa.jp",
      evacuation: "西陵高校",
    ),
    ProfileCard(
      name: "山田",
      image:
          "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80",
      email: "nkc20214016@denpa.jp",
      evacuation: "西陵高校",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text(
            "つながり",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: ProfileList(profiles: profiles),
        ),
      ),
    );
  }
}
