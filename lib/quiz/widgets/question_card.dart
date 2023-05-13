import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(
      {super.key, required this.question, required this.animation});

  final int question;
  final Animation<double> animation;

  static final Animatable<double> _disappearanceTween =
      CurveTween(curve: const Interval(0, 0.25));
  static final Animatable<double> _coverAngleIntervalTween =
      CurveTween(curve: const Interval(0.44, 0.7));
  static final Animatable<double> _newAngleIntervalTween =
      CurveTween(curve: const Interval(0.7, 1));

  static final Animatable<double> _oldAngleTween = Tween<double>(
    begin: 0,
    end: math.pi / 12.0,
  );
  static final Animatable<double> _coverAngleTween = Tween<double>(
    begin: 0,
    end: math.pi * 0.5,
  );
  static final Animatable<double> _newAngleTween = Tween<double>(
    begin: math.pi * -0.5,
    end: 0,
  );

  static final Animatable<double> _oldAngle =
      _oldAngleTween.chain(_disappearanceTween);
  static final Animatable<double> _coverAngle =
      _coverAngleTween.chain(_coverAngleIntervalTween);
  static final Animatable<double> _newAngle =
      _newAngleTween.chain(_newAngleIntervalTween);

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
    );
    final Animatable<Offset> offset = offsetTween.chain(_disappearanceTween);

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
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_coverAngle.evaluate(animation)),
              alignment: FractionalOffset.bottomCenter,
              child: coverCard,
            ),
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_newAngle.evaluate(animation)),
              alignment: FractionalOffset.bottomCenter,
              child: card,
            ),
            Transform.translate(
              offset: offset.evaluate(animation),
              child: Transform.rotate(
                angle: _oldAngle.evaluate(animation),
                child: card,
              ),
            ),
          ],
        );
      },
    );
  }
}
