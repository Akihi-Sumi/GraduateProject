import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduate_app/controller/user_profile/user.dart';
import 'package:graduate_app/controller/user_profile/user_profile_controller.dart';
import 'package:graduate_app/models/app_user/app_user.dart';
import 'package:graduate_app/responsive/responsive_widget.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/widgets/rounded_button.dart';
import 'package:graduate_app/widgets/select_photo_options.dart';
import 'package:graduate_app/widgets/textform_header.dart';
import 'package:graduate_app/widgets/userIcon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileForm extends ConsumerStatefulWidget {
  const EditProfileForm({
    Key? key,
    required this.userId,
    required this.user,
  }) : super(key: key);

  final String userId;
  final AppUser? user;

  @override
  ConsumerState<EditProfileForm> createState() => EditProfileFormState();
}

class EditProfileFormState extends ConsumerState<EditProfileForm> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController evacuationController;

  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);

      setState(() {
        _image = img;
        Navigator.of(context).pop();
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

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptions(
                onTap: _pickImage,
              ),
            );
          },
        );
      },
    );
  }

  void _initializeTextEditingControllers() {
    nameController = TextEditingController(text: widget.user?.userName);
    emailController = TextEditingController(text: widget.user?.userEmail);
    evacuationController =
        TextEditingController(text: widget.user?.userEvacuation);
  }

  @override
  void initState() {
    super.initState();
    _initializeTextEditingControllers();
  }

  void save() {
    ref.read(overlayLoadingProvider.notifier).update((state) => true);

    try {
      final controller = ref.read(userProfileControllerProvider(widget.userId));

      controller.update(
        userId: widget.userId,
        userName: nameController.text,
        userEmail: emailController.text,
        userEvacuation: evacuationController.text,
        profilePicture: _image,
      );
    } on AppException {
      rethrow;
    } finally {
      ref.read(overlayLoadingProvider.notifier).update((state) => false);
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   nameController.dispose();
  //   emailController.dispose();
  //   evacuationController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    final userImage = ref.watch(userImageProfileProvider(widget.userId));

    //final isLoading = ref.watch(userProfileControllerProvider);

    // キーボード外をタップで収納するよう変更 (済み)
    return ResponsiveLayout(
      mobileBody: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottomSpace),
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 20, 8, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserIcon(
                content: Center(
                  child: _image != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(_image!),
                          radius: 200,
                        )
                      : userImage != ''
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(userImage),
                              radius: 200,
                            )
                          : Text(
                              "No Image",
                              style: TextStyle(fontSize: 24),
                            ),
                ),
                onTap: () {
                  _showSelectPhotoOptions(context);
                },
              ),
              SizedBox(height: 30),
              _EditUserNameTextForm(
                controller: nameController,
                onPressed: () => nameController.clear(),
              ),
              SizedBox(height: 20),
              _EditEmailTextForm(
                controller: emailController,
                onPressed: () => emailController.clear(),
              ),
              SizedBox(height: 20),
              _EditEvacuationTextForm(
                controller: evacuationController,
                onPressed: () => evacuationController.clear(),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 160,
                height: 50,
                child: SaveButton(
                  emailController: emailController,
                  nameController: nameController,
                  evacuationController: evacuationController,
                  save: save,
                ),
              ),
            ],
          ),
        ),
      ),
      tabletBody: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: _image != null
                    ? CircleAvatar(
                        backgroundImage: FileImage(_image!),
                        radius: 125,
                      )
                    : userImage != ''
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(userImage),
                            radius: 125,
                          )
                        : Text(
                            "No Image",
                            style: TextStyle(fontSize: 24),
                          ),
              ),
              SizedBox(width: 40),
              PrimaryRoundedButton(
                text: "アイコン画像を編集",
                width: 200,
                onTap: () {
                  _showSelectPhotoOptions(context);
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          _EditUserNameTextForm(
            controller: nameController,
            onPressed: () => nameController.clear(),
          ),
          SizedBox(height: 20),
          _EditEmailTextForm(
            controller: emailController,
            onPressed: () => emailController.clear(),
          ),
          SizedBox(height: 20),
          _EditEvacuationTextForm(
            controller: evacuationController,
            onPressed: () => evacuationController.clear(),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: 160,
            height: 50,
            child: SaveButton(
              emailController: emailController,
              nameController: nameController,
              evacuationController: evacuationController,
              save: save,
            ),
          ),
        ],
      ),
      desktopBody: Row(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: _image != null
                    ? CircleAvatar(
                        backgroundImage: FileImage(_image!),
                        radius: 200,
                      )
                    : userImage != ''
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(userImage),
                            radius: 200,
                          )
                        : Text(
                            "No Image",
                            style: TextStyle(fontSize: 24),
                          ),
              ),
              SizedBox(height: 40),
              PrimaryRoundedButton(
                text: "アイコン画像を編集",
                width: 200,
                onTap: () {
                  _showSelectPhotoOptions(context);
                },
              )
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _EditUserNameTextForm(
                  controller: nameController,
                  onPressed: () => nameController.clear(),
                ),
                SizedBox(height: 20),
                _EditEmailTextForm(
                  controller: emailController,
                  onPressed: () => emailController.clear(),
                ),
                SizedBox(height: 20),
                _EditEvacuationTextForm(
                  controller: evacuationController,
                  onPressed: () => evacuationController.clear(),
                ),
                SizedBox(height: 40),
                SaveButton(
                  width: 200,
                  emailController: emailController,
                  nameController: nameController,
                  evacuationController: evacuationController,
                  save: save,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EditUserNameTextForm extends StatelessWidget {
  const _EditUserNameTextForm({
    required this.controller,
    required this.onPressed,
  });

  final TextEditingController controller;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          TextFormHeader(title: "名前"),
          Measure.g_4,
          TextFormField(
            controller: controller,
            style: TextStyle(color: Palette.appColor, fontSize: 18),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Palette.whiteColor, fontSize: 16),
              suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.clear,
                ),
              ),
            ),
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}

