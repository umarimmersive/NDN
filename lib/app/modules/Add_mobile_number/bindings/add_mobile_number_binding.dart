import 'package:get/get.dart';

import '../controllers/add_mobile_number_controller.dart';

class AddMobileNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMobileNumberController>(
      () => AddMobileNumberController(),
    );
  }
}
