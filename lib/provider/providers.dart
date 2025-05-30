import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moviebuddy/data/database_repository/database_repository.dart';
import 'package:moviebuddy/data/image_repository/image_repository.dart';
import 'package:moviebuddy/data/movie_local_data_source/movie_local_data_source.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';
import 'package:moviebuddy/data/movie_remote_data_source/movie_remote_data_source.dart';
import 'package:moviebuddy/data/room_model/room_model.dart';
import 'package:moviebuddy/data/serial_local_data_source/serial_local_data_source.dart';
import 'package:moviebuddy/data/serial_model/serial_model.dart';
import 'package:moviebuddy/data/serial_remote_data_source/serial_remote_data_source.dart';
import 'package:moviebuddy/data/user_local_data_source/user_email_local_data_source.dart';
import 'package:moviebuddy/data/user_local_data_source/user_id_local_data_source.dart';
import 'package:moviebuddy/data/user_local_data_source/user_nickname_local_data_source.dart';
import 'package:moviebuddy/data/user_local_data_source/user_photo_local_data_source.dart';
import 'package:moviebuddy/data/user_local_data_source/user_token_local_data_source.dart';
import 'package:moviebuddy/data/user_model/user_model.dart';
import 'package:moviebuddy/data/user_remote_data_source/user_remote_data_source.dart';
import 'package:moviebuddy/data/user_repository/user_repository.dart';
import 'package:moviebuddy/domain/image_use_case/image_use_case.dart';
import 'package:moviebuddy/domain/login_use_case/login_register_use_case.dart';
import 'package:moviebuddy/data/movie_repository/movie_repository.dart';
import 'package:moviebuddy/data/room_repository/room_repository.dart';
import 'package:moviebuddy/domain/switch_entity/switch_entity.dart';
import 'package:moviebuddy/domain/switch_state/switch_state.dart';
import 'package:moviebuddy/domain/user_use_case/add_movies_in_playlist.dart';
import 'package:moviebuddy/domain/user_use_case/add_playlist_use_case.dart';
import 'package:moviebuddy/domain/user_use_case/get_user_use_case.dart';
import 'package:moviebuddy/domain/user_use_case/save_user_use_case.dart';
import 'package:moviebuddy/data/serial_repository/serial_repository.dart';
import 'package:moviebuddy/provider/state_notifier/image_notifier.dart';
import 'package:moviebuddy/provider/state_notifier/room_controller.dart';
import 'package:moviebuddy/provider/state_notifier/swipe_notifier.dart';
import 'package:moviebuddy/provider/state_notifier/switch_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userRepositoryProvider = Provider<DatabaseRepository>((ref) {
  final userRemoteDataSource = UserRemoteDataSourceImpl(
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
    //userIdLocalDataSource: ref.watch(userIdLocalDataSourceProvider),
    userEmailLocalDataSource: ref.watch(userEmailLocalDataSourceProvider),
    userNicknameLocalDataSource: ref.watch(userNicknameLocalDataSourceProvider),
    userPhotoLocalDataSource: ref.watch(userPhotoLocalDataSourceProvider),
  );
  return DatabaseRepositoryImpl(userRemoteDataSource);
});

