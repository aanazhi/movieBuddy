import 'dart:io';
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
  Future<void> saveUserPhoto(String userPhotoPath) async {
    print('Saving photo path: $userPhotoPath');
    await sharedPreferences.setString(cashKey, userPhotoPath);
    print('Saved photo path: ${sharedPreferences.getString(cashKey)}');
  }

  @override
  Future<String?> getUserPhoto() async {
    final path = sharedPreferences.getString(cashKey);
    print('Retrieved photo path: $path');

    if (path == null || path.isEmpty) {
      return 'assets/images/black.png';
    }

    try {
      final file = File(path);
      final exists = await file.exists();
      print('File exists: $exists, absolute path: ${file.absolute.path}');
      return exists ? path : 'assets/images/black.png';
    } catch (e) {
      print('Error checking file: $e');
      return 'assets/images/black.png';
    }
  }
}
