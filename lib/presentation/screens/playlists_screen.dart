import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/data/user_model/user_model.dart';
import 'package:moviebuddy/provider/providers.dart';
import 'package:uuid/uuid.dart';

import '../widgets/app_bar.dart';

class Playlists extends ConsumerWidget {
  final String? userId;

  const Playlists({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    final getUserAsyncValue = ref.watch(getUserAsyncProvider(userId!));

    return Scaffold(
      appBar: const AppBurCustom(
        title: 'Playlists',
      ),
      backgroundColor: colorsStyle.primary,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(getUserAsyncProvider(userId!));
        },
        child: getUserAsyncValue.when(
          data: (userModel) {
            if (userModel.moviesCollection == null ||
                userModel.moviesCollection!.isEmpty) {
              return Center(
                child: Text(
                  'Нет плейлистов',
                  style: textStyle.displaySmall,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: userModel.moviesCollection!.length,
                itemBuilder: (context, index) {
                  final playlist = userModel.moviesCollection![index];

                  return Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorsStyle.secondary,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          playlist.name,
                          style: textStyle.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: playlist.movies!.length,
                          itemBuilder: (context, index) {
                            final movie = playlist.movies![index];
                            final posterUrl = movie.poster.url;

                            return posterUrl != null && posterUrl.isNotEmpty
                                ? Image.network(
                                    posterUrl,
                                    width: 90,
                                    height: 150,
                                  )
                                : Image.asset(
                                    'assets/images/black.png',
                                    width: 90,
                                    height: 150,
                                  );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
          error: (error, _) {
            return Text(
              'Ошибка при загрузке плейлистов',
              style: textStyle.bodyMedium,
            );
          },
          loading: () {
            return Center(
              child: CircularProgressIndicator(
                color: colorsStyle.secondary,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'playlistScreen',
        backgroundColor: colorsStyle.onPrimary,
        onPressed: () async {
          final newPlaylistName = await showDialog<String>(
            context: context,
            builder: (context) {
              String? playlistName;
              return AlertDialog(
                backgroundColor: colorsStyle.onPrimary,
                title: Text(
                  'Создать новый плейлист',
                  style: textStyle.bodyMedium,
                ),
                content: TextField(
                  onChanged: (value) {
                    playlistName = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Название плейлиста',
                    hintStyle: textStyle.bodySmall,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(playlistName);
                    },
                    child: Text(
                      'Создать',
                      style: textStyle.bodyMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Отмена',
                      style: textStyle.bodyMedium,
                    ),
                  )
                ],
              );
            },
          );

          if (newPlaylistName != null && newPlaylistName.isNotEmpty) {
            const uuid = Uuid();
            final id = uuid.v4();
            final newPlaylist = MovieCollection(
              id: id,
              name: newPlaylistName,
              movies: [],
            );
            final addPlaylistUseCase = ref.read(addPlaylistProvider);
            await addPlaylistUseCase.call(userId!, newPlaylist);
            ref.refresh(getUserAsyncProvider(userId!));
          }
        },
        child: Image.asset(
          'assets/icons/vector.png',
          width: 25.71,
          height: 25.71,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
