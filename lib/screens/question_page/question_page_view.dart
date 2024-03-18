import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/routes/routes_name.dart';
import 'package:quiz_app/screens/question_page/question_page_controller.dart';
import 'package:quiz_app/screens/question_page/widgets/question_set.dart';
import 'package:quiz_app/screens/question_page/widgets/question_set_view.dart';

class QuestionPageView extends StatefulWidget {
  static const String routeName = '/';
  const QuestionPageView({super.key});

  @override
  State<QuestionPageView> createState() => _QuestionPageViewState();
}

class _QuestionPageViewState extends State<QuestionPageView> {
  var controller = Get.find<QuestionPageController>();
  String genderGroupValue = 'Male';
  late Timer timer;
  int tick = 300;
  String timeString = '';
  bool hasQuizStarted = false;
  @override
  void didChangeDependencies() {
    setTime();
    super.didChangeDependencies();
  }

  void setTime() {
    timeString = DateFormat('mm:ss')
        .format(DateTime.fromMillisecondsSinceEpoch(tick * 1000));
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if(tick <= 0) {
        timer.cancel();
        navigateToResult();
      } else {
        setState(() {
          tick--;
          setTime();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('Flutter Quiz'),
        actions: [
          TextButton(
            style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
            onPressed: () {
              timer.cancel();
              navigateToResult();
            },
            child: const Text('Submit', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: Column(
        children: [
          Text(timeString, style: const TextStyle(fontSize: 50),),
          if(!hasQuizStarted) ElevatedButton(
            onPressed: () {
              setState(() {
                hasQuizStarted = true;
              });
              startTimer();
            },
            child: const Text('Start Quiz'),
          ),
          if(hasQuizStarted) Expanded(
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
        ],
      ),
    );
  }
  navigateToResult() => Get.offAllNamed(Routes.resultPageRoute);
}
