import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

class Health extends StatelessWidget {
  const Health({super.key, required this.health});

  final int health;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++) Heart(solid: i < health),
      ],
    );
  }
}
