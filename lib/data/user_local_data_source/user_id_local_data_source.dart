// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// abstract class UserIdLocalDataSource {
//   Future<void> saveUserId(String userId);
//   Future<String?> getUserId();
// }

// class UserIdLocalDataSourceImpl implements UserIdLocalDataSource {
//   final SharedPreferences sharedPreferences;
//   final String cashKey = 'userId';

//   UserIdLocalDataSourceImpl({
//     required this.sharedPreferences,
//   });

//   @override
//   Future<String?> getUserId() async {
//     if (kDebugMode) {
//       print('айдишник: ${sharedPreferences.getString(cashKey)}');
//     }
//     return sharedPreferences.getString(cashKey);
//   }

//   @override
//   Future<void> saveUserId(String userId) async {
//     await sharedPreferences.setString(cashKey, userId);
//   }
// }
