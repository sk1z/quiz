part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class StartGamePressed extends QuizEvent {}

class AnswerSelected extends QuizEvent {
  const AnswerSelected(this.answer);

  final int answer;

  @override
  List<Object> get props => [answer];
}

class ContinuePressed extends QuizEvent {}

class TimeOver extends QuizEvent {}

class RestartPressed extends QuizEvent {}
