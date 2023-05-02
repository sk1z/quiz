import 'package:flutter/material.dart';

class StageItem extends StatelessWidget {
  const StageItem(
      {super.key, this.text, this.image, this.onTap, this.correctAnswer})
      : assert(text != null || image != null);

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
      child = ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 140),
        child: Text(
          text!,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22),
        ),
      );
    } else {
      child = Image.asset('images/$image');
    }

    return ElevatedButton(
      style: style,
      onPressed: onTap,
      child: child,
    );
  }
}
