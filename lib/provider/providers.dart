import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/guess_movie/movie_api.dart';
import '../domain/guess_movie.dart/choose_movie_repository.dart';

final movieApiProvider = Provider((ref) => MovieApi(
      serverUrl: 'https://dev.getglam.app',
      apiKey: 'f2dd5b61926ec36c8c293b842b463100',
    ));

final movieRepositoryProvider =
    Provider((ref) => ChooseMovieRepository(ref.read(movieApiProvider)));

class MovieState {
  final String? title;
  final bool isLoading;
  final String? error;
  final File? image;

  MovieState({
    this.title,
    this.isLoading = false,
    this.error,
    this.image,
  });
}

class MovieNotifier extends StateNotifier<MovieState> {
  final ChooseMovieRepository movieRepository;

  MovieNotifier(this.movieRepository) : super(MovieState());

  Future<void> pickAndUploadImage(File image) async {
    state = MovieState(isLoading: true, image: image);
    try {
      final fileUrl = await movieRepository.uploadImage(image);
      final title = await movieRepository.guessMovie(fileUrl);
      state = MovieState(
        title: title,
        image: image,
      );
    } catch (e) {
      state = MovieState(error: e.toString());
    }
  }

  void resetState() {
    state = MovieState();
  }
}

final movieProvider = StateNotifierProvider<MovieNotifier, MovieState>((ref) {
  return MovieNotifier(ref.read(movieRepositoryProvider));
});
