class Question {
  final String question;
  final List<String> answerOptions;

  Question({required this.question, required this.answerOptions});
}

class Quiz {
  final List<Question> questions;

  Quiz({required this.questions});
}
