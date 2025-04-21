import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/presentation/widgets/room_lobby_screen.dart';
import 'package:moviebuddy/provider/providers.dart';

class CreateRoomDialog extends ConsumerWidget {
  const CreateRoomDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Создать комнату',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: Consumer(
                builder: (context, ref, _) {
                  final playlistsAsync = ref.watch(userPlaylistsProvider);
                  return playlistsAsync.when(
                    data: (playlists) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: playlists.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            playlists[index].name,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onTap: () async {
                            final navigator = Navigator.of(context);
                            try {
                              final roomController =
                                  ref.read(roomControllerProvider('').notifier);
                              final code = await roomController
                                  .createRoom(playlists[index].movies!);
                              await Future.delayed(
                                  const Duration(milliseconds: 300));
                              navigator.pop();
                              navigator.push(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => RoomLobbyScreen(
                                    roomCode: code,
                                    movies: playlists[index].movies!,
                                  ),
                                  transitionsBuilder:
                                      (_, animation, __, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            } catch (e, stackTrace) {
                              print(
                                  'Ошибка при создании комнаты: $e, stackTrace - $stackTrace');
                            }
                          },
                        );
                      },
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, stackTrace) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.error_outline,
                                size: 40, color: Colors.red),
                            const SizedBox(height: 10),
                            Text(
                              'Ошибка загрузки плейлистов',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextButton(
                              onPressed: () =>
                                  ref.refresh(userPlaylistsProvider),
                              child: const Text('Повторить'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
