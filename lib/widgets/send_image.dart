import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduate_app/controller/auth.dart';
import 'package:graduate_app/controller/group_message.dart';
import 'package:graduate_app/controller/user_profile/user.dart';
import 'package:graduate_app/utils/async_value_error_dialog.dart';
import 'package:graduate_app/utils/dialog.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/utils/scaffold_messenger_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SendImage extends ConsumerStatefulWidget {
  const SendImage({
    Key? key,
    required this.height,
    required this.width,
    required this.iconSize,
  }) : super(key: key);

  final double height;
  final double width;
  final double iconSize;

  @override
  ConsumerState<SendImage> createState() => _SendImageState();
}

class _SendImageState extends ConsumerState<SendImage> {
  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);

      setState(() {
        _image = img;
        //Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      //Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
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
              Icons.image,
              size: widget.iconSize,
            ),
          ),
        ),
      ),
      onTap: () async {
        _pickImage(ImageSource.gallery);

        await showActionDialog(
          context: context,
          title: '選択した画像を送信しますか',
          buttonText: "送信",
          onPressed: () async {
            ref.read(overlayLoadingProvider.notifier).update((state) => true);
            try {
              final controller =
                  ref.read(sendAllGroupControllerProvider(userId));

              controller.sendAllGroup(
                userId: userName,
                picture: _image,
              );
            } on AppException {
              rethrow;
            } finally {
              ref
                  .read(overlayLoadingProvider.notifier)
                  .update((state) => false);
            }

            // final groupMessage = CreateGroupMessage(
            //   content: _image,
            //   senderId: userName,
            // );

            // await ref
            //     .read(sendMessageAllGroupControllerProvider.notifier)
            //     .sendMessageAllGroup(
            //       groupMessage: groupMessage,
            //       userId: userId,
            //     );
          },
        );
      },
    );
  }
}
