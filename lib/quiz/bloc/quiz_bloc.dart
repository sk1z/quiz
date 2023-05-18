import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_game/quiz/quiz.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(const QuizState()) {
    on<StartGamePressed>(_startGamePressed);
    on<AnswerSelected>(_onAnswerSelected);
    on<ContinuePressed>(_continuePressed);
    on<TimeOver>(_timeOver);
    on<RestartPressed>(_restartPressed);
  }

  void _startGamePressed(StartGamePressed event, Emitter<QuizState> emit) {
    final List<int> numbers = [
      for (int i = 0; i < quizQuestions.length; i++) i
    ];
    final List<int> questions = [];

    // numbers.removeWhere((int number) {
    //   return quizQuestions[number].type == QuestionType.image;
    // });

    // numbers.removeWhere((int number) {
    //   final String question = quizQuestions[number].question;

    //   return !question.contains('Carlsen') &&
    //       !question.contains('Moon') &&
    //       !question.contains('Jordan');
    // });

    final int count = min(20, numbers.length);

    final Random random = Random();
    for (int i = 0; i < count; i++) {
      final int number = random.nextInt(numbers.length);
      questions.add(numbers[number]);
      numbers.removeAt(number);
    }

    // questions.sort();

    emit(QuizState(
      round: 0,
      questions: questions,
    ));
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<QuizState> emit) {
    final int answer = event.answer;

    int score = state.score;

    if (answer == quizQuestions[state.questions[state.round]].answer) {
      score++;
    }

    emit(state.copyWith(
      score: score,
      answer: answer,
    ));
  }

  void _continuePressed(ContinuePressed event, Emitter<QuizState> emit) {
    int round = state.round;

    if (round < state.questions.length - 1) {
      round++;
    } else {
      round = -2;
    }

    emit(state.copyWith(
      round: round,
      answer: 0,
    ));
  }

  void _timeOver(TimeOver event, Emitter<QuizState> emit) {
    if (state.round < 0) return;

    int answer = state.answer;

    if (answer == 0) {
      answer = quizQuestions[state.questions[state.round]].answer;
    }

    emit(state.copyWith(answer: answer));
  }

  void _restartPressed(RestartPressed event, Emitter<QuizState> emit) {
    emit(state.copyWith(round: -1));
  }
}
