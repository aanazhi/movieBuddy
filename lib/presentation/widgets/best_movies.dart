import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/provider/providers.dart';

class BestMovies extends ConsumerWidget {
  const BestMovies({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieData = ref.watch(movieProvider);
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return movieData.when(
      data: (movies) {
        return SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: SizedBox(
                    height: 190,
                    width: 130,
                    child: movie.poster?.url != null
                        ? Image.network(
                            movie.poster?.url ?? '',
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text(
                              'Нет картинки',
                              style: textStyle.bodyMedium,
                            ),
                          ),
                  ),
                );
              },
            ));
      },
      loading: () => Center(
        child: CircularProgressIndicator(
          color: colorsStyle.secondary,
        ),
      ),
      error: (Object error, StackTrace stackTrace) => Text(
        'Что-то пошло не так',
        style: textStyle.bodyMedium,
      ),
    );
  }
}
