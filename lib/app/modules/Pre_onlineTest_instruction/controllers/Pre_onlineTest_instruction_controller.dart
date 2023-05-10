import 'package:get/get.dart';

class Pre_onlineTest_instruction_controller extends GetxController {
  //TODO: Implement OnlineTestSeriesController
  final List<String> examTestSeriesData = [
    'Test Series 1: English',
    'Test Series 2: Mathematics',
    'Test Series 3: General Knowledge',
    'Test Series 4: Reasoning',
    'Test Series 5: Science',
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
