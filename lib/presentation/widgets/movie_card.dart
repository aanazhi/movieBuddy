import 'package:flutter/material.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final Function(bool) onSwipe;
  final bool canSwipe;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onSwipe,
    this.canSwipe = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
       
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (movie.poster?.url != null)
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight:
                            constraints.maxHeight * 0.6, 
                      ),
                      child: Image.network(
                        movie.poster!.url!,
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.name ?? 'Без названия',
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text('Год: ${movie.year ?? 'Неизвестен'}'),
                        const SizedBox(height: 8),
                        Text(
                          'Рейтинг: ${movie.rating?.kp?.toStringAsFixed(1) ?? 'N/A'}',
                        ),
                      ],
                    ),
                  ),
                  if (!canSwipe)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Ожидаем других участников...'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
