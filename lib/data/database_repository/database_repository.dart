import 'package:moviebuddy/data/user_remote_data_source/user_remote_data_source.dart';

import '../user_model/user_model.dart';

abstract class DatabaseRepository {
  Future<void> saveUser(UserModel user);
  Future<UserModel> getUser(String id);
  Future<void> addPlaylist(String userId, MovieCollection playlist);
  Future<void> updateMovies(String userId, MovieCollection playlist);
}

class DatabaseRepositoryImpl implements DatabaseRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  DatabaseRepositoryImpl(this._userRemoteDataSource);

  @override
  Future<void> saveUser(UserModel user) async {
    await _userRemoteDataSource.saveUser(user);
  }

  @override
  Future<UserModel> getUser(String id) async {
    final user = await _userRemoteDataSource.getUser(id);
    return user;
  }

  @override
  Future<void> addPlaylist(String userId, MovieCollection playlist) async {
    await _userRemoteDataSource.addPlaylists(userId, playlist);
  }

  @override
  Future<void> updateMovies(String userId, MovieCollection playlist) async {
    await _userRemoteDataSource.updatePlaylists(userId, playlist);
  }
}
