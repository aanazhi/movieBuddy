import 'package:flutter/material.dart';
import 'package:moviebuddy/presentation/screens/profile_screen.dart';

class AppBurCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBurCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(34, 34, 34, 1),
      title: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Aldrich',
                  fontWeight: FontWeight.w400,
                  fontSize: 40,
                  color: const Color.fromRGBO(207, 220, 253, 1),
                ),
              ),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.fromRGBO(207, 220, 253, 1),
                    width: 3,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
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
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
