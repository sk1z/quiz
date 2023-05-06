import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

Duration _duration = Duration(seconds: answerSeconds);

const Curve _curve = Curves.linear;

class RoundTimer extends StatefulWidget {
  const RoundTimer({
    super.key,
    required this.round,
    this.animate = true,
    required this.animation,
  });

  final int round;
  final bool animate;
  final Animation animation;

  @override
  State<RoundTimer> createState() => _RoundTimerState();
}

class _RoundTimerState extends State<RoundTimer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _duration,
    value: 1,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: _curve,
  );

  final CurveTween _fadingTween = CurveTween(curve: Interval(0, 0.25));
  final CurveTween _appearingTween = CurveTween(curve: Interval(0.44, 1));

  final Animatable<double> _fadingAnimation = Tween<double>(begin: 1, end: 0);

  late final Animatable<double> _fading;

  @override
  void initState() {
    super.initState();
    _fading = _fadingAnimation.chain(_fadingTween);
    if (widget.animate) {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant RoundTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate) {
      _controller.reverse();
    } else {
      _controller.stop();
    }
    if (widget.round != oldWidget.round) {
      _controller.value = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation.value < 0.44
              ? widget.animation.drive(_fading)
              : widget.animation.drive(_appearingTween),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return LinearProgressIndicator(
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
                );
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
