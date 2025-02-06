import '../../data/choose_movie/movie_firebase_repository.dart';
import 'movie_model.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies(Filter filter);
  Future<void> submitVote(String movieId, String userId);
  Future<void> notifyUsersAboutVote(String movieId);
}







