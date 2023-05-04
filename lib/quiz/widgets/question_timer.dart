import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

Duration _duration = Duration(seconds: answerSeconds);

const Curve _curve = Curves.linear;

class QuestionTimer extends StatefulWidget {
  const QuestionTimer({super.key, required this.round, this.animate = true});

  final int round;
  final bool animate;

  @override
  State<QuestionTimer> createState() => _QuestionTimerState();
}

class _QuestionTimerState extends State<QuestionTimer>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: _duration, vsync: this, value: 1)
        ..reverse();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: _curve,
  );

  @override
  void didUpdateWidget(covariant QuestionTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.animate) {
      _controller.stop();
    } else if (widget.round != oldWidget.round) {
      _controller
        ..value = 1
        ..reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: LinearProgressIndicator(
              minHeight: 10,
              backgroundColor: Color(0xff2039ce),
              color: _animation.value > 0.5
                  ? Color.lerp(
                      Color(0xffefd838),
                      Color(0xff0aeb6f),
                      lerpDouble(-1, 1, _animation.value)!,
                    )
                  : Color.lerp(
                      Color(0xffdd3e37),
                      Color(0xffefd838),
                      lerpDouble(0, 2, _animation.value)!,
                    ),
              value: _animation.value,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
