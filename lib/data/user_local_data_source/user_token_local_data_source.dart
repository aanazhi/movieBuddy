import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserTokenLocalDataSource {
  Future<void> saveUserToken(String token);
  Future<String?> getUserToken();
}

class UserTokenLocalDataSourceImpl implements UserTokenLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String cashKey = 'userToken';

  UserTokenLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<String?> getUserToken() async {
    if (kDebugMode) {
      print('token: ${sharedPreferences.getString(cashKey)}');
    }
    return sharedPreferences.getString(cashKey);
  }

  @override
  Future<void> saveUserToken(String token) async {
    await sharedPreferences.setString(cashKey, token);
  }
}
