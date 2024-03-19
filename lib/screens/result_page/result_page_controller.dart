import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/question_page/widgets/question_set.dart';

class ResultPageController extends GetxController{
  int rightAnswers = 0;
  calculateResult() {
    debugPrint('$questionList');
    for (var question in questionList) {
      if (question.givenAnswer == question.rightAnswer) {
        rightAnswers++;
      }
    }
  }
  @override
  void onInit() {
    calculateResult();
    super.onInit();
  }
}