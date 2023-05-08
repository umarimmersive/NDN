
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/sign_up_screen/signup_controller.dart';
class signup_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
      () => SignupController(),
    );
  }
}
