
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/detailed_coaching_screen/detailed_coaching_controller.dart';
import 'package:national_digital_notes_new/views/main/screens/splash_controller.dart';



class splash_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<splash_controller>(
          () => splash_controller(),
    );
  }
}