import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuizQuestionPage extends StatelessWidget {
  const QuizQuestionPage({
    super.key,
    required this.questionNumber,
    required this.score,
    required this.health,
  });

  final int questionNumber;
  final int score;
  final int health;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: QuizQuestionForm(
          questionNumber: questionNumber,
          score: score,
          health: health,
        ),
      ),
    );
  }
}
