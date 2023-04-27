part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  const QuizState({
    this.stage = -1,
    this.correctAnswerCount = 0,
    this.timeLeft = 0,
    this.stages = const [],
  });

  final int stage;
  final int correctAnswerCount;

  final int timeLeft;
  final List<Stage> stages;

  QuizState copyWith({
    int? stage,
    int? correctAnswerCount,
    int? timeLeft,
    List<Stage>? stages,
  }) =>
      QuizState(
        stage: stage ?? this.stage,
        correctAnswerCount: correctAnswerCount ?? this.correctAnswerCount,
        timeLeft: timeLeft ?? this.timeLeft,
        stages: stages ?? this.stages,
      );

  @override
  List<Object?> get props => [stage, correctAnswerCount, timeLeft, stages];
}
