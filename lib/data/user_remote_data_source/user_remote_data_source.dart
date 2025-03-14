import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:moviebuddy/data/user_local_data_source/user_email_local_data_source.dart';
import 'package:moviebuddy/data/user_local_data_source/user_id_local_data_source.dart';
import 'package:moviebuddy/data/user_local_data_source/user_nickname_local_data_source.dart';
import 'package:moviebuddy/data/user_model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel> getUser(String id);
  Future<void> addPlaylists(String userId, MovieCollection playlist);
  Future<void> updatePlaylists(String userId, MovieCollection playlist);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final UserIdLocalDataSource userIdLocalDataSource;
  final UserNicknameLocalDataSource userNicknameLocalDataSource;
  final UserEmailLocalDataSource userEmailLocalDataSource;

  UserRemoteDataSourceImpl({
    required this.firebaseFirestore,
    required this.userIdLocalDataSource,
    required this.userEmailLocalDataSource,
    required this.userNicknameLocalDataSource,
  });

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      await firebaseFirestore.collection('users').doc(user.id).set({
        'email': user.email,
        'id': user.id,
        'nickname': user.nickname,
        'movieCollections': [],
      });

      await userIdLocalDataSource.saveUserId(user.id);
      await userEmailLocalDataSource.saveUserEmail(user.email);
      await userNicknameLocalDataSource.saveUserNickname(user.nickname);
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Ошибка при сохранении пользователя: $error, $stackTrace');
      }
    }
  }

  @override
  Future<UserModel> getUser(String userId) async {
    final userDoc =
        await firebaseFirestore.collection('users').doc(userId).get();
    if (userDoc.exists) {
      final userData = userDoc.data();
      final movieCollections = (userData!['movieCollections'] as List?)
              ?.map((collection) => MovieCollection.fromJson(collection))
              .toList() ??
          [];
      return UserModel(
        id: userData['id'],
        email: userData['email'],
        nickname: userData['nickname'],
        moviesCollection: movieCollections,
      );
    } else {
      throw Exception('Пользователь не найден');
    }
  }

  @override
  Future<void> addPlaylists(String userId, MovieCollection playlist) async {
    final userDocRef = firebaseFirestore.collection('users').doc(userId);
    await userDocRef.update({
      'movieCollections': FieldValue.arrayUnion([playlist.toJson()]),
    });
    final updatedDoc = await userDocRef.get();
    if (kDebugMode) {
      print('Updated doc: ${updatedDoc.data()}');
    }
  }

  @override
  Future<void> updatePlaylists(String userId, MovieCollection playlist) async {
    final userDocRef = firebaseFirestore.collection('users').doc(userId);
    final userDoc = await userDocRef.get();

    if (userDoc.exists) {
      final userData = userDoc.data();
      final movieCollections = (userData!['movieCollections'] as List?)
              ?.map((collection) => MovieCollection.fromJson(collection))
              .toList() ??
          [];

      final index = movieCollections
          .indexWhere((element) => element.name == playlist.name);

      if (index != -1) {
        movieCollections[index] = playlist;

        final moviesJson = playlist.movies?.map((movie) {
              final movieJson = movie.toJson();
              return {
                'name': movieJson['name'],
                'description': movieJson['description'],
                'year': movieJson['year'],
                'poster': movie.poster.toJson(),
                'genres': movie.genres?.map((genre) => genre.toJson()).toList(),
                'rating': movie.rating?.toJson(),
              };
            }).toList() ??
            [];

        try {
          await userDocRef.update({
            'movieCollections': movieCollections.map((e) {
              if (e.name == playlist.name) {
                return {
                  'name': e.name,
                  'movies': moviesJson,
                };
              } else {
                return e.toJson();
              }
            }).toList(),
          });
        } catch (e) {
          throw Exception('Проблемы: $e');
        }
      } else {}
    } else {
      throw Exception('Пользователь не найден');
    }
  }
}