final userRemoteProvider = Provider<UserRemoteDataSource>((ref) {
  return UserRemoteDataSourceImpl(
      firebaseFirestore: ref.watch(firebaseFirestoreProvider),
      //userIdLocalDataSource: ref.watch(userIdLocalDataSourceProvider),
      userEmailLocalDataSource: ref.watch(userEmailLocalDataSourceProvider),
      userNicknameLocalDataSource:
          ref.watch(userNicknameLocalDataSourceProvider),
      userPhotoLocalDataSource: ref.watch(userPhotoLocalDataSourceProvider));
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final userProvider = Provider<UserRepository>((ref) {
  final firebaseAuth = ref.watch(firebaseProvider);
  final userToken = ref.watch(userTokenLocalDataSource);
  final userRemoteDataSource = ref.watch(userRemoteProvider);
  return UserRepositoryImpl(
    auth: firebaseAuth,
    userTokenLocalDataSource: userToken,
    userRemoteDataSource: userRemoteDataSource,
  );
});

final loginRegisterProvider = Provider<LoginRegisterUseCase>((ref) {
  final user = ref.watch(userProvider);
  return LoginRegisterUseCaseImpl(user);
});

final firebaseProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final saveUserProvider = Provider<SaveUserUseCase>((ref) {
  final databaseRepository = ref.watch(userRepositoryProvider);
  return SaveUserUseCase(databaseRepository);
});

final getUserProvider = Provider<GetUserUseCase>((ref) {
  final databaseRepository = ref.watch(userRepositoryProvider);
  return GetUserUseCase(databaseRepository);
});

final getUserAsyncProvider =
    FutureProvider.family<UserModel, String>((ref, userId) async {
  final getUserUseCase = ref.watch(getUserProvider);
  return await getUserUseCase.call(userId);
});

final addPlaylistProvider = Provider<AddPlaylistUseCase>((ref) {
  final databaseRepository = ref.watch(userRepositoryProvider);
  return AddPlaylistUseCase(databaseRepository);
});

final updatePlaylistProvider = Provider<AddMoviesInPlaylist>((ref) {
  final databaseRepository = ref.watch(userRepositoryProvider);
  return AddMoviesInPlaylist(databaseRepository);
});

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://api.kinopoisk.dev/v1.4',
    ),
  );
});

final apiKeyProvider = Provider<String>((ref) {
  return 'YZ7GA2F-N4542C6-NFR3RZ9-6NCSJ7B';
});

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

// final userIdLocalDataSourceProvider = Provider<UserIdLocalDataSource>((ref) {
//   return UserIdLocalDataSourceImpl(
//       sharedPreferences: ref.watch(sharedPreferencesProvider));
// });

final userEmailLocalDataSourceProvider =
    Provider<UserEmailLocalDataSource>((ref) {
  return UserEmailLocalDataSourceImpl(
      sharedPreferences: ref.watch(sharedPreferencesProvider));
});

final userPhotoLocalDataSourceProvider =
    Provider<UserPhotoLocalDataSource>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return UserPhotoLocalDataSourceImpl(sharedPreferences: sharedPreferences);
});

final filterParamsProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'page': 1,
    'limit': 10,
    'selectFields': [
      'name',
      'description',
      'year',
      'rating',
      'genres',
      'poster'
    ],
  };
});

final filteredMoviesProvider =
    FutureProvider.autoDispose<List<MovieModel>>((ref) {
  final params = ref.watch(filterParamsProvider);
  final dataSource = ref.watch(movieRemoteDataSourceProvider);
  return dataSource.getFilteredMovies(params);
});

final userTokenLocalDataSource = Provider<UserTokenLocalDataSource>((ref) {
  return UserTokenLocalDataSourceImpl(
      sharedPreferences: ref.watch(sharedPreferencesProvider));
});

final userNicknameLocalDataSourceProvider =
    Provider<UserNicknameLocalDataSource>((ref) {
  return UserNicknameLocalDataSourceImpl(
      sharedPreferences: ref.watch(sharedPreferencesProvider));
});

final movieRemoteDataSourceProvider = Provider<MovieRemoteDataSource>((ref) {
  return MovieRemoteDataSorceImpl(
    dio: ref.watch(dioProvider),
    apiKey: ref.watch(apiKeyProvider),
  );
});

final movieLocalDataSourceProvider = Provider<MovieLocalDataSource>((ref) {
  return MovieLocalDataSourceImpl(
    sharedPreferences: ref.watch(sharedPreferencesProvider),
  );
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepositoryImpl(
    movieLocalDataSource: ref.watch(movieLocalDataSourceProvider),
    movieRemoteDataSorce: ref.watch(movieRemoteDataSourceProvider),
  );
});

