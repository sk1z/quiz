import 'dart:async';

import 'package:flutter/material.dart';

class StageTimer extends StatefulWidget {
  @override
  State<StageTimer> createState() => _StageTimerState();
}

class _StageTimerState extends State<StageTimer> {
  int totalSecs = 10000;
  int secsRemaining = 10000;
  double progressFraction = 0.0;
  int percentage = 0;
  late final Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 1), (_) {
      if (secsRemaining == 0) {
        return;
      }
      setState(() {
        secsRemaining -= 1;
        progressFraction = (totalSecs - secsRemaining) / totalSecs;
        percentage = (progressFraction * 100).floor();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text('$secsRemaining seconds remaining'),
        SizedBox(height: 20),
        CircularProgressIndicator(
          value: progressFraction,
        ),
        SizedBox(height: 20),
        Text('$percentage% complete'),
      ],
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
