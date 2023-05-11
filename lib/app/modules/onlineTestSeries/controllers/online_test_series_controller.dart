import 'package:get/get.dart';

class OnlineTestSeriesController extends GetxController {
  //TODO: Implement OnlineTestSeriesController
  final List<String> examTestSeriesData = [
    'Test Series 1',
    'Test Series 2',
    'Test Series 3',
    'Test Series 4',
    'Test Series 5',
  ];

  final List<String> examTest= [
    'English',
    'Mathematics',
    'General Knowledge',
    'Reasoning',
    'Science',
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
