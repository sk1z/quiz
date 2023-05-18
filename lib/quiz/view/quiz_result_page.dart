import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key, required this.score, required this.count});

  final int score;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff55b993),
      body: SafeArea(
        child: Align(
          alignment: const Alignment(0, 0.1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ResultScore(text: 'SCORE'),
              ResultScore(text: '$score / $count'),
              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: () {
                  context.read<QuizBloc>().add(StartGamePressed());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffffaf00),
                ),
                child: const Text(
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
