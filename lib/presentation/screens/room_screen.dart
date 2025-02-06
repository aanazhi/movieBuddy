import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBurCustom(
          title: 'Room',
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
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 191),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(323, 90),
                    backgroundColor: Color.fromRGBO(74, 125, 255, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          'Создать новую комнату',
                          style: TextStyle(
                            fontFamily: 'Aldrich',
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            color: const Color.fromRGBO(207, 220, 253, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 300),
                        child: Image.asset('assets/icons/room_icon_plus.png'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(323, 90),
                    backgroundColor: Color.fromRGBO(34, 34, 34, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: Colors.white,
                        )),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: Text(
                          'Присоединиться',
                          style: TextStyle(
                            fontFamily: 'Aldrich',
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            color: const Color.fromRGBO(207, 220, 253, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 300),
                        child: Image.asset('assets/icons/arrow_2.png'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
