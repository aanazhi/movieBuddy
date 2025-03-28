import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserPhotoLocalDataSource {
  Future<void> saveUserPhoto(String userPhotoPath);
  Future<String?> getUserPhoto();
}

class UserPhotoLocalDataSourceImpl implements UserPhotoLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String cashKey = 'userPhoto';

  UserPhotoLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<String?> getUserPhoto() async {
    if (kDebugMode) {
      print('photo: ${sharedPreferences.getString(cashKey)}');
    }
    return sharedPreferences.getString(cashKey);
  }

  @override
  Future<void> saveUserPhoto(String userPhotoPath) async {
    await sharedPreferences.setString(cashKey, userPhotoPath);
  }
}
