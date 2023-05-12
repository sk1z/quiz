import 'package:flutter/material.dart';
import 'package:quiz_game/quiz/models/models.dart';

class AnswerCard extends StatefulWidget {
  const AnswerCard({
    super.key,
    required this.type,
    required this.answer,
    this.onTap,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.animation,
    required this.number,
    required this.width,
    required this.horizontalPadding,
  });

  final QuestionType type;
  final String answer;
  final VoidCallback? onTap;
  final int selectedAnswer;
  final int correctAnswer;
  final Animation animation;
  final int number;
  final double width;
  final double horizontalPadding;

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard>
    with SingleTickerProviderStateMixin {
  bool _tapActive = false;
  bool _tapCanceled = false;

  static final Animatable<double> _slideIntervalTween =
      CurveTween(curve: Interval(0.44, 1, curve: Curves.easeOut));
  late Animatable<Offset> _slideTween;
  static final Animatable<double> _scaleTween =
      Tween<double>(begin: 1, end: 0.9);

  late Animation<Offset> _slide;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    final bool isOdd = widget.number % 2 != 0;
    final int shift = isOdd ? -1 : 1;

    _slideTween = Tween<Offset>(
      begin: Offset(shift + shift * widget.horizontalPadding / widget.width, 0),
      end: Offset.zero,
    );
    _slide = widget.animation.drive(_slideTween.chain(_slideIntervalTween));

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: const Cubic(0.175, 0.885, 0.32, 2),
      reverseCurve: const Cubic(0.5, -0.5, 0.825, -0.2),
    );
    _scale = _scaleAnimation.drive(_scaleTween);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

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

    if (widget.type == QuestionType.text) {
      content = Text(
        widget.answer,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      );
    } else {
      content = Image.asset('images/${widget.answer}');
    }

    final Widget card = ScaleTransition(
      scale: _scale,
      child: TweenAnimationBuilder(
        tween: ColorTween(end: backgroundColor),
        duration: const Duration(milliseconds: 100),
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

    final Widget child = Draggable(
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
    );

    if (widget.animation.value < 0.44) return child;

    return SlideTransition(
      position: _slide,
      child: child,
    );
  }
}
