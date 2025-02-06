import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/presentation/screens/main_screen.dart';
import 'package:moviebuddy/presentation/screens/playlists_screen.dart';
import 'package:moviebuddy/presentation/screens/room_screen.dart';
import 'package:moviebuddy/presentation/screens/search_screen.dart';

import 'presentation/screens/enterance_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EnteranceScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  List<Widget> _widgetOptions = <Widget>[
    Playlists(),
    MainScreen(),
    RoomScreen(),
  ];

  void onTabItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromRGBO(34, 34, 34, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => onTabItem(0),
                icon: Image.asset(
                  _selectedIndex == 0
                      ? 'assets/icons/favorites_icon_white.png'
                      : 'assets/icons/favorites_icon.png',
                ),
              ),
              IconButton(
                onPressed: () => onTabItem(1),
                icon: Image.asset(_selectedIndex == 1
                    ? 'assets/icons/home_icon_white.png'
                    : 'assets/icons/home_icon.png'),
              ),
              IconButton(
                onPressed: () => onTabItem(2),
                icon: Image.asset(_selectedIndex == 2
                    ? 'assets/icons/room_icon_white.png'
                    : 'assets/icons/room_icon.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
