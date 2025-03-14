import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/data/user_model/user_model.dart';
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
    final localDataSource = ref.watch(userIdLocalDataSourceProvider);

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
            onPressed: () {},
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
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/settings.png',
                  width: 33,
                  height: 33,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: searchQuery.isEmpty
                ? ListView(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.only(left: 16, top: 43),
                          child: Text(
                            'Лучшие фильмы',
                            style: textStyle.displaySmall,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const BestMovies(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.only(left: 16, top: 43),
                          child: Text(
                            'Лучшие сериалы',
                            style: textStyle.displaySmall,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const BestSerials(),
                    ],
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
                                        final userId =
                                            await localDataSource.getUserId();
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
                                    movie.poster.url!.isNotEmpty
                                        ? Image.network(
                                            movie.poster.url!,
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
                    error: (Object error, StackTrace stackTrace) => Text(
                      'Что-то пошло не так',
                      style: textStyle.bodyMedium,
                    ),
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
