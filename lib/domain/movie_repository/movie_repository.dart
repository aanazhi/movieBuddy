import 'package:flutter/foundation.dart';
import 'package:moviebuddy/data/movie_local_data_source/movie_local_data_source.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';
import 'package:moviebuddy/data/movie_remote_data_source/movie_remote_data_source.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getMovies();
}

class MovieRepositoryImpl implements MovieRepository {
  final MovieLocalDataSource movieLocalDataSource;
  final MovieRemoteDataSource movieRemoteDataSorce;

  MovieRepositoryImpl({
    required this.movieLocalDataSource,
    required this.movieRemoteDataSorce,
  });

  @override
  Future<List<MovieModel>> getMovies() async {
    try {
      final cashedMovies = await movieLocalDataSource.getCashedMovies();
      if (cashedMovies.isNotEmpty) {
        return cashedMovies;
      } else {
        final movies = await movieRemoteDataSorce.getMovies();
        await movieLocalDataSource.cashedMovies(movies);
        return movies;
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Error getting cashed movie: $error, $stackTrace');
      }
      final movies = await movieRemoteDataSorce.getMovies();
      await movieLocalDataSource.cashedMovies(movies);
      return movies;
    }
  }
}
