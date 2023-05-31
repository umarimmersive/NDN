import 'package:get/get.dart';

import '../controllers/test_result_controller.dart';

class TestResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestResultController>(
      () => TestResultController(),
    );
  }
}
