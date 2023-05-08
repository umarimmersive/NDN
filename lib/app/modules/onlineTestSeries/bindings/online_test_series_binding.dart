import 'package:get/get.dart';

import '../controllers/online_test_series_controller.dart';

class OnlineTestSeriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlineTestSeriesController>(
      () => OnlineTestSeriesController(),
    );
  }
}
