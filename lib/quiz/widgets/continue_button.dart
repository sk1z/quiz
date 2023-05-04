import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key, required this.selectedAnswer});

  final int selectedAnswer;

  @override
  Widget build(BuildContext context) {
    final Widget button = ElevatedButton(
      onPressed: () {
        context.read<QuizBloc>().add(ContinuePressed());
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Color(0xff2add6c)),
      child: const Text(
        'Continue',
        style: TextStyle(
          fontSize: 20,
          shadows: [
            BoxShadow(
              color: Colors.green,
              offset: Offset(1, 1),
              blurRadius: 5,
            ),
          ],
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 56),
      height: 50,
      child: selectedAnswer > 0 ? button : null,
    );
  }
}
