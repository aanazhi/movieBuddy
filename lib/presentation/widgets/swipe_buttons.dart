import 'package:flutter/material.dart';

class SwipeButtons extends StatelessWidget {
  final VoidCallback onLike;
  final VoidCallback onDislike;

  const SwipeButtons({
    super.key,
    required this.onLike,
    required this.onDislike,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: onDislike,
            backgroundColor: Colors.red,
            child: const Icon(Icons.close, size: 30),
          ),
          FloatingActionButton(
            onPressed: onLike,
            backgroundColor: Colors.green,
            child: const Icon(Icons.favorite, size: 30),
          ),
        ],
      ),
    );
  }
}
