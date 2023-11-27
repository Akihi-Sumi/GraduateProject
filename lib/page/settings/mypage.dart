import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduate_app/controller/app_user.dart';
import 'package:graduate_app/controller/user_profile_controller.dart';
import 'package:graduate_app/utils/constants/app_colors.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/widgets/select_photo_options.dart';
import 'package:graduate_app/widgets/textform_header.dart';
import 'package:graduate_app/widgets/userIcon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class MyProfilePage extends ConsumerStatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyProfilePageState();
}

class MyProfilePageState extends ConsumerState<MyProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController evacuationController;

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
      Navigator.of(context).pop();
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

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: ref.read(appUserFutureProvider).value?.userName ?? '');
    emailController = TextEditingController(
      text: ref.read(appUserFutureProvider).value?.userEmail ?? '',
    );
    evacuationController = TextEditingController(
      text: ref.read(appUserFutureProvider).value?.userEvacuation ?? '',
    );
  }

  void save() {
    // appUserを変更
    ref.read(userProfileControllerProvider.notifier).editUserProfile(
          profileFile: _image,
          userName: nameController.text.trim(),
          userEmail: emailController.text.trim(),
          userEvacuation: evacuationController.text.trim(),
          context: context,
        );
    // Authenticationを変更
    //ref.read(editEmailProvider.notifier).emailUpdate(emailController.text);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    evacuationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    final appUserPicture = ref.watch(appUserFutureProvider).maybeWhen(
          data: (data) => data?.profilePicture,
          orElse: () => null,
        );

    // final userEvacuation = useTextEditingController(text: "保存した避難場所");

    // キーボード外をタップで収納するよう変更 (済み)
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            title: Text(
              context.topRoute.title(context),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            leading: BackButton(
              onPressed: () => context.popRoute(),
            ),
            backgroundColor: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: bottomSpace),
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserIcon(
                  content: Center(
                    child: _image == null
                        ? const Text(
                            "No Image",
                            style: TextStyle(fontSize: 24),
                          )
                        : _image != null
                            ? CircleAvatar(
                                backgroundImage: FileImage(_image!),
                                radius: 200.0,
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    NetworkImage(appUserPicture ?? ''),
                                radius: 200.0,
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
                  width: 140,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      //メールアドレスのバリデーション & 名前と避難場所の欄が空白じゃないとき
                      if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text) &&
                          nameController.text.isNotEmpty &&
                          evacuationController.text.isNotEmpty) {
                        save;
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
                                color: Colors.red,
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
                                  style: TextStyle(fontSize: 17.5),
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
                                color: Colors.red,
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
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        return;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.orange[700],
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(
                      "保存",
                      style: TextStyle(
                        color: Colors.black,
                        //fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
            style: TextStyle(color: Colors.amber, fontSize: 18),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white, fontSize: 16),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade700),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.clear,
                  color: AppColors.baseLight,
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
            style: TextStyle(color: Colors.amber, fontSize: 18),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white, fontSize: 16),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade700),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.clear,
                  color: AppColors.baseLight,
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
            style: TextStyle(color: Colors.amber, fontSize: 18),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white, fontSize: 16),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade700),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              suffixIcon: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.clear,
                  color: AppColors.baseLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
