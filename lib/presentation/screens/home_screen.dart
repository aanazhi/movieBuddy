import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/presentation/screens/main_screen.dart';
import 'package:moviebuddy/presentation/screens/playlists_screen.dart';
import 'package:moviebuddy/presentation/screens/room_screen.dart';
import 'package:moviebuddy/provider/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final colorsStyle = Theme.of(context).colorScheme;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userId = FirebaseAuth.instance.currentUser?.uid;
            if (userId != null) {
              return IndexedStack(
                index: _selectedIndex,
                children: [
                  Playlists(
                    userId: userId,
                  ),
                  const MainScreen(),
                  const RoomScreen(),
                ],
              );
            } else {
              return const Text('Пользователь не найден');
            }
          } else if (snapshot.hasError) {
            return const Text('Ошибка при получении userId');
          } else {
            if (kDebugMode) {
              print('Есть проблемы ${snapshot.data}');
            }
            return Center(
              child: CircularProgressIndicator(
                color: colorsStyle.secondary,
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: colorsStyle.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              icon: Image.asset(
                _selectedIndex == 0
                    ? 'assets/icons/favorites_icon_white.png'
                    : 'assets/icons/favorites_icon.png',
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              icon: Image.asset(_selectedIndex == 1
                  ? 'assets/icons/home_icon_white.png'
                  : 'assets/icons/home_icon.png'),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              icon: Image.asset(_selectedIndex == 2
                  ? 'assets/icons/room_icon_white.png'
                  : 'assets/icons/room_icon.png'),
            ),
          ],
        ),
      ),
    );
  }
}
