import 'package:flutter/material.dart';
import 'package:graduate_app/model/people_model.dart';
import 'package:graduate_app/ui/profiles/animation_card.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({Key? key, required this.profiles}) : super(key: key);

  final List<ProfileCard> profiles;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 230,
            childAspectRatio: 1,
          ),
          itemCount: profiles.length,
          itemBuilder: (context, index) =>
              AnimationCard(profile: profiles[index]),
        );
      },
    );
  }
}
