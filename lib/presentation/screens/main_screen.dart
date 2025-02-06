import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBurCustom(
          title: 'MovieBuddy',
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width / 2 - 150,
          ),
          child: Container(
            height: 63,
            width: 262,
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(74, 125, 255, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                'Создай комнату!',
                style: TextStyle(
                  fontFamily: 'Aldrich',
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  color: const Color.fromRGBO(207, 220, 253, 1),
                ),
              ),
              onPressed: () {},
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(34, 34, 34, 1),
        body: ListView(
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
              height: 50,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 20, 0),
                  width: 350,
                  height: 50,
                  child: TextField(
                    cursorColor: Color.fromRGBO(207, 220, 253, 1),
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: 'Поиск',
                      hintStyle: TextStyle(
                        fontFamily: 'Aldrich',
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: const Color.fromRGBO(207, 220, 253, 1),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(50, 50, 50, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(207, 220, 253, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(207, 220, 253, 1),
                        ),
                      ),
                      contentPadding: EdgeInsets.only(bottom: 5, left: 25),
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
                padding: EdgeInsets.only(left: 16, top: 43),
                child: Text(
                  'Лучшие фильмы',
                  style: TextStyle(
                    fontFamily: 'Aldrich',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: const Color.fromRGBO(207, 220, 253, 1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
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
                    child: Container(
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
                    child: Container(
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
                padding: EdgeInsets.only(left: 16, top: 43),
                child: Text(
                  'Лучшие сериалы',
                  style: TextStyle(
                    fontFamily: 'Aldrich',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: const Color.fromRGBO(207, 220, 253, 1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                Container(
                  height: 200,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 0.5, 1],
                        colors: [
                          Color.fromRGBO(34, 34, 34, 0.5),
                          Color.fromRGBO(34, 34, 34, 0.8),
                          Color.fromRGBO(34, 34, 34, 0.8),
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcOver,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
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
                          child: Container(
                            height: 190,
                            width: 130,
                            child: Image.asset(
                              'assets/images/96.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
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
