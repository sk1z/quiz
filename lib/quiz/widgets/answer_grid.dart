import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class AnswerGrid extends StatelessWidget {
  const AnswerGrid({
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

    const double horizontalPadding = 18;
    const double crossAxisSpacing = 16;
    const double mainAxisSpacing = 16;

    final double cardWidth =
        (maxWidth - horizontalPadding * 2 - crossAxisSpacing) / 2;
    final double cardHeight = (maxHeight - mainAxisSpacing * 2) / 3;

    final List<Widget> children = question.answers.map((Answer answer) {
      return AnswerCard(
        onTap: () {
          context.read<QuizBloc>().add(AnswerSelected(answer.number));
        },
        type: question.type,
        answer: answer.answer,
        selectedAnswer: this.answer,
        correctAnswer: question.answer,
        number: answer.number,
        animation: animation,
        width: cardWidth,
        horizontalPadding: horizontalPadding,
      );
    }).toList();

    return Center(
      child: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        clipBehavior: Clip.none,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: cardWidth / cardHeight,
        children: children,
      ),
    );
  }
}
