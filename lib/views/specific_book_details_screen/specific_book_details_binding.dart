
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/detailed_coaching_screen/detailed_coaching_controller.dart';

import 'specific_book_details_controller.dart';



class specific_book_details_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<specific_book_details_controller>(
          () => specific_book_details_controller(),
    );
  }
}
