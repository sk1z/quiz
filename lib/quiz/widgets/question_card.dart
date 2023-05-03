import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.questionNumber,
  });

  final int questionNumber;

  @override
  Widget build(BuildContext context) {
    final String question = quizQuestions[questionNumber].question;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      color: Color(0xff0177a9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Color(0xff055a77),
          width: 3,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        height: 100,
        alignment: Alignment.center,
        child: Text(question, textAlign: TextAlign.center),
      ),
    );
  }
}
