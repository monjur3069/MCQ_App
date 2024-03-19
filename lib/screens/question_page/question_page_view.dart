import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/common_widget/internet_connection_checker.dart';
import 'package:quiz_app/routes/routes_name.dart';
import 'package:quiz_app/screens/question_page/question_page_controller.dart';
import 'package:quiz_app/screens/question_page/widgets/question_set.dart';
import 'package:quiz_app/screens/question_page/widgets/question_set_view.dart';
import 'package:quiz_app/utils/constant.dart';

class QuestionPageView extends StatelessWidget {
  const QuestionPageView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<QuestionPageController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Obx(
          () => AppBar(
            backgroundColor: const Color(0xff006A70).withOpacity(0.5),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/exam.png',
                  fit: BoxFit.fitHeight,
                  height: 35,
                  width: 35,
                ),
              ],
            ),
            surfaceTintColor: Colors.transparent,
            title: controller.hasQuizStarted.value
                ? Obx(
                  ()=> Text(
                      controller.timeString.value,
                      style: TextStyle(fontSize: 20,color: controller.tick.value < 60 ? Colors.red : Colors.black),
                    ),
                )
                : const Text('Test Your Brain',style: TextStyle(color: Colors.white),),
            centerTitle: true,
            actions: [
              Visibility(
                visible: controller.hasQuizStarted.value,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      controller.timer.cancel();
                      Get.offAllNamed(Routes.resultPageRoute);
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !controller.hasQuizStarted.value,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text('High Score : $highScore',style: const TextStyle(color: Colors.white,fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Visibility(
              visible: !controller.hasQuizStarted.value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Image.asset(
                    'images/logo.png',
                    fit: BoxFit.cover,
                  )),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    controller.timeString.value,
                    style: const TextStyle(fontSize: 50),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (!await ConnectionChecker.checkConnection()) {
                        Get.snackbar("You are Offline !!",
                            "Please check internet connection.",
                            backgroundColor: Colors.white,
                            colorText: Colors.red,
                            snackPosition: SnackPosition.TOP);
                        return;
                      }
                      await controller.fetchQuestionListData();
                    },
                    child: Container(
                      width: 200,
                      alignment: Alignment.center,
                      height: 50,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: const [0.1, 0.5, 0.5, 0.9],
                          colors: [
                            const Color(0xff006A70).withOpacity(0.8),
                            // Base color
                            const Color(0xff006A70).withOpacity(0.7),
                            // Lighter shade
                            const Color(0xff006A70).withOpacity(0.6),
                            // Even lighter shade
                            const Color(0xff006A70).withOpacity(0.5),
                          ],
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text(
                        'START',
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.hasQuizStarted.value,
              child: Expanded(
                child: ListView.builder(
                  itemCount: questionList.length,
                  itemBuilder: (context, index) {
                    final question = questionList[index];
                    return QuestionSetView(
                      index: index,
                      question: question,
                      onAnswered: (value) {
                        questionList[index].givenAnswer = value;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
