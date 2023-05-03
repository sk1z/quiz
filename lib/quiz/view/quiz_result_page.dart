import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizState state = context.read<QuizBloc>().state;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Score(text: 'SCORE'),
              Score(text: '${state.score}'),
              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: () {
                  context.read<QuizBloc>().add(StartGamePressed());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffd028dc),
                ),
                child: const Text(
                  'Start new game',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
