part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  const QuizState({
    this.stage = -1,
    this.score = 0,
    this.timeLeft = 0,
    this.stages = const [],
    this.answersShown = false,
    this.health = 3,
  });

  final int stage;
  final int score;
  final int timeLeft;
  final List<Stage> stages;
  final bool answersShown;
  final int health;

  QuizState copyWith({
    int? stage,
    int? score,
    int? timeLeft,
    List<Stage>? stages,
    bool? answersShown,
    int? health,
  }) =>
      QuizState(
        stage: stage ?? this.stage,
        score: score ?? this.score,
        timeLeft: timeLeft ?? this.timeLeft,
        stages: stages ?? this.stages,
        answersShown: answersShown ?? this.answersShown,
        health: health ?? this.health,
      );

  @override
  List<Object?> get props => [
        stage,
        score,
        timeLeft,
        stages,
        answersShown,
        health,
      ];
}
