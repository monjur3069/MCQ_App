import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/routes/routes_name.dart';
import 'package:quiz_app/screens/question_page/widgets/question_set.dart';

class ResultPageView extends StatelessWidget {
  static const String routeName = '/result';
  int rightAnswers = 0;

  ResultPageView({super.key});

  @override
  Widget build(BuildContext context) {
    calculateResult();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Correct Answers'),
            Text(
              '$rightAnswers',
              style: const TextStyle(fontSize: 30),
            ),
            TextButton(
              onPressed: () {
                questionList.clear();
                Get.offAllNamed(Routes.quizPageRoute);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  calculateResult() {
    print(questionList);
    for (var question in questionList) {
      if (question.givenAnswer == question.rightAnswer) {
        rightAnswers++;
      }
    }
  }
}
