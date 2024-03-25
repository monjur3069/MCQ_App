import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/models/question_list_model.dart';
import 'package:quiz_app/routes/routes_name.dart';
import 'package:quiz_app/screens/question_page/widgets/question_set.dart';
import 'package:quiz_app/services/question_list_model.dart';
import 'package:quiz_app/utils/constant.dart';

class QuestionPageController extends GetxController {

  RxList<Questions>? questions = <Questions>[].obs;
  RxBool isDataLoaded = false.obs;

  fetchQuestionListData() async {
    EasyLoading.show(status: 'Please Wait!',dismissOnTap: false);
    var a = await QuestionListApiService.fetchQuestionListData();
    questions?.value = a ?? [];
    questions!.shuffle();

    List<String> allAnswers = [];
    ///with forIn loop
    for (var question in questions!) {
      if (question.answers != null) {
        var answersMap = question.answers!.toJson();
        ///making list with answers
        for (var value in answersMap.values) {
          if (value != null) {
            allAnswers.add(value);
          }
        }
        var answers = question.answers!;

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

        debugPrint('$allAnswers');
      }

      allAnswers.clear();
    }

  ///with foreach loop
/*
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
      debugPrint('$questionList');
      allAnswers.clear();
    });
    }
*/

    if(questionList.isNotEmpty){
      isDataLoaded.value = true;
      hasQuizStarted.value = true;
      startTimer();
    }
    EasyLoading.dismiss();
  }


  String genderGroupValue = 'Male';
  late Timer timer;
  RxInt tick = 70.obs;
  RxString timeString = ''.obs;
  RxBool hasQuizStarted = false.obs;

  setTime() {
    timeString.value = DateFormat('mm:ss')
        .format(DateTime.fromMillisecondsSinceEpoch(tick.value * 1000));
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if(tick <= 0) {
        timer.cancel();
        Get.offAllNamed(Routes.resultPageRoute);
      } else {
          tick--;
          setTime();
      }
    });
  }

  @override
  void onInit() {
    var a = Get.arguments ?? 0;
    if(highScore<a){
      highScore = a;
    }
    setTime();
    super.onInit();
  }
}
