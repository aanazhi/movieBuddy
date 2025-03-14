import 'package:moviebuddy/data/database_repository/database_repository.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';
import 'package:moviebuddy/data/user_model/user_model.dart';

class AddMoviesInPlaylist {
  final DatabaseRepository _databaseRepository;

  AddMoviesInPlaylist(this._databaseRepository);

  Future<void> call(
      String userId, MovieCollection playlist, MovieModel movie) async {
    playlist.movies ??= [];
    playlist.movies!.add(movie);
    await _databaseRepository.updateMovies(userId, playlist);
  }
}
