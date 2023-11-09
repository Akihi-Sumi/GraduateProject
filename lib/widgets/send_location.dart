import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduate_app/widgets/myAlertDialog.dart';

class SendLocation extends StatefulWidget {
  const SendLocation({Key? key}) : super(key: key);

  @override
  State<SendLocation> createState() => _SendLocationState();
}

class _SendLocationState extends State<SendLocation> {
  String _locationMessage = '';
  // String ido = '';
  // String keido = '';
  Position? currentPosition;
  late StreamSubscription<Position> positionStream;

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  @override
  void initState() {
    super.initState();
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      currentPosition = position;
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
  }

  // Future<void> _getLocation() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high,
  //     );
  //     setState(() {
  //       _locationMessage =
  //           '緯度: ${position.latitude}, 経度: ${position.longitude}';
  //     });
  //     print(position);
  //   } catch (e) {
  //     if (mounted) {
  //       setState(() {
  //         _locationMessage = '位置情報の取得に失敗しました: $e';
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(13),
      child: FloatingActionButton(
        child: Image.asset('assets/images/google_maps.png'),
        onPressed: () {
          print(_locationMessage);
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return MyAlertDialog(
                title: "現在地を送信しますか？",
                txt_cancel: "キャンセル",
                txt_ok: "送信",
                onTap: () {
                  positionStream;
                },
              );
            },
          );
        },
      ),
    );
  }
}
