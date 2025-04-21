import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/presentation/screens/enterance_screen.dart';
import 'package:moviebuddy/provider/providers.dart';

class ProfileScreen extends ConsumerWidget {
  final String? nickname;
  final String? email;

  const ProfileScreen({super.key, required this.nickname, required this.email});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    final switchState = ref.watch(switchProvider);
    final switchNotifier = ref.watch(switchProvider.notifier);

    final localPhotoDataSource = ref.watch(userPhotoLocalDataSourceProvider);

    return Scaffold(
      backgroundColor: colorsStyle.primary,
      appBar: AppBar(
        backgroundColor: colorsStyle.primary,
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
                      child: Consumer(
                        builder: (context, ref, child) {
                          final imageState = ref.watch(imageProvider);
                          final imageNotifierState =
                              ref.watch(imageProvider.notifier);
                          final localPhotoDataSource =
                              ref.watch(userPhotoLocalDataSourceProvider);

                          if (kDebugMode) {
                            print('imageState  - $imageState');
                          }

                          return FutureBuilder<String?>(
                              future: localPhotoDataSource.getUserPhoto(),
                              builder: (context, snapshot) {
                                String? photoPath;
                                if (imageState != null) {
                                  photoPath = imageState.path;
                                } else {
                                  photoPath = snapshot.data;
                                }

                                return InkWell(
                                    onTap: () async {
                                      await imageNotifierState.pickImage();
                                      if (imageState != null) {
                                        await localPhotoDataSource
                                            .saveUserPhoto(imageState.path);
                                      }
                                    },
                                    child: ClipOval(
                                      child: _buildProfileImage(photoPath),
                                    ));
                              });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 19,
                    ),
                    child: Text(
                      email ?? 'неизвестно',
                      style: textStyle.bodySmall,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                  bottom: 30,
                ),
                child: Text(
                  nickname ?? 'неизвестно',
                  style: textStyle.bodyLarge,
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
                  value: switchState.isFirstSwitched,
                  onChanged: (value) {
                    switchNotifier.toggleFirstSwitch();
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
                  style: textStyle.bodySmall,
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
                  value: switchState.isSecondSwitched,
                  onChanged: (value) {
                    switchNotifier.toggleSeconfSwitch();
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
                  style: textStyle.bodySmall,
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
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => EnteranceScreen(),
                ),
                (Route<dynamic> route) => false,
              );
            },
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
    );
  }
}

Widget _buildProfileImage(String? photoPath) {
  if (photoPath == null ||
      photoPath.isEmpty ||
      photoPath == 'assets/images/black.png') {
    return Image.asset(
      'assets/images/black.png',
      fit: BoxFit.cover,
    );
  } else {
    return Image.file(
      File(photoPath),
      fit: BoxFit.cover,
    );
  }
}
