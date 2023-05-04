import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(
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
                ..color = Color(0xffb85263),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 5
                ..color = Color(0xfffea50d),
            ),
          ),
          Text(text),
        ],
      ),
    );
  }
}
