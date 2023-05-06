import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizState state = context.read<QuizBloc>().state;

    return Scaffold(
      backgroundColor: const Color(0xff55b993),
      body: SafeArea(
        child: Align(
          alignment: Alignment(0, 0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResultScore(text: 'SCORE'),
              ResultScore(text: '${state.score} / 20'),
              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: () {
                  context.read<QuizBloc>().add(StartGamePressed());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffaf00),
                ),
                child: Text(
                  'Start new game',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      BoxShadow(
                        color: Color(0xffb59432),
                        offset: Offset(1, 1),
                        blurRadius: 5,
                      ),
                    ],
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
