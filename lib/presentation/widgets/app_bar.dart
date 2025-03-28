import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviebuddy/presentation/screens/profile_screen.dart';
import 'package:moviebuddy/provider/providers.dart';

class AppBurCustom extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  const AppBurCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    final localEmailDataSource = ref.watch(userEmailLocalDataSourceProvider);

    final localNicknameDataSource =
        ref.watch(userNicknameLocalDataSourceProvider);

    final localPhotoDataSource = ref.watch(userPhotoLocalDataSourceProvider);
    final userPhoto = localPhotoDataSource.getUserPhoto();

    return AppBar(
      backgroundColor: colorsStyle.primary,
      title: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: textStyle.displayLarge,
              ),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorsStyle.secondary,
                    width: 3,
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    final userEmail = await localEmailDataSource.getUserEmail();
                    final userNickname =
                        await localNicknameDataSource.getUserNickname();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          nickname: userNickname,
                          email: userEmail,
                        ),
                      ),
                    );
                  },
                  child: FutureBuilder<String?>(
                    future: userPhoto,
                    builder: (context, snapshot) {
                      print('snapshot -  ${snapshot.data}');
                      if (snapshot.data != null && snapshot.hasData) {
                        return ClipOval(
                          child: Image.file(
                            File(snapshot.data!),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return ClipOval(
                          child: Image.asset(
                            'assets/images/cow.jpg',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
