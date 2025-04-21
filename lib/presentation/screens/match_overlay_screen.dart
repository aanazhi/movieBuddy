import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/provider/providers.dart';

class MatchOverlayScreen extends ConsumerWidget {
  final String movieId;
  final String roomCode;

  const MatchOverlayScreen({
    super.key,
    required this.movieId,
    required this.roomCode,
  });

  String _sanitizeId(String id) {
    return id.replaceAll(RegExp(r'[~*/\[\]]'), '_');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomAsync = ref.watch(roomControllerProvider(roomCode));

    return roomAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Ошибка: $error')),
      data: (room) {
        final matchedMovie = room.movies.firstWhere(
          (movie) => _sanitizeId(movie.id.toString()) == _sanitizeId(movieId),
          orElse: () => room.movies.first,
        );

        return Scaffold(
          body: Stack(
            children: [
              if (matchedMovie.poster?.url != null)
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(matchedMovie.poster!.url!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.celebration,
                          size: 60,
                          color: Colors.amber,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Совпадение!',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        if (matchedMovie.poster?.url != null)
                          Hero(
                            tag: 'movie-${matchedMovie.id}',
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  matchedMovie.poster!.url!,
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 30),
                        Text(
                          matchedMovie.name ?? 'Без названия',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Chip(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              label: Text(
                                'Год: ${matchedMovie.year ?? 'Неизвестен'}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Chip(
                              backgroundColor: Colors.amber.withOpacity(0.2),
                              label: Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 16, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text(
                                    matchedMovie.rating?.kp
                                            ?.toStringAsFixed(1) ??
                                        'N/A',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            matchedMovie.description ?? 'Описание отсутствует',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Продолжить',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
