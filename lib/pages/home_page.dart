import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/bloc/quiz_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Start Game'),
          onPressed: () {
            context.read<QuizBloc>().add(StartGamePressed());
          },
        ),
      ),
    );
  }
}
