import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets/gradient_scrollabel_list.dart';

class Playlists extends StatelessWidget {
  const Playlists({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBurCustom(
          title: 'Playlists',
        ),
        backgroundColor: Color.fromRGBO(34, 34, 34, 1),
        body: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              color: Color.fromRGBO(207, 220, 253, 1),
              height: 1,
              width: double.infinity,
            ),
            SizedBox(
              height: 46,
            ),
            GradientScrollabelList(
              title: 'Любимое',
              imagePath1: 'assets/images/33.jpg',
              imagePath2: 'assets/images/15.jpg',
              imagePath3: 'assets/images/predlozh.jpg',
            ),
            SizedBox(
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
                    style: TextStyle(
                      fontFamily: 'Aldrich',
                      fontWeight: FontWeight.w400,
                      fontSize: 25,
                      color: const Color.fromRGBO(207, 220, 253, 1),
                    ),
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
            GradientScrollabelList(
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
