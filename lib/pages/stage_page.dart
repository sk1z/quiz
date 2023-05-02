import 'package:flutter/material.dart';
import 'package:quiz_game/pages/pages.dart';

class StagePage extends StatelessWidget {
  const StagePage({super.key, required this.stage});

  final int stage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StageForm(stage: stage),
      ),
    );
  }
}
