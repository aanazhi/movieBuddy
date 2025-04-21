import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/data/room_repository/room_repository.dart';

import 'package:moviebuddy/domain/switch_state/switch_state.dart';

class SwipeNotifier extends StateNotifier<SwipeState> {
  final RoomRepository _repository;
  final String _roomCode;
  final FirebaseAuth _firebaseAuth;

  SwipeNotifier(
    this._repository,
    this._roomCode,
    this._firebaseAuth,
  ) : super(SwipeState(
          roomCode: _roomCode,
          movieId: '',
        ));

  Future<void> handleSwipe(String movieId, bool isLiked) async {
    if (!mounted) return;
    try {
      await _repository.updateSwipes(
        _roomCode,
        _firebaseAuth.currentUser?.uid ?? '',
        movieId,
        isLiked,
      );
      state = state.copyWith(movieId: movieId, isLiked: isLiked);
      print('Swipe updated successfully');
    } catch (e) {
      print('Error updating swipe: $e');
    }
  }
}
