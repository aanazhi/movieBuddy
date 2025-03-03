import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets/gradient_scrollabel_list.dart';

class Playlists extends StatefulWidget {
  const Playlists({super.key});

  @override
  State<Playlists> createState() => _PlaylistsState();
}

class _PlaylistsState extends State<Playlists> {
  @override
  Widget build(BuildContext context) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const AppBurCustom(
          title: 'Playlists',
        ),
        // backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
        body: ListView(
          shrinkWrap: true,
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
              height: 46,
            ),
            const GradientScrollabelList(
              title: 'Любимое',
              imagePath1: 'assets/images/33.jpg',
              imagePath2: 'assets/images/15.jpg',
              imagePath3: 'assets/images/predlozh.jpg',
            ),
            const SizedBox(
              height: 66,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Text(
                    'Твои личные плейлисты',
                    style: textStyle.displayMedium,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/icons/vector.png',
                    width: 25.71,
                    height: 25.71,
                  ),
                ),
              ],
            ),
            const GradientScrollabelList(
              title: 'Фильмы для слез',
              imagePath1: 'assets/images/88.jpg',
              imagePath2: 'assets/images/99.jpg',
              imagePath3: 'assets/images/2.png',
            ),
          ],
        ),
      ),
    );
  }
}
