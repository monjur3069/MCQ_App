class QuestionListModel {
  List<Questions>? questions;

  QuestionListModel({this.questions});

  QuestionListModel.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? question;
  Answers? answers;
  String? questionImageUrl;
  String? correctAnswer;
  int? score;

  Questions(
      {this.question,
        this.answers,
        this.questionImageUrl,
        this.correctAnswer,
        this.score});

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answers =
    json['answers'] != null ? Answers.fromJson(json['answers']) : null;
    questionImageUrl = json['questionImageUrl'];
    correctAnswer = json['correctAnswer'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    if (answers != null) {
      data['answers'] = answers!.toJson();
    }
    data['questionImageUrl'] = questionImageUrl;
    data['correctAnswer'] = correctAnswer;
    data['score'] = score;
    return data;
  }
}

class Answers {
  String? a;
  String? b;
  String? c;
  String? d;

  Answers({this.a, this.b, this.c, this.d});

  Answers.fromJson(Map<String, dynamic> json) {
    a = json['A'];
    b = json['B'];
    c = json['C'];
    d = json['D'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['A'] = a;
    data['B'] = b;
    data['C'] = c;
    data['D'] = d;
    return data;
  }
}
