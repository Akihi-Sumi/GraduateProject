import 'package:flutter/material.dart';

class SurvivalKit extends StatelessWidget {
  const SurvivalKit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "防災グッズ",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
      ),
    );
  }
}
