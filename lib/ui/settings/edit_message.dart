import 'package:flutter/material.dart';
import 'package:graduate_app/fan/fan_bubble.dart';

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
          floatingActionButton: FloatingActionBubble(
            items: <Bubble>[
              Bubble(
                title: "Settings",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.settings,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  _animationController.reverse();
                },
              ),
              // Floating action menu item
              Bubble(
                title: "Profile",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.people,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  _animationController.reverse();
                },
              ),
              //Floating action menu item
              Bubble(
                title: "Home",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.home,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const EditMessagePage()));
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
            iconColor: Colors.blue,

            // Floating Action button Icon
            iconData: Icons.ac_unit,
            backGroundColor: Colors.white,
          )),
    );
  }
}
