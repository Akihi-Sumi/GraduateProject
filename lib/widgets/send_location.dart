import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;
import 'package:geolocator/geolocator.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/controller/auth.dart';
import 'package:graduate_app/controller/group_message.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/dialog.dart';
import 'package:graduate_app/utils/firestore_refs/group_message_ref.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SendLocation extends ConsumerStatefulWidget {
  const SendLocation({Key? key}) : super(key: key);

  @override
  ConsumerState<SendLocation> createState() => _SendLocationState();
}

class _SendLocationState extends ConsumerState<SendLocation> {
  Future<String?> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, are cannot request permissions.");
    }

    final position = await Geolocator.getCurrentPosition();
    final placeMarks = await geoCoding.placemarkFromCoordinates(
        position.latitude, position.longitude);
    final placeMark = placeMarks[0];

    final String myLocation =
        "${placeMark.postalCode}\n${placeMark.administrativeArea}${placeMark.locality}${placeMark.subLocality}${placeMark.thoroughfare}${placeMark.subThoroughfare}\n${placeMark.name}";
    //debugPrint(myLocation);
    return myLocation;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(sendMessageAllGroupControllerProvider,
        (_, state) async {
      if (state.isLoading) {
        ref.watch(overlayLoadingProvider.notifier).update((state) => true);
        return;
      }

      await state.when(
        data: (_) async {
          ref.watch(overlayLoadingProvider.notifier).update((state) => false);
          ref
              .read(scaffoldMessengerServiceProvider)
              .showSnackBar("メッセージを送信しました");
          Navigator.of(context, rootNavigator: true).pop();
        },
        error: (e, s) async {
          ref.watch(overlayLoadingProvider.notifier).update((state) => false);
          state.showAlertDialogOnError(context);
        },
        loading: () {
          ref.watch(overlayLoadingProvider.notifier).update((state) => true);
        },
      );
    });

    final userId = ref.watch(userIdProvider);
    final appUserName = ref.watch(appUserFutureProvider).maybeWhen<String?>(
          data: (data) => data?.userName,
          orElse: () => null,
        );

    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(13),
      child: FloatingActionButton(
        child: Image.asset('assets/images/google_maps.png'),
        onPressed: () async {
          await showActionDialog(
            context: context,
            title: "現在地を送信しますか",
            buttonText: "送信",
            onPressed: () {
              _getLocation().then((value) async {
                final groupMessage = CreateGroupMessage(
                  content: value.toString(),
                  senderId: appUserName ?? '',
                );

                await ref
                    .read(sendMessageAllGroupControllerProvider.notifier)
                    .sendMessageAllGroup(
                      groupMessage: groupMessage,
                      userId: userId ?? '',
                    );
              });
            },
          );
        },
      ),
    );
  }
}
