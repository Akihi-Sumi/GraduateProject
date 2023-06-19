import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/model/people_model.dart';
import 'package:graduate_app/ui/profiles/detailPage.dart';

class AnimationCard extends StatelessWidget {
  const AnimationCard({Key? key, required this.profile}) : super(key: key);

  final ProfileCard profile;

  @override
  Widget build(BuildContext context) {
    ContainerTransitionType transitionType = ContainerTransitionType.fade;

    return Padding(
      padding: EdgeInsets.all(8),
      child: OpenContainer<bool>(
        transitionType: transitionType,
        closedElevation: 0.0,
        openColor: Colors.transparent,
        openBuilder: (BuildContext _, VoidCallback openContainer) {
          return DetailPage(profile: profile);
        },
        closedColor: Colors.transparent,
        closedBuilder: (BuildContext _, VoidCallback openContainer) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.orangeAccent.shade400,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  color: Colors.black,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          child: Image.network(
                            profile.image,
                            height: 130,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                          child: Text(
                            profile.name,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                          child: Text(
                            profile.evacuation,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
