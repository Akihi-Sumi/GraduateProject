import 'package:flutter/material.dart';
import '../address.dart';

class TuutihanniScreen extends StatefulWidget {
  final String? qrCode;

  const TuutihanniScreen({Key? key, this.qrCode}) : super(key: key);

  @override
  _TuutihanniScreenState createState() => _TuutihanniScreenState();
}

class _TuutihanniScreenState extends State<TuutihanniScreen> {
  List<bool> checkboxValues = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("連絡先"),
        backgroundColor: Colors.orange.shade700,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "TuutihanniScreen",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "QRコード: ${widget.qrCode ?? '読み取られていません'}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                title: Text("地震"),
                value: checkboxValues[0],
                onChanged: (value) {
                  setState(() {
                    checkboxValues[0] = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("津波"),
                value: checkboxValues[1],
                onChanged: (value) {
                  setState(() {
                    checkboxValues[1] = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("台風"),
                value: checkboxValues[2],
                onChanged: (value) {
                  setState(() {
                    checkboxValues[2] = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressScreen(),
                    ),
                  );
                },
                child: Text("保存"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
