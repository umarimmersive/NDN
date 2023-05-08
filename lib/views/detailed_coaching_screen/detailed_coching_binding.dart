
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/detailed_coaching_screen/detailed_coaching_controller.dart';



class detailed_coching_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<detailed_coaching_controller>(
          () => detailed_coaching_controller(),
    );
  }
}
