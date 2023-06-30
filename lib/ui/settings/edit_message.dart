import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/ui/settings/createMessagePage.dart';
import 'package:graduate_app/widget/message.dart';
import 'package:graduate_app/widget/popup_menu_button.dart';

@RoutePage()
class EditMessagePage extends StatefulWidget {
  const EditMessagePage({Key? key}) : super(key: key);

  @override
  State<EditMessagePage> createState() => _EditMessagePageState();
}

class _EditMessagePageState extends State<EditMessagePage>
    with SingleTickerProviderStateMixin {
  bool tfEnable = false;
  bool modeChange = true;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _animationController.reverse(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Message(
                      isSender: false,
                      changeEnable: tfEnable,
                    ),
                  ),
                  PopupMenuButtonSample(
                    defaultMode: modeChange,
                    onTap: () {
                      setState(() {
                        tfEnable = true;
                        modeChange = false;
                      });
                    },
                    editComplete: () {
                      modeChange = true;
                      tfEnable = false;
                      //Navigator.of(context).pop();
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   builder: (BuildContext context) {
            //     return Container(
            //       decoration: BoxDecoration(
            //         color: Color(0xFF424242),
            //         borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(20),
            //           topRight: Radius.circular(20),
            //         ),
            //       ),
            //       child: ModalWindow(
            //         title: "メッセージを追加",
            //         tfLabel: "メッセージを入力してください",
            //         btnLabel: "追加",
            //       ),
            //     );
            //   },
            // );
            Navigator.push<dynamic>(
              context,
              _sliderAnimationBuilder(
                widget: CreateMessagePage(),
              ),
            );
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_comment_rounded,
            color: Colors.orange[700],
            size: 40,
          ),
        ),
      ),
    );
  }
}

PageRouteBuilder<dynamic> _sliderAnimationBuilder({required Widget widget}) {
  return PageRouteBuilder<dynamic>(
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    fullscreenDialog: true,
    pageBuilder: (context, animation, secondaryAnimation) {
      // 表示する画面のWidget
      return widget;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1); // 下から上
      // final Offset begin = Offset(0.0, -1.0); // 上から下
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: Curves.easeInOut));
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
