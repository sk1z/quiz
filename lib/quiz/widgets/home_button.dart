import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    ButtonStyle style = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(8),
      backgroundColor: const Color(0xffccccc9),
      side: const BorderSide(color: Color(0xff477a67)),
    );
    TextStyle textStyle = TextStyle(
      color: Color(0xFFAC9818),
      shadows: [
        Shadow(
          color: Color(0xff887d57),
          blurRadius: 1,
        ),
      ],
    );

    return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: style,
                    onPressed: () {
                      context.read<QuizBloc>().add(MainMenuPressed());
                    },
                    child: Text('Back to main menu', style: textStyle),
                  ),
                );
  }
}