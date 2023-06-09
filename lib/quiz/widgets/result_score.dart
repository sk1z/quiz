import 'package:flutter/material.dart';

class ResultScore extends StatelessWidget {
  const ResultScore({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Text(
            text,
            style: TextStyle(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 7
                ..color = const Color(0xffb85263),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 5
                ..color = const Color(0xfffea50d),
            ),
          ),
          Text(text),
        ],
      ),
    );
  }
}
