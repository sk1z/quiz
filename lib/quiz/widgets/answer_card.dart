import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.height,
    this.text,
    this.image,
    this.onTap,
    this.correctAnswer,
  }) : assert(text != null || image != null);

  final double height;
  final String? text;
  final String? image;
  final VoidCallback? onTap;
  final bool? correctAnswer;

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    BorderSide? side;
    if (correctAnswer != null) {
      if (correctAnswer!) {
        backgroundColor = Color(0xffffaf00);
        side = const BorderSide(color: Color(0xffd38d00));
      } else {
        backgroundColor = const Color(0xffec0b43);
        side = const BorderSide(color: Color(0xffec0b43));
      }
    }

    final ButtonStyle style = ElevatedButton.styleFrom(
      padding: image != null ? const EdgeInsets.all(4) : null,
      backgroundColor: backgroundColor ?? const Color(0xff00b4fe),
      textStyle: const TextStyle(fontSize: 18),
      side: side ?? const BorderSide(color: Color(0xff0b87b9)),
    );

    final Widget child;

    if (text != null) {
      child = Text(
        text!,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22),
      );
    } else {
      child = Image.asset('images/$image');
    }

    return SizedBox(
      height: height,
      child: Container(
        // color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ElevatedButton(
            style: style,
            onPressed: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}
