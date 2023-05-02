import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz_bloc/quiz_bloc.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizState state = context.read<QuizBloc>().state;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Correct answers: ${state.score} / ${state.stages.length}',
              ),
              const SizedBox(height: 36),
              ElevatedButton(
                child: const Text('Start New Game'),
                onPressed: () {
                  context.read<QuizBloc>().add(StartGamePressed());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
