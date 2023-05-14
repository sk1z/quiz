import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuestionCard extends StatelessWidget {
  QuestionCard({super.key, required this.question, required this.animation}) {
    _oldAngle = animation.drive(_oldAngleTween);
    _coverAngle = animation.drive(_coverAngleTween);
    _newAngle = animation.drive(_newAngleTween);

    _coverScale = animation.drive(_coverScaleTween);
    _scale = animation.drive(_scaleTween);

    _coverOffset = animation.drive(_coverOffsetTween);
    _offset = animation.drive(_offsetTween);
  }

  final int question;
  final Animation<double> animation;

  static final Animatable<double> _disappearanceTween =
      CurveTween(curve: const Interval(0, 0.25));

  static final Animatable<double> _oldAngleTween = Tween<double>(
    begin: 0,
    end: math.pi / 12.0,
  ).chain(_disappearanceTween);
  static final Animatable<double> _coverAngleTween = Tween<double>(
    begin: 0,
    end: math.pi * 0.5,
  ).chain(CurveTween(curve: const Interval(0.44, 0.7)));
  static final Animatable<double> _newAngleTween = Tween<double>(
    begin: math.pi * -0.5,
    end: 0,
  ).chain(CurveTween(curve: const Interval(0.7, 1)));

  static final Animatable<double> _coverScaleTween = TweenSequence<double>([
    TweenSequenceItem(
      weight: 0.44,
      tween: Tween<double>(begin: 0.9, end: 1)
          .chain(CurveTween(curve: Curves.easeOut)),
    ),
    TweenSequenceItem(
      weight: 0.26,
      tween: Tween<double>(begin: 1, end: 0.8),
    ),
  ]).chain(CurveTween(curve: const Interval(0, 0.7)));
  static final Animatable<double> _scaleTween = Tween<double>(
          begin: 0.8, end: 1)
      .chain(CurveTween(curve: const Interval(0.7, 1, curve: Curves.easeOut)));

  static final Animatable<Offset> _coverOffsetTween = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(0, 4),
  ).chain(CurveTween(curve: const Interval(0.44, 0.7)));
  static final Animatable<Offset> _offsetTween = Tween<Offset>(
    begin: Offset(0, 4),
    end: Offset.zero,
  ).chain(CurveTween(curve: const Interval(0.7, 1, curve: Curves.easeOut)));

  late final Animation<double> _oldAngle;
  late final Animation<double> _coverAngle;
  late final Animation<double> _newAngle;
  late final Animation<double> _coverScale;
  late final Animation<double> _scale;
  late final Animation<Offset> _coverOffset;
  late final Animation<Offset> _offset;

  @override
  Widget build(BuildContext context) {
    final String question = quizQuestions[this.question].question;

    final Widget card = Card(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      color: const Color(0xfff5fcfe),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 100,
        alignment: Alignment.center,
        child: Text(
          question,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: Color(0xff3437a3),
          ),
        ),
      ),
    );

    final double screenWidth = MediaQuery.of(context).size.width;

    final Animatable<Offset> offsetTween = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(screenWidth - 10, 0),
    ).chain(_disappearanceTween);

    final Widget coverCard = Card(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      color: const Color(0xff252b30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 100,
        alignment: Alignment.center,
        child: const Text(
          'Quiz Game',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            Transform.translate(
              offset: _coverOffset.value,
              child: Transform.scale(
                alignment: Alignment.bottomCenter,
                scale: _coverScale.value,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(_coverAngle.value),
                  alignment: FractionalOffset.bottomCenter,
                  child: coverCard,
                ),
              ),
            ),
            Transform.translate(
              offset: _offset.value,
              child: Transform.scale(
                alignment: Alignment.bottomCenter,
                scale: _scale.value,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(_newAngle.value),
                  alignment: FractionalOffset.bottomCenter,
                  child: card,
                ),
              ),
            ),
            Transform.translate(
              offset: offsetTween.evaluate(animation),
              child: Transform.rotate(
                angle: _oldAngle.value,
                child: card,
              ),
            ),
          ],
        );
      },
    );
  }
}
