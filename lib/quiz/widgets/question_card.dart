import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/quiz.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(
      {super.key, required this.question, required this.animation});

  final int question;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final String question = quizQuestions[this.question].question;

    final Widget card = Card(
      margin: EdgeInsets.symmetric(horizontal: 18),
      color: Color(0xfff5fcfe),
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

    final double _screenWidth = MediaQuery.of(context).size.width;

    final CurveTween _dissapearingTween = CurveTween(curve: Interval(0, 0.25));
    final Animatable<Offset> _translateAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(_screenWidth - 10, 0));
    final Animatable<double> _rotateAnimation = Tween<double>(
      begin: 0,
      end: math.pi / 12.0,
    );
    final Animatable<Offset> _translate =
        _translateAnimation.chain(_dissapearingTween);
    final Animatable<double> _rotate =
        _rotateAnimation.chain(_dissapearingTween);

    final CurveTween _rotateOldTween = CurveTween(curve: Interval(0.44, 0.7));
    final CurveTween _rotateNewTween = CurveTween(curve: Interval(0.7, 1));
    final Animatable<double> _rotateOldAnimation = Tween<double>(
      begin: 0,
      end: math.pi * 0.5,
    );
    final Animatable<double> _rotateNewAnimation = Tween<double>(
      begin: math.pi * -0.5,
      end: 0,
    );
    final Animatable<double> _ratiateOld =
        _rotateOldAnimation.chain(_rotateOldTween);
    final Animatable<double> _ratiateNew =
        _rotateNewAnimation.chain(_rotateNewTween);

    final Widget quizCard = Card(
      margin: EdgeInsets.symmetric(horizontal: 18),
      color: Color(0xff252b30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 100,
        alignment: Alignment.center,
        child: Text(
          'Quiz Game',
          textAlign: TextAlign.center,
          style: const TextStyle(
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
                ..rotateY(_ratiateOld.evaluate(animation)),
              alignment: FractionalOffset.center,
              child: quizCard,
            ),
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_ratiateNew.evaluate(animation)),
              alignment: FractionalOffset.center,
              child: card,
            ),
            Transform.translate(
              offset: _translate.evaluate(animation),
              child: Transform.rotate(
                angle: _rotate.evaluate(animation),
                child: card,
              ),
            ),
            // Transform.translate(
            //   offset: Offset(-10, 0),
            //   child: Transform(
            //     transform: Matrix4(
            //       1, 0, 0, 0.001,
            //       //
            //       0, 1, 0, 0,
            //       //
            //       0, 0, 1, 0,
            //       //
            //       0, 0, 0, 1,
            //     )
            //       ..scale(.9)
            //       ..rotateY(math.pi * 0.2),
            //     alignment: FractionalOffset.center,
            //     child: card,
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
