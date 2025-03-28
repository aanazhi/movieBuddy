import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/domain/image_use_case/image_use_case.dart';
import 'package:moviebuddy/domain/switch_entity/switch_entity.dart';

class ImageNotifier extends StateNotifier<File?> {
  final ImageUseCase _imageUseCase;

  ImageNotifier(this._imageUseCase) : super(null);

  Future<void> pickImage() async {
    final file = await _imageUseCase.pickImage();

    state = file;
  }
}

class SwitchNotifier extends StateNotifier<SwitchEntity> {
  SwitchNotifier() : super(SwitchEntity());

  void toggleFirstSwitch() {
    state = state.copyWith(isFirstSwitched: !state.isFirstSwitched);
  }

  void toggleSeconfSwitch() {
    state = state.copyWith(isSecondSwitched: !state.isSecondSwitched);
  }
}
