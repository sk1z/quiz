import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

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
  static final Animatable<double> _fadeIntervalTween =
      CurveTween(curve: Interval(0, 0.25));
  static final Animatable<double> _fadeTween = Tween<double>(begin: 1, end: 0);
  static final Animatable<double> _appeareTween =
      CurveTween(curve: Interval(0.44, 1));
  static final Animatable<double> _redYellowIntervalTween =
      CurveTween(curve: Interval(0, 0.5));
  static final Animatable<double> _yellowGreenIntervalTween =
      CurveTween(curve: Interval(0.5, 1));
  static final Animatable<Color?> _redYellowTween = ColorTween(
    begin: const Color(0xffdd3e37),
    end: const Color(0xffefd838),
  );
  static final Animatable<Color?> _yellowGreenTween = ColorTween(
    begin: const Color(0xffefd838),
    end: const Color(0xff0aeb6f),
  );

  late Animation<double> _fade;
  late Animation<double> _appear;
  late AnimationController _controller;
  late Animation<Color?> _redYellow;
  late Animation<Color?> _yellowGreen;

  @override
  void initState() {
    super.initState();
    _fade = widget.animation.drive(_fadeTween.chain(_fadeIntervalTween));
    _appear = widget.animation.drive(_appeareTween);

    _controller = AnimationController(
      value: 1,
      duration: answerTime,
      vsync: this,
    );
    _redYellow =
        _controller.drive(_redYellowTween.chain(_redYellowIntervalTween));
    _yellowGreen =
        _controller.drive(_yellowGreenTween.chain(_yellowGreenIntervalTween));

    if (widget.animate) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    final Animation<double> opacity =
        widget.animation.value < 0.44 ? _fade : _appear;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: FadeTransition(
          opacity: opacity,
          child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                final Color? color = _controller.value < 0.5
                    ? _redYellow.value
                    : _yellowGreen.value;

                return LinearProgressIndicator(
                  minHeight: 10,
                  backgroundColor: const Color(0xff2039ce),
                  color: color,
                  value: _controller.value,
                );
              }),
        ),
      ),
    );
  }
}
