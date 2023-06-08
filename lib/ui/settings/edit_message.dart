import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/fan/fan_bubble.dart';

@RoutePage()
class EditMessagePage extends StatefulWidget {
  const EditMessagePage({Key? key}) : super(key: key);

  @override
  _EditMessagePageState createState() => _EditMessagePageState();
}

class _EditMessagePageState extends State<EditMessagePage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _animationController.reverse(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "メッセージ設定",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.orange.shade700,
        ),
        //body: Center(child: Text(_text)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
          padding: EdgeInsets.all(15),
          child: FloatingActionBubble(
            items: <Bubble>[
              Bubble(
                title: "メッセージを追加",
                iconColor: Colors.white,
                bubbleColor: Colors.orange.shade700,
                icon: Icons.add_comment_outlined,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  _animationController.reverse();
                },
              ),
              // Floating action menu item
              Bubble(
                title: "メッセージを編集",
                iconColor: Colors.white,
                bubbleColor: Colors.orange.shade700,
                icon: Icons.create_sharp,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  _animationController.reverse();
                },
              ),
              //Floating action menu item
              Bubble(
                title: "メッセージを削除",
                iconColor: Colors.white,
                bubbleColor: Colors.orange.shade700,
                icon: Icons.delete,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  _animationController.reverse();
                },
              ),
            ],
            animation: _animation,

            // On pressed change animation state
            onPress: () => _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward(),

            // Floating Action button Icon color
            iconColor: Colors.orange.shade700,

            // Floating Action button Icon
            iconData: Icons.density_medium,
            backGroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
