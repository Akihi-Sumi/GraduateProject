import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({Key? key}) : super(key: key);

  // final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    const iconSize = 200.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double algo = screenWidth / 411.4;

    return Stack(
      children: [
        Icon(
          Icons.account_circle_sharp,
          size: iconSize,
        ),
        // CircleAvatar(
        //   radius: 100,
        // backgroundImage: NetworkImage(
        //   /// profileImage
        //   "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80",
        // ),
        //),
        Positioned(
          bottom: algo * 5.0,
          right: algo * 10.0,
          child: GestureDetector(
            onTap: () {
              /// デバイスに保存されている写真を選ぶ処理
              // PickImage(context);
              print("写真を選択");
            },
            child: CircleAvatar(
              radius: algo * 30.0,
              backgroundColor: Colors.orange[700],
              child: Icon(
                Icons.camera_alt,
                size: algo * 38.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
