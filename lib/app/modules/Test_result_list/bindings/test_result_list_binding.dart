import 'package:get/get.dart';

import '../controllers/test_result_list_controller.dart';

class TestResultListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestResultListController>(
      () => TestResultListController(),
    );
  }
}
