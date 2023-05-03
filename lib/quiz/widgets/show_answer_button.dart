import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_game/quiz/bloc/quiz_bloc.dart';

class ShowAnswerButton extends StatelessWidget {
  const ShowAnswerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style.merge(
          const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        );
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(8),
      backgroundColor: const Color(0xffccccc9),
      textStyle: style,
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
    final prototypeShowAnswersText = TextPainter(
      text: TextSpan(text: 'Show answers', style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
    )..layout();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          context.read<QuizBloc>().add(ChangeShowingAnswers());
        },
        child: BlocBuilder<QuizBloc, QuizState>(
          buildWhen: (QuizState previous, QuizState current) =>
              previous.answersShown != current.answersShown,
          builder: (BuildContext context, QuizState state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  state.answersShown
                      ? FontAwesomeIcons.eyeSlash
                      : FontAwesomeIcons.eye,
                  size: 20,
                  color: Color(0xFFAC9818),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: prototypeShowAnswersText.width,
                  child: Text(
                    state.answersShown ? 'Hide answers' : 'Show answers',
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
