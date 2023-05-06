import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz/quiz.dart';

class ContinueButton extends StatefulWidget {
  const ContinueButton({super.key, required this.selectedAnswer});

  final int selectedAnswer;

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton>
    with TickerProviderStateMixin {
  late final AnimationController _translateController = AnimationController(
    vsync: this,
    value: widget.selectedAnswer > 0 ? 1 : 0,
    duration: Duration(milliseconds: 170),
  );
  late final Animation<double> _translateAnimation = CurvedAnimation(
    parent: _translateController,
    curve: Curves.easeOut,
  );
  final Animatable<Offset> _translate = Tween<Offset>(
    begin: Offset(0, 130),
    end: Offset.zero,
  );

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

  bool _tapCanceled = false;

  @override
  void didUpdateWidget(covariant ContinueButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedAnswer > 0) {
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
      scale: _scale.animate(_scaleAnimation),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: const Offset(1, 1),
              blurRadius: 1,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff33e84d),
              Color(0xff19d388),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          color: Color(0xff2add6c),
        ),
        child: const Center(child: text),
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 56),
      height: 50,
      child: AnimatedBuilder(
        animation: _translateController,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: _translate.evaluate(_translateAnimation),
            child: child,
          );
        },
        child: Draggable(
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
        ),
      ),
    );
  }
}
