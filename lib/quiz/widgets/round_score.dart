import 'package:flutter/material.dart';

class RoundScore extends StatelessWidget {
  const RoundScore({super.key, required this.text, this.width});

  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: Colors.white,
      child: Container(
        width: width,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: Color(0xff3437a3),
          ),
        ),
      ),
    );
  }
}
