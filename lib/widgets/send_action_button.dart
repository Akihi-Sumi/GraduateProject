import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/widgets/send_image.dart';
import 'package:graduate_app/widgets/send_image_from_camera.dart';
import 'package:graduate_app/widgets/send_location.dart';

class SendActionButton extends StatefulWidget {
  const SendActionButton({Key? key}) : super(key: key);

  @override
  State<SendActionButton> createState() => SendActionButtonState();
}

class SendActionButtonState extends State<SendActionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(13),
      child: FloatingActionButton(
        child: Icon(
          Icons.crisis_alert_sharp,
          size: 40,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (builder) {
              return SelectImageCameraLocation();
            },
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SelectImageCameraLocation extends StatelessWidget {
  const SelectImageCameraLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double cardHeightWidth = kIsWeb ? 360 : 120;
    double iconSize = kIsWeb ? 120 : 60;

    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SendImage(
            height: cardHeightWidth,
            width: cardHeightWidth,
            iconSize: iconSize,
          ),
          SendImageFromCamera(
            height: cardHeightWidth,
            width: cardHeightWidth,
            iconSize: iconSize,
          ),
          SendLocation(
            height: cardHeightWidth,
            width: cardHeightWidth,
            iconSize: iconSize,
          ),
        ],
      ),
    );
  }
}
