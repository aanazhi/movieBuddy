import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/domain/image_use_case/image_use_case.dart';

class ImageNotifier extends StateNotifier<File?> {
  final ImageUseCase _imageUseCase;

  ImageNotifier(this._imageUseCase) : super(null);

  Future<void> pickImage() async {
    final file = await _imageUseCase.pickImage();

    state = file;
  }
}
