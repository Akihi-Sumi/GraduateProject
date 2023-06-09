import 'package:flutter/material.dart';

class ModalWindow extends StatefulWidget {
  const ModalWindow({super.key});

  @override
  _ModalWindowState createState() => _ModalWindowState();
}

class _ModalWindowState extends State<ModalWindow> {
  bool isDispayKeybord = false;
  bool isButtonActive = true;
  TextEditingController controller = TextEditingController();
  final FocusNode _focusUserId = FocusNode();
  final FocusNode _focusPassword = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusUserId.addListener(() => _onFocusChange(_focusUserId));
    _focusPassword.addListener(() => _onFocusChange(_focusPassword));

    controller.addListener(() {
      final isButtonActive = controller.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onFocusChange(FocusNode focus) {
    setState(() {
      if (focus.hasFocus) {
        isDispayKeybord = true;
      } else {
        isDispayKeybord = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isDispayKeybord
          ? MediaQuery.of(context).size.height * 0.3
          : MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'メッセージを追加',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controller,
              autofocus: true,
              focusNode: _focusUserId,
              decoration: const InputDecoration(
                labelText: 'メッセージを追加',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  isButtonActive = value.isNotEmpty;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: isButtonActive
                ? () => {
                      setState(() => isButtonActive = false),
                      Navigator.of(context).pop(),
                    }
                : null,
            child: const Text(
              '追加',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
