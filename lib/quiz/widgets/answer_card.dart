import 'dart:ui';

import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.height,
    this.text,
    this.image,
    this.onTap,
    required this.answer,
    required this.correctAnswer,
    required this.number,
    required this.animation,
    required this.maxWidth,
    required this.answerCount,
  }) : assert(text != null || image != null);

  final double height;
  final String? text;
  final String? image;
  final VoidCallback? onTap;
  final int answer;
  final int correctAnswer;
  final int number;
  final Animation animation;
  final double maxWidth;
  final int answerCount;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xff00b4fe);

    if (answer > 0) {
      if (number == correctAnswer) {
        backgroundColor = Color(0xff25d43b);
      } else if (number == answer) {
        backgroundColor = const Color(0xffec0b43);
      }
    }

    final Widget child;

    final double unit = 1 / answerCount;

    final double start = (number - 1) * unit * 0.3;
    final double end = (start + 3.1 * unit).clamp(0.0, 1.0);

    // print('$number  ${lerpDouble(0.5, 1, start)}');
    // print('$number  ${lerpDouble(0.5, 1, end)}');

    final CurveTween _textTransition = CurveTween(
      curve: Interval(
        lerpDouble(0.5, 1, start)!,
        lerpDouble(0.5, 1, end)!,
      ),
    );

    final CurveTween _space = CurveTween(curve: Interval(0.5, 1));

    if (text != null) {
      child = Text(
        text!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          shadows: [
            BoxShadow(
              color: Colors.white54,
              offset: Offset(0.5, 0.5),
              blurRadius: 5,
            ),
          ],
        ),
      );
    } else {
      child = Image.asset('images/$image');
    }

    bool isOdd = number % 2 != 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      height: height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Animatable<Offset> _transition;
          if (text != null) {
            _transition = Tween<Offset>(
              begin: Offset(1 + 20 / constraints.maxWidth, 0),
              end: Offset.zero,
            );
          } else {
            _transition = Tween<Offset>(
              begin: Offset(
                  (isOdd ? -1 : 1) +
                      (isOdd ? -1 : 1) * 20 / constraints.maxWidth,
                  0),
              end: Offset.zero,
            );
          }

          final Animation<Offset> position = animation.drive(
              _transition.chain(text != null ? _textTransition : _space));

          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              if (animation.value <= 0.5) return child!;

              if (text != null) return child!;

              return SlideTransition(
                position: position,
                child: child,
              );
            },
            child: ElevatedButton(
              onPressed: answer == 0 ? onTap : null,
              style: ElevatedButton.styleFrom(
                padding: image != null ? const EdgeInsets.all(4) : null,
                backgroundColor: backgroundColor,
                disabledBackgroundColor: backgroundColor,
                disabledForegroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(text != null ? 24 : 12),
                ),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
