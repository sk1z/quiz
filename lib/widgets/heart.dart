import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Heart extends StatelessWidget {
  const Heart({super.key, required this.solid});

  final bool solid;

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    final Color color;
    if (solid) {
      icon = FontAwesomeIcons.solidHeart;
      color = Colors.red;
    } else {
      icon = FontAwesomeIcons.heart;
      color = Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        icon,
        size: 30,
        color: color,
      ),
    );
  }
}
