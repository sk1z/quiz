import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuizRoundPage extends StatelessWidget {
  const QuizRoundPage({
    super.key,
    required this.round,
    required this.question,
    required this.score,
    required this.answer,
    required this.count,
  });

  final int round;
  final int question;
  final int score;
  final int answer;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3a4bc3),
      body: SafeArea(
        child: QuizRoundForm(
          round: round,
          question: question,
          score: score,
          answer: answer,
          count: count,
        ),
      ),
    );
  }
}
