import 'dart:io';

import '../../data/guess_movie/movie_api.dart';

class ChooseMovieRepository {
  final MovieApi movieApi;

  ChooseMovieRepository(this.movieApi);

  Future<String> uploadImage(File image) async {
    return await movieApi.uploadImage(image);
  }

  Future<String> guessMovie(String fileUrl) async {
    return await movieApi.guessMovie(fileUrl);
  }
}
