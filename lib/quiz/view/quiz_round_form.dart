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
  State<QuizRoundForm> createState() => _QuizRoundFormState();
}

class _QuizRoundFormState extends State<QuizRoundForm>
    with SingleTickerProviderStateMixin {
  late int round;
  late int question;
  late int answer;
  bool animateTimer = true;

  static final Animatable<double> _opacityIntervalTween =
      CurveTween(curve: const Interval(0, 0.26));
  static final Animatable<double> _opacityTween =
      Tween<double>(begin: 1, end: 0);

  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    round = widget.round;
    question = widget.question;
    answer = widget.answer;

    _controller =
        AnimationController(value: 1, duration: animationTime, vsync: this)
          ..addListener(_animationValueChanged)
          ..addStatusListener(_animationStatusChanged);
    _opacity = _controller.drive(_opacityTween.chain(_opacityIntervalTween));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animationValueChanged() {
    if (_controller.value < 0.44 || round == widget.round) return;
    round = widget.round;
    question = widget.question;
    answer = widget.answer;
    setState(() {});
  }

  void _animationStatusChanged(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    animateTimer = true;
    setState(() {});
  }

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 18),
        Row(
          children: [
            const SizedBox(width: 18),
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
            const SizedBox(width: 18),
          ],
        ),
        const SizedBox(height: 24),
        QuestionCard(question: question, animation: _controller),
        const SizedBox(height: 18),
        RoundTimer(
          round: round,
          animate: animateTimer,
          animation: _controller,
        ),
        const SizedBox(height: 20),
        Expanded(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget answerColumn = AnswerGrid(
              question: question,
              answer: answer,
              maxWidth: constraints.maxWidth,
              maxHeight: constraints.maxHeight,
              animation: _controller,
            );

            if (round == widget.round) return answerColumn;

            return FadeTransition(
              opacity: _opacity,
              child: answerColumn,
            );
          },
        )),
        const SizedBox(height: 26),
        ContinueButton(show: widget.answer != 0),
        const SizedBox(height: 24),
      ],
    );
  }
}
