import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectPhotoOptions extends StatelessWidget {
  const SelectPhotoOptions({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function(ImageSource source) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -35,
            child: Container(
              width: 50,
              height: 6,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              SelectPhoto(
                onPressed: () => onTap(ImageSource.gallery),
                icon: Icons.image,
                textLabel: "ギャラリーを開く",
              ),
              const SizedBox(height: 15),
              SelectPhoto(
                onPressed: () => onTap(ImageSource.camera),
                icon: Icons.camera_alt_rounded,
                textLabel: "カメラを起動する",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectPhoto extends StatelessWidget {
  const SelectPhoto({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.textLabel,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String textLabel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade600,
        shape: StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.orange,
            ),
            const SizedBox(width: 14),
            Text(
              textLabel,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
