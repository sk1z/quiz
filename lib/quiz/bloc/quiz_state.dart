part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  const QuizState({
    this.round = -1,
    this.questions = const [],
    this.score = 0,
    this.answer = 0,
  });

  final int round;
  final List<int> questions;
  final int score;
  final int answer;

  QuizState copyWith({
    int? round,
    List<int>? questions,
    int? score,
    int? answer,
  }) =>
      QuizState(
        round: round ?? this.round,
        questions: questions ?? this.questions,
        score: score ?? this.score,
        answer: answer ?? this.answer,
      );

  @override
  List<Object?> get props => [round, questions, score, answer];
}
