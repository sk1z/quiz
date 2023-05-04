import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_game/quiz/quiz_questions.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

int _questionCount = 20;
int answerSeconds = 10;
int animationTime = 700;

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(const QuizState()) {
    on<StartGamePressed>(_startGamePressed);
    on<AnswerSelected>(_onAnswerSelected);
    on<TimeOver>(_timeOver);
    on<RestartButtonPressed>(_RestartButtonPressed);
    on<ContinuePressed>(_continuePressed);

    // _questionCount = 3;
    // answerSeconds = 3;
  }

  Timer? _timer;

  void _startGamePressed(StartGamePressed event, Emitter<QuizState> emit) {
    final List<int> numbers = [
      for (int i = 0; i < quizQuestions.length; i++) i
    ];
    final List<int> questions = [];

    final Random random = Random();
    for (int i = 0; i < _questionCount; i++) {
      final int number = random.nextInt(numbers.length);
      questions.add(numbers[number]);
      numbers.removeAt(number);
    }

    _setTimer();

    emit(QuizState(
      round: 0,
      questions: questions,
    ));
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<QuizState> emit) {
    _timer?.cancel();

    final int answer = event.answer;

    int correct = state.score;

    if (answer == quizQuestions[state.questions[state.round]].answer) {
      correct++;
    }

    emit(state.copyWith(
      score: correct,
      answer: answer,
    ));
  }

  void _timeOver(TimeOver event, Emitter<QuizState> emit) {
    _timer?.cancel();

    int answer = state.answer;

    if (answer == 0) {
      answer = quizQuestions[state.questions[state.round]].answer;
    }

    emit(state.copyWith(answer: answer));
  }

  void _continuePressed(ContinuePressed event, Emitter<QuizState> emit) {
    int round = state.round;

    if (round < state.questions.length - 1) {
      round++;
      Future.delayed(Duration(milliseconds: animationTime), () {
        _setTimer();
      });
    } else {
      round = -2;
    }

    emit(state.copyWith(
      round: round,
      answer: 0,
    ));
  }

  void _RestartButtonPressed(
      RestartButtonPressed event, Emitter<QuizState> emit) {
    _timer?.cancel();

    emit(state.copyWith(
      round: -1,
      score: 0,
    ));
  }

  void _setTimer() {
    _timer = Timer(Duration(seconds: answerSeconds), () {
      add(TimeOver());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
