import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuizRoundForm extends StatefulWidget {
  const QuizRoundForm({
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
  State<QuizRoundForm> createState() =>
      _QuizRoundFormState(round, question, answer);
}

class _QuizRoundFormState extends State<QuizRoundForm>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    value: 1,
    duration: Duration(milliseconds: animationTime),
  )
    ..addListener(() {
      print(_controller.value);
      if (_controller.value >= 0.44 && round != widget.round) {
        round = widget.round;
        question = widget.question;
        answer = widget.answer;
        print(answer);
        setState(() {});
      }
    })
    ..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animateTimer = true;
        setState(() {});
      }
    });

  final CurveTween _opacity = CurveTween(curve: Interval(0, 0.26));
  final Animatable<double> _itemPosition = Tween<double>(
    begin: 1,
    end: 0,
  );

  _QuizRoundFormState(this.round, this.question, this.answer);

  int round;
  int question;
  int answer;
  bool animateTimer = true;

  @override
  void didUpdateWidget(covariant QuizRoundForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.round != oldWidget.round) {
      _controller
        ..value = 0
        ..forward();
    }
    if (widget.round == oldWidget.round && widget.answer != oldWidget.answer) {
      answer = widget.answer;
      animateTimer = false;
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
        Row(
          children: [
            const Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: RestartButton(),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: RoundScore(text: '${widget.score}', width: 45),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: RoundScore(text: '$round/$questionCount', width: 75),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        QuestionCard(question: question, animation: _controller),
        const SizedBox(height: 18),
        RoundTimer(
          round: round,
          animate: animateTimer,
          animation: _controller,
        ),
        const SizedBox(height: 12),
        Expanded(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                if (_controller.value <= 0.5) {
                  return FadeTransition(
                    opacity: _itemPosition.chain(_opacity).animate(_controller),
                    child: child,
                  );
                }

                // if (quizQuestions[question].type == QuestionType.text) {
                //   return FadeTransition(
                //     opacity: _textOpacity.animate(_roundController),
                //     child: ScaleTransition(
                //       scale:
                //           _scale.chain(_textOpacity).animate(_roundController),
                //       child: child,
                //     ),
                //   );
                // }

                return child!;
              },
              child: AnswerColumn(
                question: question,
                answer: answer,
                maxWidth: constraints.maxWidth,
                maxHeight: constraints.maxHeight,
                animation: _controller,
              ),
            );
          },
        )),
        const SizedBox(height: 18),
        ContinueButton(selectedAnswer: widget.answer),
        const SizedBox(height: 24),
      ],
    );
  }
}
