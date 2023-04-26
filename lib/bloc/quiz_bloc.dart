import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizState(answerCount: quiz.length)) {
    on<StartGamePressed>(_startGamePressed);
    on<AnswerSelected>(_onAnswerSelected);
    on<MainMenuPressed>(_mainMenuPressed);
  }

  void _startGamePressed(StartGamePressed event, Emitter<QuizState> emit) {
    emit(QuizState(answerCount: quiz.length, stage: 0));
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<QuizState> emit) {
    final int answer = event.answer;

    int correctAnswerCount = state.correctAnswerCount;

    if (answer == quiz[state.stage].answer) {
      correctAnswerCount++;
    }

    int stage = state.stage;

    if (stage < quiz.length - 1) {
      stage++;
    } else {
      stage = -2;
    }

    emit(QuizState(
      answerCount: quiz.length,
      stage: stage,
      correctAnswerCount: correctAnswerCount,
    ));
  }

  void _mainMenuPressed(MainMenuPressed event, Emitter<QuizState> emit) {
    emit(QuizState(answerCount: quiz.length, stage: -1));
  }
}

const List<Stage> quiz = [
  Stage(
    question: 'Which country has won the most World Cups? (Brazil)',
    answers: [
      Answer(1, 'Argentina'),
      Answer(2, 'France'),
      Answer(3, 'Brazil'),
      Answer(4, 'Netherlands'),
    ],
    answer: 3,
  ),
  Stage(
    question: 'Ronaldo is synonymous with the No.7, '
        'but what other number did he wear at Real Madrid? (9)',
    answers: [
      Answer(1, '2'),
      Answer(2, '3'),
      Answer(3, '5'),
      Answer(4, '9'),
    ],
    answer: 4,
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
