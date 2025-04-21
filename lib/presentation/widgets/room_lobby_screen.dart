import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';
import 'package:moviebuddy/presentation/screens/match_overlay_screen.dart';
import 'package:moviebuddy/presentation/widgets/movie_card.dart';
import 'package:moviebuddy/presentation/widgets/swipe_buttons.dart';
import 'package:moviebuddy/provider/providers.dart';

class RoomLobbyScreen extends ConsumerStatefulWidget {
  final String roomCode;
  final List<MovieModel> movies;

  const RoomLobbyScreen({
    super.key,
    required this.roomCode,
    required this.movies,
  });

  @override
  ConsumerState<RoomLobbyScreen> createState() => _RoomLobbyScreenState();
}

class _RoomLobbyScreenState extends ConsumerState<RoomLobbyScreen> {
  void _handleSwipe(MovieModel movie, bool isLiked) async {
    final controller =
        ref.read(roomControllerProvider(widget.roomCode).notifier);
    await controller.handleSwipe(_sanitizeId(movie.id.toString()), isLiked);
  }

  String _sanitizeId(String id) {
    return id.replaceAll(RegExp(r'[~*/\[\]]'), '_');
  }

  Widget _buildParticipants(List<String> participants) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Участники (${participants.length})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: participants.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        participants[index].substring(0, 6),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(roomControllerProvider(widget.roomCode));

    return Scaffold(
      appBar: AppBar(
        title: Text('Комната ${widget.roomCode}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Информация о комнате'),
                  content: Text(
                    'Код комнаты: ${widget.roomCode}\n\nПоделитесь этим кодом с друзьями, чтобы они могли присоединиться.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: roomAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 40, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Ошибка загрузки комнаты',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.refresh(roomControllerProvider(widget.roomCode)),
                child: const Text('Повторить'),
              ),
            ],
          ),
        ),
        data: (room) {
          if (room.matchedMovieId != null) {
            return MatchOverlayScreen(
              movieId: room.matchedMovieId!,
              roomCode: widget.roomCode,
            );
          }

          final currentIndex =
              room.currentMovieIndex.clamp(0, room.movies.length - 1);
          final currentMovie = room.movies[currentIndex];
          final userId = FirebaseAuth.instance.currentUser?.uid;
          final hasSwiped = userId != null &&
              room.swipes[userId]?.containsKey(currentMovie.id.toString()) ==
                  true;

          return Column(
            children: [
              _buildParticipants(room.participants),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LinearProgressIndicator(
                  value: (currentIndex + 1) / room.movies.length,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  color: Theme.of(context).colorScheme.primary,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Фильм ${currentIndex + 1} из ${room.movies.length}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${((currentIndex + 1) / room.movies.length * 100).toStringAsFixed(0)}%',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MovieCard(
                    movie: currentMovie,
                    onSwipe: (isLiked) => _handleSwipe(currentMovie, isLiked),
                    canSwipe: !hasSwiped,
                  ),
                ),
              ),
              if (!hasSwiped)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SwipeButtons(
                    onLike: () => _handleSwipe(currentMovie, true),
                    onDislike: () => _handleSwipe(currentMovie, false),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
