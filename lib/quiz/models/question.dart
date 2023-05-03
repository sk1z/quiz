import 'package:quiz_game/quiz/models/models.dart';

class Question {
  const Question({
    this.type = QuestionType.text,
    required this.question,
    required this.answers,
    required this.answer,
  });

  final QuestionType type;
  final String question;
  final List<Answer> answers;
  final int answer;
}
