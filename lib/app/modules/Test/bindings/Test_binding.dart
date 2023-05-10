import 'package:get/get.dart';

import '../controllers/TestController.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestController>(
      () => TestController(),
    );
  }
}
