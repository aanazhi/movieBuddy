import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const AppBurCustom(
        title: 'Room',
      ),
      backgroundColor: colorsStyle.primary,
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 191),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(323, 90),
                  backgroundColor: colorsStyle.surface,
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
                        style: textStyle.displayMedium,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 300,
                      ),
                      child: Image.asset('assets/icons/room_icon_plus.png'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(
                    323,
                    90,
                  ),
                  backgroundColor: colorsStyle.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: colorsStyle.secondary,
                      )),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Text(
                        'Присоединиться',
                        style: textStyle.displayMedium,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 300,
                      ),
                      child: Image.asset('assets/icons/arrow_2.png'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
