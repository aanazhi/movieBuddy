import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/provider/providers.dart';

class MatchScreen extends ConsumerWidget {
  final String movieId;

  const MatchScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieByIdProvider(movieId));

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Совпадение!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              movieAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (error, _) => Text('Ошибка: $error'),
                data: (movie) {
                  if (movie == null) {
                    return const Text('Фильм не найден');
                  }
                  return Column(
                    children: [
                      if (movie.poster?.url != null)
                        Image.network(movie.poster!.url!, height: 300),
                      const SizedBox(height: 20),
                      Text(
                        movie.name ?? 'Без названия',
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Text('Год: ${movie.year ?? 'Неизвестен'}'),
                      const SizedBox(height: 10),
                      Text(
                          'Рейтинг: ${movie.rating?.kp?.toStringAsFixed(1) ?? 'N/A'}'),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Вернуться'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
