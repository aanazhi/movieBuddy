import 'dart:convert';
import 'package:moviebuddy/data/movie_model/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>> getCashedMovies();
  Future<void> cashedMovies(List<MovieModel> movies);
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String cashKey = 'cashed_movies';

  MovieLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<void> cashedMovies(List<MovieModel> movies) async {
    final List<Map<String, dynamic>> jsonList =
        movies.map((movie) => movie.toJson()).toList();
    final String jsonString = json.encode(jsonList);
    await sharedPreferences.setString(cashKey, jsonString);
  }

  @override
  Future<List<MovieModel>> getCashedMovies() async {
    final jsonString = sharedPreferences.getString(cashKey);
    if (jsonString != null) {
      final List<dynamic> decodedJson = json.decode(jsonString) as List;
      return decodedJson
          .map((dynamic item) =>
              MovieModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }
}
