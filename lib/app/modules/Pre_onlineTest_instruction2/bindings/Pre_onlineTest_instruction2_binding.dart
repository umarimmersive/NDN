import 'package:get/get.dart';

import '../controllers/Pre_onlineTest_instruction2_controller.dart';

class Pre_onlineTest_instruction2_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Pre_onlineTest_instruction2_controller>(
      () => Pre_onlineTest_instruction2_controller(),
    );
  }
}
