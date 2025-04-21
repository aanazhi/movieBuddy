import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';
import 'package:moviebuddy/data/room_model/room_model.dart';
import 'package:moviebuddy/data/room_repository/room_repository.dart';

class RoomController extends StateNotifier<AsyncValue<RoomModel>> {
  final RoomRepository _roomRepository;
  final String _roomCode;
  final FirebaseAuth _firebaseAuth;

  RoomController(
    this._roomRepository,
    this._roomCode,
    this._firebaseAuth,
  ) : super(const AsyncValue.loading()) {
    _listenToRoomUpdates();
  }

  void _listenToRoomUpdates() {
    _roomRepository.watchRoom(_roomCode).listen((room) {
      if (mounted) {
        state = AsyncValue.data(room);

        _checkAndSetMatchedMovie(room);
      }
    }, onError: (error, stackTrace) {
      if (mounted) {
        state = AsyncValue.error(error, stackTrace);
      }
    });
  }

  Future<void> _checkAndSetMatchedMovie(RoomModel room) async {
    if (room.currentMovieIndex < 0 ||
        room.currentMovieIndex >= room.movies.length) {
      return;
    }

    final currentMovieId = room.movies[room.currentMovieIndex].id.toString();

    bool allLiked = true;

    for (final userId in room.participants) {
      final userSwipes = room.swipes[userId];
      if (userSwipes == null || userSwipes[currentMovieId] != true) {
        allLiked = false;
        break;
      }
    }

    if (allLiked) {
      await _roomRepository.setMatchedMovie(_roomCode, currentMovieId);
    }
  }

  Future<void> resetRoom() async {
    try {
      await _roomRepository.setMatchedMovie(_roomCode, null);

      final currentRoom = state.value;
      if (currentRoom != null) {
        await _roomRepository.clearAllSwipes(_roomCode);
      }

      await _roomRepository.setCurrentMovieIndex(_roomCode, 0);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> addParticipaint() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await _roomRepository.addParticipaint(_roomCode, user.uid);
    }
  }

  String _sanitizeId(String id) {
    return id.replaceAll(RegExp(r'[~*/\[\]]'), '_');
  }

  Future<void> handleSwipe(String movieId, bool isLiked) async {
    final userId = _firebaseAuth.currentUser?.uid;
    if (userId == null) return;

    final sanitizedId = _sanitizeId(movieId);
    await _roomRepository.updateSwipes(_roomCode, userId, sanitizedId, isLiked);
  }

  Future<void> updateSwipes(String userId, String movieId, bool isLiked) async {
    await _roomRepository.updateSwipes(_roomCode, userId, movieId, isLiked);
  }

  Future<String> createRoom(List<MovieModel> movies) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final roomCode = await _roomRepository.createRoom(user.uid, movies);
      return roomCode;
    }
    throw Exception("Пользователь не авторизован");
  }
}
