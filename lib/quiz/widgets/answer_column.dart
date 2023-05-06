import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class AnswerColumn extends StatelessWidget {
  const AnswerColumn({
    super.key,
    required this.question,
    required this.answer,
    required this.maxWidth,
    required this.maxHeight,
    required this.animation,
  });

  final int question;
  final int answer;
  final double maxWidth;
  final double maxHeight;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final Question question = quizQuestions[this.question];

    const double paddingHorizontal = 18;
    const double paddingVertical = 0;

    final List<Widget> children = question.answers
        .map((Answer answer) => AnswerCard(
              onTap: () {
                context.read<QuizBloc>().add(AnswerSelected(answer.number));
              },
              height: (maxHeight - paddingVertical * 2) / 5,
              type: question.type,
              answer: answer.answer,
              selectedAnswer: this.answer,
              correctAnswer: question.answer,
              number: answer.number,
              animation: animation,
              maxWidth: maxWidth,
              answerCount: question.answers.length,
            ))
        .toList();

    final Widget child = Center(
      child: GridView.count(
        clipBehavior: Clip.none,
        shrinkWrap: true,
        childAspectRatio: ((maxWidth - paddingHorizontal * 2) / 2) /
            ((maxHeight - paddingVertical * 2) / 3),
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        children: children,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      child: child,
    );
  }
}
