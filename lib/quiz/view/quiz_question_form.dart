import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuizQuestionForm extends StatefulWidget {
  const QuizQuestionForm({
    super.key,
    required this.round,
    required this.question,
    required this.score,
    required this.answer,
  });

  final int round;
  final int question;
  final int score;
  final int answer;

  @override
  State<QuizQuestionForm> createState() =>
      _QuizQuestionFormState(round, question, answer);
}

class _QuizQuestionFormState extends State<QuizQuestionForm>
    with TickerProviderStateMixin {
  late final AnimationController _roundController = AnimationController(
    vsync: this,
    value: 1,
    duration: Duration(milliseconds: animationTime),
  )..addListener(() {
      print(_roundController.value);
      if (_roundController.value > 0.5 && round != widget.round) {
        round = widget.round;
        question = widget.question;
        answer = widget.answer;
        print(answer);
        setState(() {});
      }
    });

  final CurveTween _opacity = CurveTween(curve: Interval(0, 0.5));
  final Animatable<double> _itemPosition = Tween<double>(
    begin: 1,
    end: 0,
  );

  _QuizQuestionFormState(this.round, this.question, this.answer);

  int round;
  int question;
  int answer;

  @override
  void didUpdateWidget(covariant QuizQuestionForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.round != oldWidget.round) {
      _roundController
        ..value = 0
        ..forward();
    }
    if (widget.round == oldWidget.round && widget.answer != oldWidget.answer) {
      answer = widget.answer;
      setState(() {});
    }
  }

  final CurveTween _textOpacity = CurveTween(curve: Interval(0.5, 1));

  final Animatable<double> _scale = Tween<double>(
    begin: 0.8,
    end: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: RestartButton(),
        ),
        const SizedBox(height: 6),
        QuestionCard(question: question),
        const SizedBox(height: 18),
        QuestionTimer(round: round, animate: answer == 0),
        const SizedBox(height: 12),
        Expanded(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return AnimatedBuilder(
              animation: _roundController,
              builder: (BuildContext context, Widget? child) {
                if (_roundController.value <= 0.5) {
                  return FadeTransition(
                    opacity:
                        _itemPosition.chain(_opacity).animate(_roundController),
                    child: child,
                  );
                }

                if (quizQuestions[question].type == QuestionType.text) {
                  return FadeTransition(
                    opacity: _textOpacity.animate(_roundController),
                    child: ScaleTransition(
                      scale:
                          _scale.chain(_textOpacity).animate(_roundController),
                      child: child,
                    ),
                  );
                }

                return child!;
              },
              child: AnswerColumn(
                question: question,
                answer: answer,
                maxWidth: constraints.maxWidth,
                maxHeight: constraints.maxHeight,
                animation: _roundController,
              ),
            );
          },
        )),
        const SizedBox(height: 18),
        ContinueButton(selectedAnswer: widget.answer),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            QuizScore(text: '${round}/20', width: 75),
            QuizScore(text: '${widget.score}', width: 45),
          ],
        ),
      ],
    );
  }
}
