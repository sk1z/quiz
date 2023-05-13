import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class RestartButton extends StatelessWidget {
  const RestartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<QuizBloc>().add(RestartPressed());
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(4),
        minimumSize: Size.zero,
        backgroundColor: const Color(0xffccccc9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Icon(
        Icons.settings_backup_restore,
        size: 30,
        color: Colors.black54,
      ),
    );
  }
}
