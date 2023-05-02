import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_game/quiz_questions.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

const int _questionCount = 20;
const int _answerTime = 10;

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(const QuizState()) {
    on<StartGamePressed>(_startGamePressed);
    on<AnswerSelected>(_onAnswerSelected);
    on<TimeChanged>(_timeChanged);
    on<MainMenuPressed>(_mainMenuPressed);
    on<ChangeShowingAnswers>(_changeShowingAnswers);
  }

  Timer? _timer;

  void _startGamePressed(StartGamePressed event, Emitter<QuizState> emit) {
    final List<int> numbers = [for (int i = 0; i < quiz.length; i++) i];
    final List<Stage> stages = [];

    final Random random = Random();
    for (int i = 0; i < _questionCount; i++) {
      final int number = random.nextInt(numbers.length);
      stages.add(quiz[numbers[number]]);
      numbers.removeAt(number);
    }

    _setTimer();

    emit(QuizState(
      stage: 0,
      timeLeft: _answerTime,
      stages: stages,
    ));
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<QuizState> emit) {
    final int answer = event.answer;

    int correctAnswerCount = state.score;
    int health = state.health;

    if (answer == state.stages[state.stage].answer) {
      correctAnswerCount += 100;
    } else {
      health--;
    }

    int stage = state.stage;

    if (stage < state.stages.length - 1 && health >= 0) {
      stage++;
      _setTimer();
    } else {
      _timer?.cancel();
      stage = -2;
    }

    emit(state.copyWith(
      stage: stage,
      score: correctAnswerCount,
      health: health,
      timeLeft: _answerTime,
    ));
  }

  void _timeChanged(TimeChanged event, Emitter<QuizState> emit) {
    int timeLeft = state.timeLeft;
    if (state.timeLeft > 1) {
      timeLeft--;
      emit(state.copyWith(timeLeft: timeLeft));
    } else {
      _timer?.cancel();

      int health = state.health;
      health--;

      int stage = state.stage;

      int? timeLeft;

      if (stage < state.stages.length - 1 && health >= 0) {
        stage++;
        timeLeft = _answerTime;
        _setTimer();
      } else {
        _timer?.cancel();
        stage = -2;
      }

      emit(state.copyWith(stage: stage, health: health, timeLeft: timeLeft));
    }
  }

  void _mainMenuPressed(MainMenuPressed event, Emitter<QuizState> emit) {
    emit(state.copyWith(stage: -1, score: 0));
  }

  void _changeShowingAnswers(
      ChangeShowingAnswers event, Emitter<QuizState> emit) {
    emit(state.copyWith(answersShown: !state.answersShown));
  }

  void _setTimer() {
    _timer?.cancel();
    // _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
    //   add(TimeChanged());
    // });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

enum StageType { text, image }

class Stage {
  const Stage({
    this.type = StageType.text,
    required this.question,
    required this.answers,
    required this.answer,
  });

  final StageType type;
  final String question;
  final List<Answer> answers;
  final int answer;
}

class Answer {
  const Answer(this.number, this.answer);

  final int number;
  final String answer;
}
