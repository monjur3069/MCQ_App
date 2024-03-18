import 'package:get/get.dart';
import 'package:quiz_app/screens/question_page/question_page_controller.dart';

class QuestionPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionPageController());
  }

}