final movieProvider = FutureProvider<List<MovieModel>>((ref) async {
  return ref.watch(movieRepositoryProvider).getMovies();
});

final movieByIdProvider =
    FutureProvider.family<MovieModel?, String>((ref, movieId) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getMovieById(movieId);
});

final serialRemoteDataSourceProvider = Provider<SerialRemoteDataSource>((ref) {
  return SerialRemoteDataSourceImpl(
    dio: ref.watch(dioProvider),
    apiKey: ref.watch(apiKeyProvider),
  );
});

final serialsLocalDataSourceProvider = Provider<SerialLocalDataSource>((ref) {
  return SerialLocalDataSourceImpl(
    sharedPreferences: ref.watch(sharedPreferencesProvider),
  );
});

final serialsRepositoryProvider = Provider<SerialRepository>((ref) {
  return SerialRepositoryImpl(
    serialLocalDataSource: ref.watch(serialsLocalDataSourceProvider),
    serialRemoteDataSource: ref.watch(serialRemoteDataSourceProvider),
  );
});

final serialProvider = FutureProvider<List<SerialModel>>((ref) async {
  return ref.watch(serialsRepositoryProvider).getSerials();
});

final searchMoviesProvider =
    FutureProvider.family<List<MovieModel>, String>((ref, query) async {
  final movieRemoteDataSouce = ref.watch(movieRemoteDataSourceProvider);
  final responsce = await movieRemoteDataSouce.searchMovie(query);
  return responsce;
});

final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final imagePickerProvider = Provider<ImagePicker>((ref) {
  return ImagePicker();
});

final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  return ImageRepositoryImpl(imagePicker: ref.watch(imagePickerProvider));
});

final imageUseCaseProvider = Provider<ImageUseCase>((ref) {
  final imageRepository = ref.watch(imageRepositoryProvider);
  return ImageUseCase(imageRepository: imageRepository);
});

final imageProvider = StateNotifierProvider<ImageNotifier, File?>((ref) {
  final useCase = ref.watch(imageUseCaseProvider);

  return ImageNotifier(useCase);
});

final switchProvider =
    StateNotifierProvider<SwitchNotifier, SwitchEntity>((ref) {
  return SwitchNotifier();
});

final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  final firebase = ref.watch(firebaseFirestoreProvider);
  return RoomRepositoryImpl(firebaseFirestore: firebase);
});

final roomControllerProvider = StateNotifierProvider.autoDispose
    .family<RoomController, AsyncValue<RoomModel>, String>((ref, code) {
  return RoomController(
    ref.watch(roomRepositoryProvider),
    code,
    ref.watch(firebaseProvider),
  );
});

final swipeProvider = StateNotifierProvider.autoDispose
    .family<SwipeNotifier, SwipeState, String>((ref, code) {
  ref.keepAlive();
  return SwipeNotifier(
    ref.watch(roomRepositoryProvider),
    code,
    ref.watch(firebaseProvider),
  );
});

final userRProvider = FutureProvider<UserModel>((ref) async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  print('айдишник: ${userId}');
  final remoteDataSource = ref.watch(userRemoteProvider);

  if (userId != null) {
    try {
      return await remoteDataSource.getUser(userId);
    } catch (e) {
      print("Ошибка при получении данных пользователя: $e");

      throw Exception("Failed to load user data: $e");
    }
  } else {
    print("Пользователь не залогинен");
    throw Exception("Пользователь не залогинен");
  }
});

final userPlaylistsProvider =
    FutureProvider<List<MovieCollection>>((ref) async {
  final user = await ref.watch(userRProvider.future);
  return user.moviesCollection ?? [];
});

final movieRepProvider =
    FutureProvider.family<MovieModel?, String>((ref, movieId) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getMovieById(movieId);
});

final currentIndexProvider = StateProvider<int>((ref) => 0);
