import 'package:flutter/material.dart';

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

class RoundTimer extends StatelessWidget {
  RoundTimer({
    super.key,
    required Animation<double> animation,
    required this.timeAnimation,
  }) {
    _opacity = animation.drive(_opacityTween);
    _color = timeAnimation.drive(_colorTween);
  }

  final Animation<double> timeAnimation;

  static final Animatable<double> _opacityTween = TweenSequence<double>([
    TweenSequenceItem(
      weight: 0.26,
      tween: Tween<double>(begin: 1, end: 0),
    ),
    TweenSequenceItem(
      weight: 0.18,
      tween: Tween<double>(begin: 0, end: 0),
    ),
    TweenSequenceItem(
      weight: 0.56,
      tween: Tween<double>(begin: 0, end: 1)
          .chain(CurveTween(curve: Curves.easeOut)),
    ),
  ]);
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

  late final Animation<double> _opacity;
  late final Animation<Color?> _color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: FadeTransition(
          opacity: _opacity,
          child: AnimatedBuilder(
              animation: timeAnimation,
              builder: (BuildContext context, Widget? child) {
                return LinearProgressIndicator(
                  minHeight: 10,
                  backgroundColor: const Color(0xff2039ce),
                  color: _color.value,
                  value: timeAnimation.value,
                );
              }),
        ),
      ),
    );
  }
}
