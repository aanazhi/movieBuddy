import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImageRepository {
  Future<File?> pickImage();
}

class ImageRepositoryImpl implements ImageRepository {
  final ImagePicker _imagePicker;

  ImageRepositoryImpl({required ImagePicker imagePicker})
      : _imagePicker = imagePicker;

  @override
  Future<File?> pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
