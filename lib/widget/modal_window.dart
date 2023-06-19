import 'package:flutter/material.dart';

class ModalWindow extends StatefulWidget {
  const ModalWindow(
      {super.key,
      required this.title,
      required this.tfLabel,
      required this.btnLabel});

  final String title;
  final String tfLabel;
  final String btnLabel;

  @override
  State<ModalWindow> createState() => _ModalWindowState();
}

class _ModalWindowState extends State<ModalWindow> {
  bool isDisplayKeyboard = false;
  bool isButtonActive = true;
  TextEditingController controller = TextEditingController();
  final FocusNode _focusTextField = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusTextField.addListener(() => _onFocusChange(_focusTextField));

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
        isDisplayKeyboard = true;
      } else {
        isDisplayKeyboard = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isDisplayKeyboard
          ? MediaQuery.of(context).size.height * 0.3
          : MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controller,
              autofocus: true,
              focusNode: _focusTextField,
              decoration: InputDecoration(
                labelText: widget.tfLabel,
                labelStyle: TextStyle(color: Colors.white, fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
              onChanged: (value) {
                setState(() {
                  isButtonActive = value.isNotEmpty;
                });
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[700],
              foregroundColor: Colors.black,
            ),
            onPressed: isButtonActive
                ? () => {
                      setState(() => isButtonActive = false),
                      Navigator.of(context).pop(),
                    }
                : null,
            child: Text(
              widget.btnLabel,
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
