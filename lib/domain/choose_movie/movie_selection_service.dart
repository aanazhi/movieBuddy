import 'movie_repository.dart';

class MovieSelectionService {
  final MovieRepository movieRepository;

  MovieSelectionService(this.movieRepository);

  Future<void> startSelection() async {}

  void handleSwipe(String movieId, bool isRightSwipe) {}

  Future<void> checkForWinner() async {}
}
