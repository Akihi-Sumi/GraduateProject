import 'package:flutter/material.dart';
import 'package:graduate_app/fan_floating_menu/src/simple_speed_dial.dart';
import 'package:graduate_app/fan_floating_menu/src/simple_speed_dial_child.dart';

class EditMessagePage extends StatefulWidget {
  const EditMessagePage({Key? key}) : super(key: key);

  @override
  _EditMessagePageState createState() => _EditMessagePageState();
}

class _EditMessagePageState extends State<EditMessagePage> {
  String _text = "";

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
        body: Center(child: Text(_text)),
        floatingActionButton: SpeedDial(
          speedDialChildren: <SpeedDialChild>[
            SpeedDialChild(
              child: const Icon(Icons.directions_run),
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              label: 'Let\'s go for a run!',
              onPressed: () {
                setState(() {
                  _text = 'You pressed "Let\'s go for a run!"';
                });
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.directions_walk),
              foregroundColor: Colors.black,
              backgroundColor: Colors.yellow,
              label: 'Let\'s go for a walk!',
              onPressed: () {
                setState(() {
                  _text = 'You pressed "Let\'s go for a walk!"';
                });
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.directions_bike),
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              label: 'Let\'s go cycling!',
              onPressed: () {
                setState(() {
                  _text = 'You pressed "Let\'s go cycling!"';
                });
              },
            ),
          ],
          closedForegroundColor: Colors.black,
          openForegroundColor: Colors.white,
          closedBackgroundColor: Colors.white,
          openBackgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
