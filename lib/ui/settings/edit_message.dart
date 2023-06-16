import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/widget/modal_window.dart';

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
      duration: const Duration(milliseconds: 260),
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
          preferredSize: const Size.fromHeight(60),
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
                icon: const Icon(
                  Icons.add_comment_outlined,
                  size: 35,
                ),
                //color: Colors.orange[700],
                onPressed: () => {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF424242),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: const ModalWindow(),
                      );
                    },
                  ),
                },
              )
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Center(
                child: Text(
                  "メッセージを追加したり編集したり",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
