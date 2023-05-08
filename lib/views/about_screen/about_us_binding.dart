
import 'package:get/get.dart';

import 'about_us_controller.dart';
class about_us_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<about_us_controller>(
      () => about_us_controller(),
    );
  }
}
