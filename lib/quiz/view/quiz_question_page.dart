import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuizQuestionPage extends StatelessWidget {
  const QuizQuestionPage({
    super.key,
    required this.round,
    required this.question,
    required this.score,
    required this.answer,
  });

  final int round;
  final int question;
  final int score;
  final int answer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3a4bc3),
      body: SafeArea(
        child: QuizQuestionForm(
          round: round,
          question: question,
          score: score,
          answer: answer,
        ),
      ),
    );
  }
}
