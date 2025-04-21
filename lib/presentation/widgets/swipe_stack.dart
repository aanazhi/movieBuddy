import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';
import 'package:moviebuddy/presentation/screens/match_overlay_screen.dart';
import 'package:moviebuddy/presentation/widgets/movie_card.dart';
import 'package:moviebuddy/presentation/widgets/swipe_buttons.dart';
import 'package:moviebuddy/provider/providers.dart';

class SwipeStack extends ConsumerStatefulWidget {
  final List<MovieModel> movies;
  final String roomCode;

  const SwipeStack({
    super.key,
    required this.movies,
    required this.roomCode,
  });

  @override
  ConsumerState<SwipeStack> createState() => _SwipeStackState();
}

class _SwipeStackState extends ConsumerState<SwipeStack> {
  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(roomControllerProvider(widget.roomCode));

    return roomAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Ошибка: $error')),
      data: (room) {
        if (room.matchedMovieId != null) {
          return MatchOverlayScreen(
            movieId: room.matchedMovieId!,
            roomCode: widget.roomCode,
          );
        }

        final currentIndex = room.currentMovieIndex;
        if (currentIndex >= room.movies.length) {
          return const Center(child: Text('Фильмы закончились'));
        }

        final currentMovie = room.movies[currentIndex];
        final userId = FirebaseAuth.instance.currentUser?.uid;
        final hasSwiped = userId != null &&
            room.swipes[userId]!.containsKey(currentMovie.id.toString());

        return Column(
          children: [
            LinearProgressIndicator(
              value: room.currentMovieIndex / room.movies.length,
            ),
            Expanded(
              child: MovieCard(
                movie: currentMovie,
                onSwipe: (isLiked) => _handleSwipe(currentMovie, isLiked),
                canSwipe: !hasSwiped,
              ),
            ),
            if (!hasSwiped)
              SwipeButtons(
                onLike: () => _handleSwipe(currentMovie, true),
                onDislike: () => _handleSwipe(currentMovie, false),
              ),
          ],
        );
      },
    );
  }

  void _handleSwipe(MovieModel movie, bool isLiked) async {
    final controller =
        ref.read(roomControllerProvider(widget.roomCode).notifier);
    await controller.handleSwipe(movie.id.toString(), isLiked);
  }
}
