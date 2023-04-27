part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  const QuizState({
    this.stage = -1,
    this.correctAnswerCount = 0,
    required this.answerCount,
  });

  final int stage;
  final int correctAnswerCount;
  final int answerCount;

  @override
  List<Object?> get props => [stage, correctAnswerCount, answerCount];
}
