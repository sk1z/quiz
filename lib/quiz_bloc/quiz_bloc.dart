import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(const QuizState()) {
    on<StartGamePressed>(_startGamePressed);
    on<AnswerSelected>(_onAnswerSelected);
    on<TimeChanged>(_timeChanged);
    on<MainMenuPressed>(_mainMenuPressed);
  }

  Timer? _timer;

  void _startGamePressed(StartGamePressed event, Emitter<QuizState> emit) {
    final List<int> numbers = [for (int i = 0; i < quiz.length; i++) i];
    final List<Stage> stages = [];

    final Random random = Random();
    for (int i = 0; i < 5; i++) {
      final int number = random.nextInt(numbers.length);
      stages.add(quiz[numbers[number]]);
      numbers.removeAt(number);
    }

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      add(TimeChanged());
    });
    emit(QuizState(
      stage: 0,
      timeLeft: stages.length * 15,
      stages: stages,
    ));
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<QuizState> emit) {
    final int answer = event.answer;

    int correctAnswerCount = state.correctAnswerCount;

    if (answer == state.stages[state.stage].answer) {
      correctAnswerCount++;
    }

    int stage = state.stage;

    if (stage < state.stages.length - 1) {
      stage++;
    } else {
      _timer?.cancel();
      stage = -2;
    }

    emit(state.copyWith(
      stage: stage,
      correctAnswerCount: correctAnswerCount,
    ));
  }

  void _timeChanged(TimeChanged event, Emitter<QuizState> emit) {
    int timeLeft = state.timeLeft;
    if (state.timeLeft > 1) {
      timeLeft--;
      emit(state.copyWith(timeLeft: timeLeft));
    } else {
      _timer?.cancel();
      emit(state.copyWith(stage: -2));
    }
  }

  void _mainMenuPressed(MainMenuPressed event, Emitter<QuizState> emit) {
    emit(state.copyWith(stage: -1, correctAnswerCount: 0));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

const List<Stage> quiz = [
  Stage(
    question: 'Which Country won the most FIFA World Cups? (3)',
    answers: [
      Answer(1, 'Germany'),
      Answer(2, 'Argentina'),
      Answer(3, 'Brazil'),
      Answer(4, 'France'),
    ],
    answer: 3,
  ),
  Stage(
    question: 'Which Country won the first FIFA World Cup? (2)',
    answers: [
      Answer(1, 'Argentina'),
      Answer(2, 'Uruguay'),
      Answer(3, 'Italy'),
      Answer(4, 'Brazil'),
    ],
    answer: 2,
  ),
  Stage(
    question: 'Who is known as the Flying Sikh? (3)',
    answers: [
      Answer(1, 'Michael Johnson'),
      Answer(2, 'Usain Bolt'),
      Answer(3, 'Milkha Sing'),
      Answer(4, 'Carl Lewis'),
    ],
    answer: 3,
  ),
  Stage(
    question: 'Who is known as “The Baltimore Bullet”? (3)',
    answers: [
      Answer(1, 'Roger Federer'),
      Answer(2, 'Usain Bolt'),
      Answer(3, 'Michael Phelps'),
      Answer(4, 'Michael Jordan'),
    ],
    answer: 3,
  ),
  Stage(
    question: 'Where is Magnus Carlsen from? (3)',
    answers: [
      Answer(1, 'England'),
      Answer(2, 'UK'),
      Answer(3, 'Norway'),
      Answer(4, 'Germany'),
    ],
    answer: 3,
  ),
  Stage(
    question: 'Where did Snooker Game Originate from? (3)',
    answers: [
      Answer(1, 'Austria'),
      Answer(2, 'England'),
      Answer(3, 'India'),
      Answer(4, 'Wales'),
    ],
    answer: 3,
  ),
  Stage(
    question: 'Which was the first Sport played on the Moon? (1)',
    answers: [
      Answer(1, 'Golf'),
      Answer(2, 'Tennis'),
      Answer(3, 'Badminton'),
      Answer(4, 'Archery'),
    ],
    answer: 1,
  ),
  Stage(
    question: 'Where was the first Commonwealth Games held? (1)',
    answers: [
      Answer(1, 'Canada'),
      Answer(2, 'USA'),
      Answer(3, 'Mexico'),
      Answer(4, 'Chile'),
    ],
    answer: 1,
  ),
  Stage(
    question: 'Which Sport has the Term “Butterfly Stroke”? (3)',
    answers: [
      Answer(1, 'Table Tennis'),
      Answer(2, 'Boating'),
      Answer(3, 'Swiming'),
      Answer(4, 'MotoGP'),
    ],
    answer: 3,
  ),
  Stage(
    question: 'When did Michael Jordan retire? (2)',
    answers: [
      Answer(1, '2004'),
      Answer(2, '2003'),
      Answer(3, '2005'),
      Answer(4, '2013'),
    ],
    answer: 2,
  ),
];

class Stage {
  const Stage(
      {required this.question, required this.answers, required this.answer});

  final String question;
  final List<Answer> answers;
  final int answer;
}

class Answer {
  const Answer(this.number, this.answer);

  final int number;
  final String answer;
}
