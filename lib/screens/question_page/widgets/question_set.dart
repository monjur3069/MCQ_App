class QuestionSet {
  String question;
  List<dynamic> options;
  dynamic rightAnswer;
  dynamic givenAnswer;
  String? groupValue;


  @override
  String toString() {
    return 'QuestionSet{question: $question, options: $options, rightAnswer: $rightAnswer, givenAnswer: $givenAnswer}';
  }

  QuestionSet(
      {required this.question, required this.options, required this.rightAnswer, required this.givenAnswer,this.groupValue});
}
List<QuestionSet> questionList = [];