import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

const List<Color> _colors = const [
  Color(0xffdd3e37),
  Color(0xffe65630),
  Color(0xffed6d2a),
  Color(0xfff28323),
  Color(0xfff49920),
  Color(0xfff4ae21),
  Color(0xfff3c32a),
  Color(0xffefd838),
  Color(0xffdcdc35),
  Color(0xffc8e037),
  Color(0xffb2e33d),
  Color(0xff9ae646),
  Color(0xff7ee852),
  Color(0xff5aea60),
  Color(0xff0aeb6f),
];

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
      CurveTween(curve: const Interval(0, 0.25));
  static final Animatable<double> _fadeTween = Tween<double>(begin: 1, end: 0);
  static final Animatable<double> _appeareTween =
      CurveTween(curve: const Interval(0.44, 1));
  static final Animatable<Color?> _colorTween = TweenSequence<Color?>([
    for (int i = 0; i < _colors.length - 1; i++)
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: _colors[i],
          end: _colors[i + 1],
        ),
      ),
  ]);

  late Animation<double> _fade;
  late Animation<double> _appear;
  late AnimationController _controller;
  late Animation<Color?> _color;

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
    _color = _controller.drive(_colorTween);

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
                return LinearProgressIndicator(
                  minHeight: 10,
                  backgroundColor: const Color(0xff2039ce),
                  color: _color.value,
                  value: _controller.value,
                );
              }),
        ),
      ),
    );
  }
}
