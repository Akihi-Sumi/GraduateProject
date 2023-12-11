import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduate_app/controller/auth.dart';
import 'package:graduate_app/controller/group_message.dart';
import 'package:graduate_app/controller/user_profile/user.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/dialog.dart';
import 'package:graduate_app/utils/firestore_refs/group_message_ref.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class SendImageFromCamera extends ConsumerStatefulWidget {
  const SendImageFromCamera({
    Key? key,
    required this.height,
    required this.width,
    required this.iconSize,
  }) : super(key: key);

  final double height;
  final double width;
  final double iconSize;

  @override
  ConsumerState<SendImageFromCamera> createState() =>
      SendImageFromCameraState();
}

class SendImageFromCameraState extends ConsumerState<SendImageFromCamera> {
  File? _image;
  Uint8List? _webImage;

  Future _pickImageFromCamera(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      if (!kIsWeb) {
        File? img = File(image.path);

        setState(() {
          _image = img;
        });
      } else {
        Uint8List img = await image.readAsBytes();

        setState(() {
          _webImage = img;
        });
      }
    } on PlatformException catch (e) {
      print(e);
    }
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
          ref.read(scaffoldMessengerServiceProvider).showSnackBar("画像を送信しました");

          context.router.popUntilRoot();
          // Navigator.of(context, rootNavigator: true).pop();
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

    final userId = ref.watch(userIdProvider) ?? '';
    final userName = ref.watch(userNameProvider(userId));

    return GestureDetector(
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          //color: Colors.black,
          elevation: 16,
          child: Center(
            child: Icon(
              Icons.add_a_photo_sharp,
              size: widget.iconSize,
            ),
          ),
        ),
      ),
      onTap: () async {
        _pickImageFromCamera(ImageSource.camera);

        await showActionDialog(
          context: context,
          title: '撮影した写真を送信しますか',
          buttonText: "送信",
          onPressed: () async {
            if (!kIsWeb) {
              await ref
                  .read(sendMessageAllGroupControllerProvider.notifier)
                  .sendMessageAllGroup(
                    userId: userId,
                    userName: userName,
                    picture: _image,
                    messageType: MessageType.picture,
                  );
              _image = null;
            } else {
              await ref
                  .read(sendMessageAllGroupControllerProvider.notifier)
                  .sendMessageAllGroup(
                    userId: userId,
                    userName: userName,
                    webPicture: _webImage,
                    messageType: MessageType.picture,
                  );
              _webImage = null;
            }
          },
        );
      },
    );
  }
}
