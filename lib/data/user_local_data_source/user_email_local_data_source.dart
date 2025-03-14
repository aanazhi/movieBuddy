import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserEmailLocalDataSource {
  Future<void> saveUserEmail(String userEmail);
  Future<String?> getUserEmail();
}

class UserEmailLocalDataSourceImpl implements UserEmailLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String cashKey = 'userEmail';

  UserEmailLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<String?> getUserEmail() async {
    if (kDebugMode) {
      print('email: ${sharedPreferences.getString(cashKey)}');
    }
    return sharedPreferences.getString(cashKey);
  }

  @override
  Future<void> saveUserEmail(String userEmail) async {
    await sharedPreferences.setString(cashKey, userEmail);
  }
}
