import 'dart:math' as math;

import 'package:flutter/material.dart';

const Duration _duration = const Duration(seconds: 10);

const Curve _curve = Curves.linear;

class QuestionTimer extends StatefulWidget {
  const QuestionTimer({super.key, required this.questionNumber});

  final int questionNumber;

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
    if (widget.questionNumber != oldWidget.questionNumber) {
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
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              width: 70,
              height: 70,
              alignment: Alignment.center,
              child: Text(
                '${(_animation.value * 10).ceil()}',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Color(0xff63828c),
                ),
              ),
            ),
            SizedBox(
              width: 60,
              height: 60,
              child: Transform.rotate(
                angle: math.pi,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Color(0xff7acb01),
                  backgroundColor: Color(0xff3098ff),
                  value: _animation.value,
                ),
              ),
            ),
          ],
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
