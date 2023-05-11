import 'package:get/get.dart';

import '../controllers/question_details_controller.dart';

class QuestionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionDetailsController>(
      () => QuestionDetailsController(),
    );
  }
}
