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
    final colorsStyle = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Stack(
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
                    left: 22,
                  ),
                  child: SizedBox(
                    height: 190,
                    width: 130,
                    child: Image.asset(
                      imagePath1,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 190,
                  width: 130,
                  child: Image.asset(
                    imagePath2,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: SizedBox(
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
          padding: const EdgeInsets.only(
            left: 40,
            top: 160,
          ),
          child: Text(
            title,
            style: textStyle.displaySmall,
          ),
        ),
      ],
    );
  }
}
