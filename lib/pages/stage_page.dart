import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz_bloc/quiz_bloc.dart';

class StagePage extends StatelessWidget {
  const StagePage({super.key, required this.stage});

  final int stage;

  @override
  Widget build(BuildContext context) {
    final QuizState state = context.read<QuizBloc>().state;
    final Stage quizStage = state.stages[stage];

    final Widget timer = BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (QuizState previous, QuizState current) =>
          previous.timeLeft != current.timeLeft,
      builder: (BuildContext context, QuizState state) {
        return Text('${state.timeLeft}');
      },
    );

    final Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        timer,
        const SizedBox(height: 12),
        Text(
          'Correct answers: ${state.correctAnswerCount} / ${state.stages.length}',
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
        const SizedBox(height: 36),
        ElevatedButton(
          child: const Text('Back to main menu'),
          onPressed: () {
            context.read<QuizBloc>().add(MainMenuPressed());
          },
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Center(child: child),
        ),
      ),
    );
  }
}
