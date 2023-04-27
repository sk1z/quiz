import 'package:flutter/material.dart';

class StageItem extends StatelessWidget {
  const StageItem({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 150),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
