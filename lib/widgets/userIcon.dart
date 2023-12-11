import 'package:flutter/material.dart';
import 'package:graduate_app/theme/palette.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({
    Key? key,
    required this.content,
    required this.onTap,
    this.color,
    this.iconData,
  }) : super(key: key);

  final Widget content;
  final VoidCallback onTap;
  final Color? color;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    const iconSize = 200.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double algo = screenWidth / 411.4;

    return Stack(
      children: [
        Container(
          height: iconSize,
          width: iconSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: content,
        ),
        Positioned(
          bottom: algo * 5.0,
          right: algo * 10.0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.appColor,
              ),
              child: Icon(
                iconData,
                size: 40,
                //size: algo * 37.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
