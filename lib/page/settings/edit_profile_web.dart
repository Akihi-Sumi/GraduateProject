import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduate_app/controller/user_profile/user.dart';
import 'package:graduate_app/controller/user_profile/user_profile_controller.dart';
import 'package:graduate_app/models/user/user_model.dart';
import 'package:graduate_app/page/settings/edit_profile_mobile.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/utils/enum.dart';
import 'package:graduate_app/utils/exceptions/exception.dart';
import 'package:graduate_app/utils/loading.dart';
import 'package:graduate_app/widgets/select_photo_options.dart';
import 'package:graduate_app/widgets/textform_header.dart';
import 'package:graduate_app/widgets/userIcon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileWeb extends ConsumerStatefulWidget {
  const EditProfileWeb({
    Key? key,
    required this.userId,
    required this.user,
    required this.displayStyle,
  }) : super(key: key);

  final String userId;
  final ReadUser? user;
  final PageDisplayStyle displayStyle;

  @override
  ConsumerState<EditProfileWeb> createState() => EditProfileWebState();
}

class EditProfileWebState extends ConsumerState<EditProfileWeb> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController evacuationController;

  //Uint8List? _webImage;
  String? _uploadedBlobUrl;
  String? _croppedBlobUrl;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        //final img = image.path;
        final blobUrl = image.path;

        setState(() {
          //_webImage = img;
          _uploadedBlobUrl = blobUrl;
        });
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _cropImage() async {
    WebUiSettings settings;
    if (widget.displayStyle == PageDisplayStyle.mobile) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      settings = WebUiSettings(
        context: context,
        presentStyle: CropperPresentStyle.page,
        boundary: CroppieBoundary(
          width: (screenWidth * 0.9).round(),
          height: (screenHeight * 0.9).round(),
        ),
        viewPort: const CroppieViewPort(
          width: 400,
          height: 400,
          type: 'circle',
        ),
        enableExif: true,
        enableZoom: true,
        showZoomer: true,
        mouseWheelZoom: true,
      );
    } else {
      settings = WebUiSettings(
        context: context,
        presentStyle: CropperPresentStyle.page,
        boundary: CroppieBoundary(
          width: 400,
          height: 400,
        ),
        viewPort: const CroppieViewPort(
          width: 400,
          height: 400,
          type: 'circle',
        ),
        enableExif: true,
        enableZoom: true,
        showZoomer: true,
        mouseWheelZoom: true,
      );
    }
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: _uploadedBlobUrl!,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [settings],
    );
    if (croppedImage != null) {
      setState(() {
        _croppedBlobUrl = croppedImage.path;
      });
    }
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

  void save() {
    ref.read(overlayLoadingProvider.notifier).update((state) => true);

    try {
      final controller = ref.read(userProfileControllerProvider(widget.userId));

      controller.update(
        userId: widget.userId,
        userName: nameController.text,
        userEmail: emailController.text,
        userEvacuation: evacuationController.text,
        profileWebPicture: _convertListToInt(_croppedBlobUrl!),
      );

      _croppedBlobUrl = null;
      _uploadedBlobUrl = null;
    } on AppException {
      rethrow;
    } finally {
      ref.read(overlayLoadingProvider.notifier).update((state) => false);
    }
  }

  Uint8List _convertListToInt(String input) {
    final reg = RegExp(r"([0-9]+|\d+)");
    final pieces = reg.allMatches(input);
    final result = pieces.map((e) => int.parse(e.group(0).toString())).toList();

    List<int> example = result;

    return Uint8List.fromList(example);
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

  @override
  Widget build(BuildContext context) {
    final userImage = ref.watch(userImageProfileProvider(widget.userId));
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: bottomSpace),
      child: widget.displayStyle == PageDisplayStyle.mobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //if (userImage != '')
                UserIcon(
                  content: Center(
                    child: _croppedBlobUrl != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(_croppedBlobUrl!),
                            radius: 200,
                          )
                        : _uploadedBlobUrl != null
                            ? SizedBox(
                                height: 250,
                                width: 250,
                                child: Image.network(
                                  _uploadedBlobUrl!,
                                ),
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
                  iconData:
                      _uploadedBlobUrl != null ? Icons.crop : Icons.image_sharp,
                  onTap: () {
                    _uploadedBlobUrl != null
                        ? _cropImage()
                        : _showSelectPhotoOptions(context);
                  },
                ),
                SizedBox(height: 30),
                //_imageBody(),
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
                SizedBox(height: 50),
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
            )
          : Row(),
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
