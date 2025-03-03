import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        // backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
        body: ListView(
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
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/images/settings.png',
                    width: 33,
                    height: 33,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
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
            SizedBox(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      height: 190,
                      width: 130,
                      child: Image.asset(
                        'assets/images/44.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      height: 190,
                      width: 130,
                      child: Image.asset(
                        'assets/images/55.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      height: 190,
                      width: 130,
                      child: Image.asset(
                        'assets/images/3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0, 0.5, 1],
                        colors: [
                          colorsStyle.tertiaryFixed,
                          colorsStyle.onTertiaryFixed,
                          colorsStyle.onTertiaryFixed,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcOver,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: SizedBox(
                            height: 190,
                            width: 130,
                            child: Image.asset(
                              'assets/images/95.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            height: 190,
                            width: 130,
                            child: Image.asset(
                              'assets/images/96.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            height: 190,
                            width: 130,
                            child: Image.asset(
                              'assets/images/97.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
