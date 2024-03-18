import 'package:get/get.dart';
import 'package:quiz_app/routes/routes_name.dart';
import 'package:quiz_app/screens/question_page/question_page_binding.dart';
import 'package:quiz_app/screens/question_page/question_page_view.dart';
import 'package:quiz_app/screens/result_page/result_page_binding.dart';
import 'package:quiz_app/screens/result_page/result_page_view.dart';

class AppRoute {
  static final pages = [
    GetPage(
      name: Routes.quizPageRoute,
      page: () => const QuestionPageView(),
      binding: QuestionPageBinding(),
    ),
    GetPage(
      name: Routes.resultPageRoute,
      page: () => ResultPageView(),
      binding: ResultPageBinding(),
    ),

  ];
}