class _EditEmailTextForm extends StatelessWidget {
  const _EditEmailTextForm({
    required this.controller,
    required this.onPressed,
  });

  final TextEditingController controller;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          TextFormHeader(title: "メールアドレス"),
          Measure.g_4,
          TextFormField(
            controller: controller,
            style: TextStyle(color: Palette.appColor, fontSize: 18),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Palette.whiteColor, fontSize: 16),
              suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.clear,
                ),
              ),
            ),
            // メールアドレス用のキーボードを表示する
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}

class _EditEvacuationTextForm extends StatelessWidget {
  const _EditEvacuationTextForm({
    required this.controller,
    required this.onPressed,
  });

  final TextEditingController controller;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Measure.p_h32,
      child: Column(
        children: [
          TextFormHeader(title: "避難場所"),
          Measure.g_4,
          TextFormField(
            controller: controller,
            style: TextStyle(color: Palette.appColor, fontSize: 18),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Palette.whiteColor, fontSize: 16),
              suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.clear,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SaveButton extends ConsumerWidget {
  const SaveButton({
    this.width,
    required this.emailController,
    required this.nameController,
    required this.evacuationController,
    required this.save,
    super.key,
  });

  final double? width;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController evacuationController;
  final VoidCallback save;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimaryRoundedButton(
      width: width,
      onTap: () {
        //メールアドレスのバリデーション & 名前と避難場所の欄が空白じゃないとき
        if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(emailController.text) &&
            nameController.text.isNotEmpty &&
            evacuationController.text.isNotEmpty) {
          save();
          FocusScope.of(context).unfocus();
        }
        // 空欄があるとき
        else if (nameController.text.isEmpty ||
            emailController.text.isEmpty ||
            evacuationController.text.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "未入力の項目があります",
                style: TextStyle(
                  color: Palette.redColor,
                  fontSize: 23.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "閉じる",
                    style: TextStyle(
                      fontSize: 17.5,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        // メールアドレスが無効なとき
        else {
          showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "メールアドレスが無効です",
                style: TextStyle(
                  color: Palette.redColor,
                  fontSize: 23.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "編集を続ける",
                    style: TextStyle(
                      fontSize: 17.5,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          );
          return;
        }
      },
      text: "保存",
    );
  }
}
