import 'package:flutter/material.dart';
import 'package:moviebuddy/presentation/screens/profile_screen.dart';

class AppBurCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBurCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return AppBar(
      // backgroundColor: const Color.fromRGBO(34, 34, 34, 1),
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()));
                  },
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/cow.jpg',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
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
