import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuizRoundForm extends StatefulWidget {
  const QuizRoundForm({
    super.key,
    required this.round,
    required this.question,
    required this.score,
    required this.answer,
    required this.count,
  });

  final int round;
  final int question;
  final int score;
  final int answer;
  final int count;

  @override
  State<QuizRoundForm> createState() => _QuizRoundFormState();
}

class _QuizRoundFormState extends State<QuizRoundForm>
    with TickerProviderStateMixin {
  late int _round;
  late int _question;
  late int _answer;

  static final Animatable<double> _opacityTween =
      Tween<double>(begin: 1, end: 0)
          .chain(CurveTween(curve: const Interval(0, 0.26)));

  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final AnimationController _timeController;

  ModalRoute<Object?>? _route;

  @override
  void initState() {
    super.initState();
    _round = widget.round;
    _question = widget.question;
    _answer = widget.answer;

    _controller = AnimationController(
      value: 1,
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )
      ..addListener(_animationValueChanged)
      ..addStatusListener(_animationStatusChanged);
    _opacity = _controller.drive(_opacityTween);

    _timeController = AnimationController(
      value: 1,
      duration: const Duration(seconds: 15),
      vsync: this,
    )..addStatusListener(_timeAnimationStatusChanged);
  }

  @override
  void dispose() async {
    _controller.dispose();
    _timeController.dispose();
    _route?.animation?.removeStatusListener(_routeAnimationStatusChanged);
    super.dispose();
  }

  void _animationValueChanged() {
    if (_controller.value < 0.44 || _round == widget.round) return;
    _round = widget.round;
    _question = widget.question;
    _answer = widget.answer;
    setState(() {});
    _timeController.value = 1;
  }

  void _animationStatusChanged(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _timeController.reverse();
  }

  void _timeAnimationStatusChanged(AnimationStatus status) {
    if (status != AnimationStatus.dismissed) return;
    context.read<QuizBloc>().add(TimeOver());
  }

  void _routeAnimationStatusChanged(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _timeController.reverse();
    _route?.animation?.removeStatusListener(_routeAnimationStatusChanged);
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
      _answer = widget.answer;
      setState(() {});
      _timeController.stop();
    }
  }

  @override
  void reassemble() {
    context.read<QuizBloc>().add(TimeOver());
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    _route ??= ModalRoute.of(context)
      ?..animation?.addStatusListener(_routeAnimationStatusChanged);

    final Widget child = Column(
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
                child: RoundScore(text: '$_round/${widget.count}', width: 75),
              ),
            ),
            const SizedBox(width: 18),
          ],
        ),
        const SizedBox(height: 24),
        QuestionCard(question: _question, animation: _controller),
        const SizedBox(height: 18),
        RoundTimer(animation: _controller, timeAnimation: _timeController),
        const SizedBox(height: 20),
        Expanded(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget answerColumn = AnswerGrid(
              question: _question,
              answer: _answer,
              maxWidth: constraints.maxWidth,
              maxHeight: constraints.maxHeight,
              animation: _controller,
              onTap: (int number) {
                if (!_timeController.isAnimating) return;
                context.read<QuizBloc>().add(AnswerSelected(number));
              },
            );

            if (_round == widget.round) return answerColumn;

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

    return BlocListener<QuizBloc, QuizState>(
      listenWhen: (QuizState previous, QuizState current) =>
          previous.round != current.round,
      listener: (BuildContext context, QuizState state) {
        if (state.round < 0) {
          _timeController.stop();
        }
      },
      child: child,
    );
  }
}
