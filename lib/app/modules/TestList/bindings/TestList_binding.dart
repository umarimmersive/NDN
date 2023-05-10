import 'package:get/get.dart';

import '../controllers/TestList_controller.dart';


class TestList_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestList_Controller>(
      () => TestList_Controller(),
    );
  }
}
