import 'package:flutter/material.dart';

class GradientScrollabelList extends StatelessWidget {
  final String title;
  final String imagePath1;
  final String imagePath2;
  final String imagePath3;

  const GradientScrollabelList({
    super.key,
    required this.title,
    required this.imagePath1,
    required this.imagePath2,
    required this.imagePath3,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  padding: EdgeInsets.only(left: 22),
                  child: Container(
                    height: 190,
                    width: 130,
                    child: Image.asset(
                      imagePath1,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 190,
                  width: 130,
                  child: Image.asset(
                    imagePath2,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 22),
                  child: Container(
                    height: 190,
                    width: 130,
                    child: Image.asset(
                      imagePath3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 40, top: 160),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Aldrich',
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: const Color.fromRGBO(207, 220, 253, 1),
            ),
          ),
        ),
      ],
    );
  }
}
