import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz_bloc/quiz_bloc.dart';

class StagePage extends StatelessWidget {
  const StagePage({super.key, required this.stage});

  final int stage;

  @override
  Widget build(BuildContext context) {
    final QuizState state = context.read<QuizBloc>().state;
    final Stage quizStage = quiz[stage];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Correct answers: ${state.correctAnswerCount} / ${quiz.length}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text('Question ${state.stage + 1}'),
              const SizedBox(height: 12),
              Text(quizStage.question),
              const SizedBox(height: 12),
              Column(
                children: quizStage.answers
                    .map((Answer answer) => ElevatedButton(
                          child: Text(answer.answer),
                          onPressed: () {
                            context
                                .read<QuizBloc>()
                                .add(AnswerSelected(answer.number));
                          },
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
