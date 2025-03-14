import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserNicknameLocalDataSource {
  Future<void> saveUserNickname(String userNickname);
  Future<String?> getUserNickname();
}

class UserNicknameLocalDataSourceImpl implements UserNicknameLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String cashKey = 'userNickname';

  UserNicknameLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<String?> getUserNickname() async {
    if (kDebugMode) {
      print('nickname: ${sharedPreferences.getString(cashKey)}');
    }
    return sharedPreferences.getString(cashKey);
  }

  @override
  Future<void> saveUserNickname(String userNickname) async {
    await sharedPreferences.setString(cashKey, userNickname);
  }
}
