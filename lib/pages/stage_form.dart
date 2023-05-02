import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_game/quiz_bloc/quiz_bloc.dart';
import 'package:quiz_game/widgets/widgets.dart';

class StageForm extends StatelessWidget {
  const StageForm({super.key, required this.stage});

  final int stage;

  @override
  Widget build(BuildContext context) {
    final QuizState state = context.read<QuizBloc>().state;
    final Stage quizStage = state.stages[stage];

    final bool answersShown =
        context.select((QuizBloc bloc) => bloc.state.answersShown);

    final Widget timer = BlocBuilder<QuizBloc, QuizState>(
      buildWhen: (QuizState previous, QuizState current) =>
          previous.timeLeft != current.timeLeft,
      builder: (BuildContext context, QuizState state) {
        return Text(
          '${state.timeLeft}',
          style: const TextStyle(fontSize: 24),
        );
      },
    );

    final Widget answers;

    if (quizStage.type == StageType.text) {
      answers = IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: quizStage.answers
              .map((Answer answer) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: StageItem(
                      text: answer.answer,
                      onTap: () {
                        context
                            .read<QuizBloc>()
                            .add(AnswerSelected(answer.number));
                      },
                      correctAnswer: answersShown
                          ? answer.number == quizStage.answer
                          : null,
                    ),
                  ))
              .toList(),
        ),
      );
    } else {
      answers = Center(
        child: GridView.count(
          shrinkWrap: true,
          childAspectRatio: 1.5,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          mainAxisSpacing: 8,
          crossAxisSpacing: 12,
          children: quizStage.answers
              .map((Answer answer) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: StageItem(
                      image: answer.answer,
                      onTap: () {
                        context
                            .read<QuizBloc>()
                            .add(AnswerSelected(answer.number));
                      },
                      correctAnswer: state.answersShown
                          ? answer.number == quizStage.answer
                          : null,
                    ),
                  ))
              .toList(),
        ),
      );
    }

    final Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StageTimer(),
        const SizedBox(height: 36),
        Flexible(
          flex: 2,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
                color: const Color(0xff8e19b0),
              ),
              width: 70,
              height: 70,
              alignment: Alignment.center,
              child: timer,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < state.health; i++) Heart(solid: true),
            for (int i = state.health; i < 3; i++) Heart(solid: false),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 12),
          color: Color(0xff0177a9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: Color(0xff055a77),
              width: 3,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            height: 80,
            alignment: Alignment.center,
            child: Text(
              quizStage.question,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Flexible(flex: 7, child: answers),
        DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w900,
          ),
          child: Stack(
            children: [
              Text(
                '${state.score}',
                style: TextStyle(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 7
                    ..color = Color(0xffb85263),
                ),
              ),
              Text(
                '${state.score}',
                style: TextStyle(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 5
                    ..color = Color(0xfffea50d),
                ),
              ),
              Text('${state.score}'),
            ],
          ),
        ),
      ],
    );

    const String showAnswersText = 'Show answers';
    final style = DefaultTextStyle.of(context).style.merge(
          const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        );
    final prototypeShowAnswersText = TextPainter(
      text: TextSpan(text: showAnswersText, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
    )..layout();

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

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<QuizBloc, QuizState>(
          buildWhen: (QuizState previous, QuizState current) =>
              previous.answersShown != current.answersShown,
          builder: (BuildContext context, QuizState state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      context.read<QuizBloc>().add(MainMenuPressed());
                    },
                    child: Text('Back to main menu', style: textStyle),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        context.read<QuizBloc>().add(ChangeShowingAnswers());
                      },
                      child: Row(
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
                              state.answersShown
                                  ? 'Hide answers'
                                  : showAnswersText,
                              textAlign: TextAlign.center,
                              style: textStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(child: child),
              ],
            );
          },
        ),
      ),
    );
  }
}
