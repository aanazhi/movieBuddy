import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getMovies();
  Future<List<MovieModel>> searchMovie(String query);
  Future<List<MovieModel>> getFilteredMovies(Map<String, dynamic> params);
}

class MovieRemoteDataSorceImpl implements MovieRemoteDataSource {
  final Dio dio;
  final String apiKey;

  MovieRemoteDataSorceImpl({
    required this.dio,
    required this.apiKey,
  });

  @override
  Future<List<MovieModel>> getFilteredMovies(
      Map<String, dynamic> params) async {
    final response = await dio.get(
      '/movie',
      queryParameters: params,
      options: Options(headers: {'X-API-KEY': apiKey}),
    );

    if (response.statusCode == 200) {
      return (response.data['docs'] as List)
          .map((json) => MovieModel.fromJson(json))
          .toList();
    }
    throw Exception('Ошибка фильтрации: ${response.statusCode}');
  }

  @override
  Future<List<MovieModel>> getMovies() async {
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
        'rating.kp': '8.2-10',
        'lists': 'top250',
      },
      options: Options(
        headers: {
          'X-API-KEY': apiKey,
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> docs = response.data['docs'];
      final List<MovieModel> movies =
          docs.map((json) => MovieModel.fromJson(json)).toList();
      if (kDebugMode) {
        print('Movie loaded: $movies ');
      }
      return movies;
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }

  @override
  Future<List<MovieModel>> searchMovie(String query) async {
    final response = await dio.get(
      '/movie/search',
      queryParameters: {
        'page': 1,
        'limit': 10,
        'query': query,
      },
      options: Options(
        headers: {
          'X-API-KEY': apiKey,
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> docs = response.data['docs'];
      final List<MovieModel> movies = docs.map((json) {
        return MovieModel(
          id: json['id'],
          name: json['name'],
          description: json['description'],
          year: json['year'],
          poster: PosterModel(
            url: json['poster']['url']?.toString() ?? '',
          ),
          genres: (json['genres'] as List?)
                  ?.map(
                    (genre) => GenresModel(
                      name: genre['name'] ?? '',
                    ),
                  )
                  .toList() ??
              [],
          rating: RatingModel(
            kp: double.parse(
              json['rating']['kp']!.toString(),
            ),
          ),
        );
      }).toList();
      return movies;
    } else {
      throw Exception(
        'Failed to search movies ${response.statusCode}',
      );
    }
  }
}
