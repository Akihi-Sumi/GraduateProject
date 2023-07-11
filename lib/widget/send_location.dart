import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduate_app/widget/myAlertDialog.dart';

class SendLocation extends StatefulWidget {
  const SendLocation({Key? key}) : super(key: key);

  @override
  State<SendLocation> createState() => _SendLocationState();
}

class _SendLocationState extends State<SendLocation> {
  String _locationMessage = '';
  // String ido = '';
  // String keido = '';

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        // ido = '${position.latitude}';
        // keido = '${position.longitude}';
        _locationMessage =
            '緯度: ${position.latitude}\n経度: ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        _locationMessage = '位置情報の取得に失敗しました: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(15),
      child: FloatingActionButton(
        child: Image.asset('assets/images/google_maps.png'),
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return MyAlertDialog(
                title: "現在地を送信しますか？",
                txt_cancel: "キャンセル",
                txt_ok: "送信",
                txt_snack: "現在地を送信しました",
                exe: () {
                  _getLocation();
                  log(_locationMessage);
                },
              );
            },
          );
        },
      ),
    );
  }
}
