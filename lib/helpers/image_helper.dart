import 'dart:developer';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<XFile?> pick({ImageSource source = ImageSource.gallery}) async {
    try {
      final image = await _imagePicker.pickImage(source: source);
      return image;
    } catch (e) {
      log('[ImageHelper] pick: $e');
      return null;
    }
  }

  Future<CroppedFile?> crop({
    required XFile file,
    CropStyle cropStyle = CropStyle.rectangle,
  }) async {
    try {
      return await _imageCropper.cropImage(
        cropStyle: cropStyle,
        sourcePath: file.path,
        compressQuality: 80,
      );
    } catch (e) {
      log('[ImageHelper] crop: $e');
      return null;
    }
  }
}
