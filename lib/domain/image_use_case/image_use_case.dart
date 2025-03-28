import 'dart:io';

import 'package:moviebuddy/data/image_repository/image_repository.dart';

class ImageUseCase {
  final ImageRepository _imageRepository;

  ImageUseCase({required ImageRepository imageRepository})
      : _imageRepository = imageRepository;

  Future<File?> pickImage() async {
    return await _imageRepository.pickImage();
  }
}
