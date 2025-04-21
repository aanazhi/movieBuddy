import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/data/movie_model/movie_model.dart';
import 'package:moviebuddy/data/user_model/user_model.dart';
import 'package:moviebuddy/presentation/screens/room_screen.dart';
import 'package:moviebuddy/presentation/widgets/best_movies.dart';
import 'package:moviebuddy/presentation/widgets/best_serials.dart';
import 'package:moviebuddy/provider/providers.dart';

import '../widgets/app_bar.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final searchQuery = ref.watch(searchQueryProvider);
    final searchResult = ref.watch(searchMoviesProvider(searchQuery));
    final filteredMovies = ref.watch(filteredMoviesProvider);

    return Scaffold(
      appBar: const AppBurCustom(
        title: 'MovieBuddy',
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width / 2 - 150,
        ),
        child: SizedBox(
          height: 63,
          width: 262,
          child: FloatingActionButton(
            heroTag: 'mainScreen',
            backgroundColor: colorsStyle.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              'Создай комнату!',
              style: textStyle.displayMedium,
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const RoomScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
      ),
      backgroundColor: colorsStyle.primary,
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            color: colorsStyle.secondary,
            height: 1,
            width: double.infinity,
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 20, 0),
                width: 350,
                height: 50,
                child: TextField(
                  cursorColor: colorsStyle.secondary,
                  textAlign: TextAlign.left,
                  style: textStyle.displaySmall,
                  decoration: InputDecoration(
                    hintText: 'Поиск',
                    hintStyle: textStyle.displaySmall,
                    filled: true,
                    fillColor: colorsStyle.onPrimary,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        color: colorsStyle.secondary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        color: colorsStyle.surfaceBright,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        color: colorsStyle.secondary,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(
                      bottom: 5,
                      left: 25,
                    ),
                  ),
                  onChanged: (text) {
                    ref
                        .read(searchQueryProvider.notifier)
                        .update((state) => text);
                  },
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.filter_alt),
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const FilterDialog(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: searchQuery.isEmpty
                ? filteredMovies.when(
                    data: (movies) => ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Card(
                          color: colorsStyle.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      movie.name ?? 'Неизвестно',
                                      style: textStyle.displaySmall,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final userId = FirebaseAuth
                                            .instance.currentUser?.uid;
                                        if (userId == null) return;

                                        final selectedPlaylist =
                                            await showDialog<MovieCollection>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor:
                                                colorsStyle.primary,
                                            content: SizedBox(
                                              width: 70,
                                              child: Consumer(
                                                builder: (context, ref, child) {
                                                  final userAsync = ref.watch(
                                                      getUserAsyncProvider(
                                                          userId));

                                                  return userAsync.when(
                                                    data: (userModel) {
                                                      return ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: userModel
                                                            .moviesCollection!
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final playlist = userModel
                                                                  .moviesCollection![
                                                              index];
                                                          return ListTile(
                                                            title: Text(
                                                                playlist.name,
                                                                style: textStyle
                                                                    .displaySmall),
                                                            onTap: () => Navigator
                                                                    .of(context)
                                                                .pop(playlist),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    error: (error, stack) =>
                                                        Text('Error: $error'),
                                                    loading: () =>
                                                        const CircularProgressIndicator(),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );

                                        if (selectedPlaylist != null) {
                                          await ref
                                              .read(updatePlaylistProvider)
                                              .call(userId, selectedPlaylist,
                                                  movie);
                                        }
                                      },
                                      child: Image.asset(
                                        'assets/icons/vector.png',
                                        width: 25.71,
                                        height: 25.71,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    movie.poster?.url?.isNotEmpty ?? false
                                        ? Image.network(
                                            movie.poster!.url!,
                                            width: 150,
                                            height: 210,
                                          )
                                        : Image.asset(
                                            'assets/images/black.png',
                                            width: 150,
                                            height: 210,
                                          ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 10),
                                          Text(
                                            movie.description ?? 'Неизвестно',
                                            style: textStyle.bodyLarge,
                                            maxLines: 5,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            movie.genres?.first.name
                                                    ?.toUpperCase() ??
                                                '',
                                            style: textStyle.bodyLarge,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            movie.rating?.kp?.toString() ?? '',
                                            style: textStyle.bodyLarge,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            movie.year?.toString() ?? '',
                                            style: textStyle.bodyLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    error: (error, _) => Center(child: Text('Ошибка: $error')),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  )
                : searchResult.when(
                    data: (movies) => ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];

                        return Card(
                          color: colorsStyle.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      movie.name ?? 'Неизвестно',
                                      style: textStyle.displaySmall,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final userId = FirebaseAuth
                                            .instance.currentUser?.uid;
                                        if (userId == null) {
                                          if (kDebugMode) {
                                            print('User ID is null!');
                                          }
                                          return;
                                        }

                                        final selectedPlaylist =
                                            await showDialog<MovieCollection>(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  colorsStyle.primary,
                                              content: SizedBox(
                                                width: 70,
                                                child: FutureBuilder<UserModel>(
                                                  future: ref.watch(
                                                      getUserAsyncProvider(
                                                              userId)
                                                          .future),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Ошибка: ${snapshot.error}');
                                                    } else if (snapshot
                                                        .hasData) {
                                                      final userModel =
                                                          snapshot.data!;
                                                      return ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: userModel
                                                            .moviesCollection!
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final playlist = userModel
                                                                  .moviesCollection![
                                                              index];
                                                          return ListTile(
                                                            title: Text(
                                                              playlist.name,
                                                              style: textStyle
                                                                  .displaySmall,
                                                            ),
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      playlist);
                                                            },
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      return const Text(
                                                          'Нет данных');
                                                    }
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                        if (selectedPlaylist != null) {
                                          final addMovieToPlaylistUseCase =
                                              ref.read(updatePlaylistProvider);
                                          await addMovieToPlaylistUseCase.call(
                                              userId, selectedPlaylist, movie);
                                        }
                                      },
                                      child: Image.asset(
                                        'assets/icons/vector.png',
                                        width: 25.71,
                                        height: 25.71,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    movie.poster!.url!.isNotEmpty
                                        ? Image.network(
                                            movie.poster!.url!,
                                            width: 150,
                                            height: 210,
                                          )
                                        : Image.asset(
                                            'assets/images/black.png',
                                            width: 150,
                                            height: 210,
                                          ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            movie.description ?? 'Неизвестно',
                                            style: textStyle.bodyLarge,
                                            maxLines: 5,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            movie.genres!.first.name!
                                                .toUpperCase(),
                                            style: textStyle.bodyLarge,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            movie.rating!.kp.toString(),
                                            style: textStyle.bodyLarge,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            movie.year.toString(),
                                            style: textStyle.bodyLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    error: (Object error, StackTrace stackTrace) {
                      if (kDebugMode) {
                        print(
                            'Error with movies - $error, stackTrace - $stackTrace');
                      }
                      return Center(
                        child: Text(
                          'Что-то пошло не так',
                          style: textStyle.bodyMedium,
                        ),
                      );
                    },
                    loading: () => Center(
                      child: CircularProgressIndicator(
                        color: colorsStyle.secondary,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class MovieItem extends StatelessWidget {
  final MovieModel movie;

  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: movie.poster?.url != null
          ? Image.network(movie.poster!.url!,
              width: 50, height: 75, fit: BoxFit.cover)
          : const Icon(Icons.movie),
      title: Text(movie.name ?? 'Без названия'),
      subtitle: Text(
          '${movie.year} · ${movie.rating?.kp?.toStringAsFixed(1) ?? '?'}'),
    );
  }
}

class FilterDialog extends ConsumerWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final params = ref.watch(filterParamsProvider);
    final notifier = ref.watch(filterParamsProvider.notifier);

    return AlertDialog(
      title: const Text('Фильтры поиска'),
      content: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Год (например: 2020-2023)'),
                onChanged: (value) =>
                    notifier.update((s) => {...s, 'year': value}),
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Рейтинг (например: 7-10)'),
                onChanged: (value) =>
                    notifier.update((s) => {...s, 'rating.kp': value}),
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Жанры (через запятую)'),
                onChanged: (value) => notifier.update((s) => {
                      ...s,
                      'genres.name':
                          value.split(',').map((e) => e.trim()).toList()
                    }),
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Страны (через запятую)'),
                onChanged: (value) => notifier.update((s) => {
                      ...s,
                      'countries.name':
                          value.split(',').map((e) => e.trim()).toList()
                    }),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            ref.refresh(filteredMoviesProvider);
            Navigator.pop(context);
          },
          child: const Text('Применить'),
        ),
      ],
    );
  }
}
