import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "設定",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.orange.shade700,
        ),
        body: SafeArea(
          child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 0),
                      child: SizedBox(
                        width: 300,
                        height: 70,
                        child: TextButton(
                          onPressed: () {
                            print("pressed...");
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          child: const Text(
                            "メッセージ設定",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )),
                ],
              )),
        ),
        // body: Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   child: Center(
        //       child: Text(
        //     "Family, Receive, Review, Rip",
        //     style: TextStyle(
        //         color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        //   )),
        // ),
      ),
    );
  }
}
