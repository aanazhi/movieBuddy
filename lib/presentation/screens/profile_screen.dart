import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSwitchedFirst = false;
  bool _isSwitchedSecond = false;

  @override
  Widget build(BuildContext context) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
        appBar: AppBar(
          // backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/icons/arrow_back.png',
              height: 23.43,
              width: 12.59,
            ),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorsStyle.secondary,
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/cow.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 22,
                        top: 19,
                      ),
                      child: Text(
                        'admin@gmail.com',
                        style: textStyle.bodySmall,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    bottom: 30,
                  ),
                  child: Text(
                    'Aanazhi',
                    style: textStyle.bodyLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 23,
                    bottom: 30,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Image.asset(
                      'assets/icons/group.png',
                      width: 22,
                      height: 22.05,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 109,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 22,
                  ),
                  child: Switch(
                    value: _isSwitchedFirst,
                    onChanged: (value) {
                      setState(() {
                        _isSwitchedFirst = value;
                      });
                    },
                    activeTrackColor: colorsStyle.surface,
                    activeColor: colorsStyle.secondary,
                    inactiveThumbColor: colorsStyle.secondary,
                    inactiveTrackColor: colorsStyle.onPrimary,
                  ),
                ),
                Container(
                  height: 63,
                  width: 270,
                  padding: const EdgeInsets.only(
                    left: 13,
                  ),
                  child: Text(
                    'Присылайте мне уведомления, когда меня приглашают в комнату',
                    maxLines: 3,
                    style: textStyle.bodyMedium,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Switch(
                    value: _isSwitchedSecond,
                    onChanged: (value) {
                      setState(() {
                        _isSwitchedSecond = value;
                      });
                    },
                    activeTrackColor: colorsStyle.surface,
                    activeColor: colorsStyle.secondary,
                    inactiveThumbColor: colorsStyle.secondary,
                    inactiveTrackColor: colorsStyle.onPrimary,
                  ),
                ),
                Container(
                  height: 63,
                  width: 270,
                  padding: const EdgeInsets.only(
                    left: 13,
                  ),
                  child: Text(
                    'Я согласен получать электронные письма о новых функциях',
                    maxLines: 3,
                    style: textStyle.bodyMedium,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 26,
                      right: 5,
                    ),
                    child: Image.asset(
                      'assets/icons/change_password.png',
                      height: 28,
                      width: 28,
                    ),
                  ),
                  Text(
                    'Изменить пароль',
                    maxLines: 3,
                    style: textStyle.labelMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 26,
                      right: 5,
                    ),
                    child: Image.asset(
                      'assets/icons/log_out.png',
                      height: 28,
                      width: 28,
                    ),
                  ),
                  Text(
                    'Выйти',
                    maxLines: 3,
                    style: textStyle.labelMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
