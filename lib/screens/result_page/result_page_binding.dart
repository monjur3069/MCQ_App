import 'package:get/get.dart';
import 'package:quiz_app/screens/result_page/result_page_controller.dart';

class ResultPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ResultPageController());
  }

}