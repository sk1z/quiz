import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz_bloc/quiz_bloc.dart';
import 'package:quiz_game/widgets/widgets.dart';

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
        return Text(
          '${state.timeLeft}',
          style: const TextStyle(fontSize: 24),
        );
      },
    );

    final Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black),
            color: const Color(0xff8e19b0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: timer,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 4, color: Color(0xffcb81d0)),
              bottom: BorderSide(width: 4, color: Color(0xffcb81d0)),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff7f00af),
                Color(0xff0a0128),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(children: [
              Text(
                'Correct answers: ${state.correctAnswerCount}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text('Question ${state.stage + 1} / ${state.stages.length}'),
              const SizedBox(height: 12),
              Text(
                quizStage.question,
                textAlign: TextAlign.center,
              ),
            ]),
          ),
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    ),
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
        child: Center(child: child),
      ),
    );
  }
}
