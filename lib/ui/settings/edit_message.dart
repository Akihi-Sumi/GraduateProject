import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/widget/message.dart';
import 'package:graduate_app/widget/modal_window.dart';
import 'package:graduate_app/widget/popup_menu_button.dart';

@RoutePage()
class EditMessagePage extends StatefulWidget {
  const EditMessagePage({Key? key}) : super(key: key);

  @override
  State<EditMessagePage> createState() => _EditMessagePageState();
}

class _EditMessagePageState extends State<EditMessagePage>
    with SingleTickerProviderStateMixin {
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              "メッセージ設定",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 15),
                icon: Icon(
                  Icons.add_comment_rounded,
                  size: 35,
                  color: Color(0xFFF57C00),
                ),
                onPressed: () => {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF424242),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: ModalWindow(
                          title: "メッセージを追加",
                          tfLabel: "メッセージを入力してください",
                          btnLabel: "追加",
                        ),
                      );
                    },
                  ),
                },
              )
            ],
          ),
        ),
        body:
            //Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //children: [
            SingleChildScrollView(
          padding: EdgeInsets.only(top: 50),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Message(
                  text: "Sample Bubble Sample DEMO",
                  isSender: false,
                ),
              ),
              PopupMenuButtonSample()
            ],
          ),
          //)
          //],
        ),
      ),
    );
  }
}
