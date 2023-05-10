import 'package:get/get.dart';

import '../views/Exam_model.dart';

class TestList_Controller extends GetxController {
  //TODO: Implement OnlineTestSeriesController
  final exams = <Exam>[
    Exam(number: 'Test 1',name: "Math exam", date: '01/01/2023', time: "10:00 AM", isPaid: true),
    Exam(number: 'Test 1',name: "Science exam", date: '01/01/2023', time: "2:00 PM", isPaid: false),
    Exam(number: 'Test 1',name: "History exam", date: '01/01/2023', time: "9:00 AM", isPaid: true),
    Exam(number: 'Test 1',name: "English exam", date: '01/01/2023', time: "11:00 AM", isPaid: false),
    Exam(number: 'Test 1',name: "Foreign language exam", date: '01/01/2023', time: "3:00 PM", isPaid: true),
    Exam(number: 'Test 1',name: "Math exam", date: '01/01/2023', time: "10:00 AM", isPaid: true),
    Exam(number: 'Test 1',name: "Science exam", date: '01/01/2023', time: "2:00 PM", isPaid: false),
    Exam(number: 'Test 1',name: "History exam", date: '01/01/2023', time: "9:00 AM", isPaid: true),
    Exam(number: 'Test 1',name: "English exam", date: '01/01/2023', time: "11:00 AM", isPaid: false),
    Exam(number: 'Test 1',name: "Foreign language exam", date: '01/01/2023', time: "3:00 PM", isPaid: true),

  ].obs;

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
