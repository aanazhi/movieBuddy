import 'dart:convert';
import 'package:moviebuddy/data/serial_model/serial_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SerialLocalDataSource {
  Future<List<SerialModel>> getCashedSerials();
  Future<void> cashedSerials(List<SerialModel> serials);
}

class SerialLocalDataSourceImpl implements SerialLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String cashKey = 'cashed_serials';

  SerialLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<void> cashedSerials(List<SerialModel> serials) async {
    final List<Map<String, dynamic>> jsonList =
        serials.map((serial) => serial.toJson()).toList();
    final String jsonString = json.encode(jsonList);
    await sharedPreferences.setString(cashKey, jsonString);
  }

  @override
  Future<List<SerialModel>> getCashedSerials() async {
    final jsonString = sharedPreferences.getString(cashKey);
    if (jsonString != null) {
      final List<dynamic> decodedJson = json.decode(jsonString) as List;
      return decodedJson
          .map((dynamic item) =>
              SerialModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }
}
