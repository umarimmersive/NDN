
import 'package:get/get.dart';
import 'detailed_course_controller.dart';



class detailed_course_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<detailed_course_controller>(
          () => detailed_course_controller(),
    );
  }
}
