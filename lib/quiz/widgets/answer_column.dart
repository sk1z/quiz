import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class AnswerColumn extends StatelessWidget {
  const AnswerColumn({
    super.key,
    required this.questionNumber,
    required this.maxWidth,
    required this.maxHeight,
  });

  final int questionNumber;
  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final Question question = quizQuestions[questionNumber];
    final bool answersShown =
        context.select((QuizBloc bloc) => bloc.state.answersShown);

    const double paddingHorizontal = 12;
    const double paddingVertical = 24;

    final double questionCardHeight = (maxHeight - paddingVertical * 2) / 5;

    final Widget child;

    if (question.type == QuestionType.text) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: question.answers
            .map((Answer answer) => AnswerCard(
                  height: questionCardHeight,
                  text: answer.answer,
                  onTap: () {
                    context.read<QuizBloc>().add(AnswerSelected(answer.number));
                  },
                  correctAnswer:
                      answersShown ? answer.number == question.answer : null,
                ))
            .toList(),
      );
    } else {
      child = Center(
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          clipBehavior: Clip.none,
          shrinkWrap: true,
          childAspectRatio: ((maxWidth - paddingHorizontal * 2) / 2) /
              ((maxHeight - paddingVertical * 2) / 3),
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          // mainAxisSpacing: 2,
          // crossAxisSpacing: 12,
          children: question.answers
              .map((Answer answer) => AnswerCard(
                    height: questionCardHeight,
                    image: answer.answer,
                    onTap: () {
                      context
                          .read<QuizBloc>()
                          .add(AnswerSelected(answer.number));
                    },
                    correctAnswer:
                        answersShown ? answer.number == question.answer : null,
                  ))
              .toList(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: paddingVertical),
      child: child,
    );
  }
}
