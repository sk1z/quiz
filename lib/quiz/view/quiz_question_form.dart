import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuizQuestionForm extends StatelessWidget {
  const QuizQuestionForm({
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const HomeButton(),
            const ShowAnswerButton(),
          ],
        ),
        Expanded(
          child: BlocBuilder<QuizBloc, QuizState>(
            buildWhen: (QuizState previous, QuizState current) =>
                previous.questionNumber != current.questionNumber,
            builder: (BuildContext context, QuizState state) {
              return Column(
                children: [
                  Health(health: health),
                  QuestionCard(questionNumber: questionNumber),
                  QuestionTimer(questionNumber: questionNumber),
                  Expanded(child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(
                        // color: Colors.red,
                        child: AnswerColumn(
                          questionNumber: questionNumber,
                          maxWidth: constraints.maxWidth,
                          maxHeight: constraints.maxHeight,
                        ),
                      );
                    },
                  )),
                  Score(text: '$score'),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
