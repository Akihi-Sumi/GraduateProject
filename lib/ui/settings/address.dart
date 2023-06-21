import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/ui/settings/qr/qr_gene.dart';
import 'package:graduate_app/ui/settings/qr/qr_scanner.dart';
import 'package:graduate_app/widget/fan_bubble.dart';

@RoutePage()
class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage>
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
        // appBar: AppBar(
        //   backgroundColor: Colors.black,
        //   title: const Text(
        //     "連絡先",
        //     style: TextStyle(
        //       fontSize: 22,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        //   centerTitle: true,
        // ),
        //body: Center(child: Text(_text)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
          padding: EdgeInsets.all(15),
          child: FloatingActionBubble(
            items: <Bubble>[
              // Floating action menu item
              Bubble(
                title: "QRコードをスキャン",
                iconColor: Colors.white,
                bubbleColor: Colors.orange.shade700,
                icon: Icons.qr_code_scanner,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        return QRViewExample();
                      },
                    ),
                  );
                  _animationController.reverse();
                },
              ),
              Bubble(
                title: "QRコードを表示",
                iconColor: Colors.white,
                bubbleColor: Colors.orange.shade700,
                icon: Icons.qr_code,
                titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        return QrCodeScreen();
                      },
                    ),
                  );
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
            iconData: Icons.add,
            backGroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
