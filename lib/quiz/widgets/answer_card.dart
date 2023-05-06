import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/models/models.dart';

class AnswerCard extends StatefulWidget {
  const AnswerCard({
    super.key,
    required this.height,
    required this.type,
    required this.answer,
    this.onTap,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.number,
    required this.animation,
    required this.maxWidth,
    required this.answerCount,
  });

  final double height;
  final QuestionType type;
  final String answer;
  final VoidCallback? onTap;
  final int selectedAnswer;
  final int correctAnswer;
  final int number;
  final Animation animation;
  final double maxWidth;
  final int answerCount;

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> with TickerProviderStateMixin {
  late final AnimationController _scaleController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 250),
  );
  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _scaleController,
    curve: Cubic(0.175, 0.885, 0.32, 2),
    reverseCurve: Cubic(0.5, -0.5, 0.825, -0.2),
  );
  final Animatable<double> _scale = Tween<double>(
    begin: 1,
    end: 0.9,
  );

  bool _tapActive = false;
  bool _tapCanceled = false;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xff3238a6);

    if (_tapActive) {
      backgroundColor = const Color(0xff0426a4);
    }
    if (widget.selectedAnswer > 0) {
      if (widget.number == widget.correctAnswer) {
        if (_tapActive) {
          backgroundColor = Color(0xff02903a);
        } else {
          backgroundColor = Color(0xff26cf3e);
        }
      } else if (widget.number == widget.selectedAnswer) {
        if (_tapActive) {
          backgroundColor = const Color(0xff152271);
        } else {
          backgroundColor = const Color(0xffd72f6d);
        }
      }
    }

    final Widget content;

    final CurveTween _space =
        CurveTween(curve: Interval(0.44, 1, curve: Curves.easeOut));

    if (widget.type == QuestionType.text) {
      content = Text(
        widget.answer,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          shadows: [
            // BoxShadow(
            //   color: Colors.white38,
            //   offset: Offset(0.5, 0.5),
            //   blurRadius: 2,
            // ),
          ],
        ),
      );
    } else {
      content = Image.asset('images/${widget.answer}');
    }

    bool isOdd = widget.number % 2 != 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      height: widget.height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Animatable<Offset> _transition;

          _transition = Tween<Offset>(
            begin: Offset(
                (isOdd ? -1 : 1) + (isOdd ? -1 : 1) * 20 / constraints.maxWidth,
                0),
            end: Offset.zero,
          );

          final Animation<Offset> position =
              widget.animation.drive(_transition.chain(_space));

          final Widget card = AnimatedBuilder(
            animation: _scaleController,
            builder: (BuildContext context, Widget? child) {
              return ScaleTransition(
                scale: _scale.animate(_scaleAnimation),
                child: child,
              );
            },
            child: TweenAnimationBuilder(
              tween: ColorTween(end: backgroundColor),
              duration: Duration(milliseconds: 100),
              builder: (BuildContext context, Color? color, Widget? child) {
                return Card(
                  margin: EdgeInsets.zero,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  color: color,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(child: child),
                  ),
                );
              },
              child: content,
            ),
          );

          return AnimatedBuilder(
            animation: widget.animation,
            builder: (BuildContext context, Widget? child) {
              if (widget.animation.value < 0.44) return child!;

              return SlideTransition(
                position: position,
                child: child,
              );
            },
            child: true
                ? Container(
                    child: false
                        ? GestureDetector(
                            onTapDown: (details) {},
                            onTapCancel: () {},
                            onTapUp: (details) {},
                            onPanUpdate: (details) {},
                            onPanEnd: (details) {},
                            child: Container(
                              color: Colors.white,
                              child: content,
                            ),
                          )
                        : Draggable(
                            onDragStarted: () {
                              _tapActive = true;
                              setState(() {});
                              _tapCanceled = false;
                              _scaleController.forward();
                            },
                            onDragEnd: (DraggableDetails details) {
                              _tapActive = false;
                              setState(() {});
                              if (!_tapCanceled && widget.selectedAnswer == 0) {
                                widget.onTap?.call();
                              }
                              _scaleController.reverse();
                            },
                            feedback: const SizedBox.shrink(),
                            child: DragTarget(
                              onLeave: (Object? data) {
                                _tapCanceled = true;
                                _scaleController.reverse();
                              },
                              builder: (
                                BuildContext context,
                                List<Object?> candidateData,
                                List<dynamic> rejectedData,
                              ) {
                                return card;
                              },
                            ),
                          ),
                  )
                : ElevatedButton(
                    onPressed: widget.selectedAnswer == 0 ? widget.onTap : null,
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      backgroundColor: backgroundColor,
                      disabledBackgroundColor: backgroundColor,
                      disabledForegroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: content,
                  ),
          );
        },
      ),
    );
  }
}
