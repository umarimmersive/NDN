import 'package:get/get.dart';

import '../controllers/Pre_onlineTest_instruction_controller.dart';

class Pre_onlineTest_instruction_Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Pre_onlineTest_instruction_controller>(
      () => Pre_onlineTest_instruction_controller(),
    );
  }
}
