import 'package:flutter/material.dart';

class QuizScore extends StatelessWidget {
  const QuizScore({super.key, required this.text, this.width});

  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: Colors.white,
      child: SizedBox(
        width: width,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: Color(0xff3437a3),
            ),
          ),
        ),
      ),
    );
  }
}
