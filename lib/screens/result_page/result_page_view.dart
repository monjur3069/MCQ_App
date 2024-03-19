import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/routes/routes_name.dart';
import 'package:quiz_app/screens/question_page/widgets/question_set.dart';
import 'package:quiz_app/screens/result_page/result_page_controller.dart';

class ResultPageView extends StatelessWidget {
  const ResultPageView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ResultPageController>();
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
              '${controller.rightAnswers}',
              style: const TextStyle(fontSize: 30),
            ),
            TextButton(
              onPressed: () {
                questionList.clear();
                Get.offAllNamed(Routes.quizPageRoute,arguments: controller.rightAnswers);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

}
