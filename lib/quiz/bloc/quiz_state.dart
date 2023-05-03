part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  const QuizState({
    this.questionNumber = -1,
    this.questions = const [],
    this.score = 0,
    this.health = 3,
    this.answersShown = false,
  });

  final int questionNumber;
  final List<int> questions;
  final int score;
  final int health;
  final bool answersShown;

  QuizState copyWith({
    int? questionNumber,
    List<int>? questions,
    int? score,
    bool? answersShown,
    int? health,
  }) =>
      QuizState(
        questionNumber: questionNumber ?? this.questionNumber,
        questions: questions ?? this.questions,
        score: score ?? this.score,
        health: health ?? this.health,
        answersShown: answersShown ?? this.answersShown,
      );

  @override
  List<Object?> get props =>
      [questionNumber, questions, score, health, answersShown];
}
