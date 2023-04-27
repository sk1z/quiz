import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/quiz_bloc/quiz_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            child: const Text('Start Game'),
            onPressed: () {
              context.read<QuizBloc>().add(StartGamePressed());
            },
          ),
        ),
      ),
    );
  }
}
