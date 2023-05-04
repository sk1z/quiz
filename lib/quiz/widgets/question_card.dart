import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.question});

  final int question;

  @override
  Widget build(BuildContext context) {
    final String question = quizQuestions[this.question].question;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 18),
      color: Color(0xfff5fcfe),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 100,
        alignment: Alignment.center,
        child: Text(
          question,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: Color(0xff3437a3),
          ),
        ),
      ),
    );
  }
}
