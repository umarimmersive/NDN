
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/dashboard_screen/controller_home_view.dart';
import 'package:national_digital_notes_new/views/detailed_coaching_screen/detailed_coaching_controller.dart';



class home_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<controller_home_view>(
          () => controller_home_view(),
    );
  }
}
