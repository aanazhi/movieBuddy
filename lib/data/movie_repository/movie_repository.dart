import 'package:flutter/foundation.dart';
import 'package:moviebuddy/data/movie_local_data_source/movie_local_data_source.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';
import 'package:moviebuddy/data/movie_remote_data_source/movie_remote_data_source.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getMovies();
  Future<MovieModel?> getMovieById(String movieId);
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

  @override
  Future<MovieModel?> getMovieById(String movieId) async {
    try {
      final cachedMovies = await movieLocalDataSource.getCashedMovies();
      final movie = cachedMovies.firstWhere((m) => m.id.toString() == movieId);
      return movie;
    } catch (e) {
      try {
        final movies = await movieRemoteDataSorce.getMovies();
        final movie = movies.firstWhere((m) => m.id.toString() == movieId);
        await movieLocalDataSource.cashedMovies(movies);
        return movie;
      } catch (e) {
        if (kDebugMode) {
          print('Error getting movie by ID: $e');
        }
        return null;
      }
    }
  }
}
