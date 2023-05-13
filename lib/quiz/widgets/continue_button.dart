import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class ContinueButton extends StatefulWidget {
  const ContinueButton({super.key, required this.show});

  final bool show;

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton>
    with TickerProviderStateMixin {
  bool _tapCanceled = false;

  static final Animatable<Offset> _translateTween = Tween<Offset>(
    begin: const Offset(0, 80),
    end: Offset.zero,
  );
  static final Animatable<double> _scaleTween =
      Tween<double>(begin: 1, end: 0.9);

  late AnimationController _translateController;
  late Animation<double> _translateAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _translateController = AnimationController(
      value: widget.show ? 1 : 0,
      duration: const Duration(milliseconds: 170),
      vsync: this,
    );
    _translateAnimation = CurvedAnimation(
      parent: _translateController,
      curve: Curves.easeOut,
    );

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
    _translateController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ContinueButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show) {
      _translateController.forward();
    } else {
      _translateController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    const Widget text = Text(
      'Continue',
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
        shadows: [
          BoxShadow(
            color: Colors.green,
            offset: Offset(1, 1),
            blurRadius: 5,
          ),
        ],
      ),
    );

    final Widget button = ScaleTransition(
      scale: _scale,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(1, 1),
              blurRadius: 1,
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff33e84d),
              Color(0xff19d388),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xff2add6c),
        ),
        child: const Center(child: text),
      ),
    );

    final Widget child = Draggable(
      onDragStarted: () {
        _tapCanceled = false;
        _scaleController.forward();
      },
      onDragEnd: (DraggableDetails details) {
        if (!_tapCanceled) {
          context.read<QuizBloc>().add(ContinuePressed());
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
          return button;
        },
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 56),
      height: 50,
      child: AnimatedBuilder(
        animation: _translateController,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: _translateTween.evaluate(_translateAnimation),
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
