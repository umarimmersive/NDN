import 'package:get/get.dart';

import '../controllers/quiz_screen_controller.dart';

class QuizScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizScreenController>(
      () => QuizScreenController(),
    );
  }
}
