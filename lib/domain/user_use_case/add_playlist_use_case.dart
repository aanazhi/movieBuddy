import 'package:flutter/foundation.dart';
import 'package:moviebuddy/data/database_repository/database_repository.dart';
import 'package:moviebuddy/data/user_model/user_model.dart';

class AddPlaylistUseCase {
  final DatabaseRepository _databaseRepository;

  AddPlaylistUseCase(this._databaseRepository);

  Future<void> call(String userId, MovieCollection playlist) async {
    await _databaseRepository.addPlaylist(userId, playlist);
    final updatedUser = await _databaseRepository.getUser(userId);
    if (kDebugMode) {
      print('Updated user: ${updatedUser.moviesCollection}');
    }
  }
}
