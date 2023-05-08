
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/detailed_coaching_screen/detailed_coaching_controller.dart';
import 'package:national_digital_notes_new/views/subject_books/subject_wise_view_controller.dart';




class subject_wise_view_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<subject_wise_view_controller>(
          () => subject_wise_view_controller(),
    );
  }
}