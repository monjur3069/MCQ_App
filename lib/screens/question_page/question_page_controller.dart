import 'package:get/get.dart';
import 'package:quiz_app/models/question_list_model.dart';
import 'package:quiz_app/screens/question_page/widgets/question_set.dart';
import 'package:quiz_app/services/question_list_model.dart';

class QuestionPageController extends GetxController {
  RxList<Questions>? questions = <Questions>[].obs;
  RxBool isDataLoaded = false.obs;

  fetchQuestionListData() async {
    var a = await QuestionListApiService.fetchQuestionListData();
    questions?.value = a ?? [];
    questions!.shuffle();

    List<String> allAnswers = [];

    await Future.forEach(questions!, (question) {
      var answers = question.answers!;
      if (questions?.isNotEmpty == true && question.answers != null) {
        if (answers.a != null) allAnswers.add(answers.a!);
        if (answers.b != null) allAnswers.add(answers.b!);
        if (answers.c != null) allAnswers.add(answers.c!);
        if (answers.d != null) allAnswers.add(answers.d!);
      }
      questionList.add(QuestionSet(
        question: question.question!,
        options: List.from(allAnswers),
        rightAnswer: question.correctAnswer! == 'A'
            ? answers.a
            : question.correctAnswer! == 'B'
                ? answers.b
                : question.correctAnswer! == 'C'
                    ? answers.c
                    : answers.d,
        givenAnswer: '',
      ));
      print(questionList);
      allAnswers.clear();
    });

    print(questionList.length);
    isDataLoaded.value = true;
  }

  @override
  void onInit() {
    fetchQuestionListData();
    super.onInit();
  }
}
