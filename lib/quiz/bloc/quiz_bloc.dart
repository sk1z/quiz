import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_game/quiz/quiz_questions.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

const int _questionCount = 20;

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(const QuizState()) {
    on<StartGamePressed>(_startGamePressed);
    on<AnswerSelected>(_onAnswerSelected);
    on<TimeOver>(_timeOver);
    on<MainMenuPressed>(_mainMenuPressed);
    on<ChangeShowingAnswers>(_changeShowingAnswers);
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
      questionNumber: 0,
      questions: questions,
    ));
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<QuizState> emit) {
    _timer?.cancel();

    final int answer = event.answer;

    int score = state.score;
    int health = state.health;

    if (answer == quizQuestions[state.questions[state.questionNumber]].answer) {
      score += 100;
    } else {
      health--;
    }

    int stage = state.questionNumber;

    if (stage < state.questions.length - 1 && health >= 0) {
      stage++;
      _setTimer();
    } else {
      stage = -2;
    }

    emit(state.copyWith(
      questionNumber: stage,
      score: score,
      health: health,
    ));
  }

  void _timeOver(TimeOver event, Emitter<QuizState> emit) {
    _timer?.cancel();

    final int health = state.health - 1;

    int stage = state.questionNumber;

    if (stage < state.questions.length - 1 && health >= 0) {
      stage++;
      _setTimer();
    } else {
      stage = -2;
    }

    emit(state.copyWith(questionNumber: stage, health: health));
  }

  void _mainMenuPressed(MainMenuPressed event, Emitter<QuizState> emit) {
    emit(state.copyWith(questionNumber: -1, score: 0));
  }

  void _changeShowingAnswers(
      ChangeShowingAnswers event, Emitter<QuizState> emit) {
    emit(state.copyWith(answersShown: !state.answersShown));
  }

  void _setTimer() {
    // _timer = Timer(const Duration(seconds: 10), () {
    //   add(TimeOver());
    // });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
