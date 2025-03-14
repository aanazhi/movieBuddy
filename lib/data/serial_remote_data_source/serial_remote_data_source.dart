import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moviebuddy/data/serial_model/serial_model.dart';

abstract class SerialRemoteDataSource {
  Future<List<SerialModel>> getSerials();
}

class SerialRemoteDataSourceImpl implements SerialRemoteDataSource {
  final Dio dio;
  final String apiKey;

  SerialRemoteDataSourceImpl({
    required this.dio,
    required this.apiKey,
  });

  @override
  Future<List<SerialModel>> getSerials() async {
    final response = await dio.get(
      '/movie',
      queryParameters: {
        'page': 1,
        'limit': 10,
        'selectFields': [
          'name',
          'description',
          'year',
          'rating',
          'genres',
          'poster',
        ],
        'type': [
          'tv-series',
          'animated-series',
        ],
        'rating.kp': '7.5-10',
      },
      options: Options(
        headers: {
          'X-API-KEY': apiKey,
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> docs = response.data['docs'];
      final List<SerialModel> serials =
          docs.map((json) => SerialModel.fromJson(json)).toList();
      if (kDebugMode) {
        print('Serials loaded: $serials ');
      }
      return serials;
    } else {
      throw Exception('Failed to load serials: ${response.statusCode}');
    }
  }
}
