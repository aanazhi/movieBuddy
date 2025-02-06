import '../../domain/choose_movie/movie_model.dart';
import '../../domain/choose_movie/movie_repository.dart';

class FirebaseMovieRepository implements MovieRepository {
  @override
  Future<List<Movie>> fetchMovies(Filter filter) async {}

  @override
  Future<void> submitVote(String movieId, String userId) async {}

  @override
  Future<void> notifyUsersAboutVote(String movieId) async {}
}

class Filter {}
