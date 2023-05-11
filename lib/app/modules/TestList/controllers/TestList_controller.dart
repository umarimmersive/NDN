import 'package:get/get.dart';

import '../views/Exam_model.dart';

class TestList_Controller extends GetxController {
  //TODO: Implement OnlineTestSeriesController
  final exams = <Exam>[
    Exam(number: 'Test 1',name: "Math exam", date: '01/01/2023', time: "10:00 AM", isPaid: true, Status: true),
    Exam(number: 'Test 2',name: "Science exam", date: '01/01/2023', time: "2:00 PM", isPaid: false, Status: true),
    Exam(number: 'Test 3',name: "History exam", date: '01/01/2023', time: "9:00 AM", isPaid: true, Status: true),
    Exam(number: 'Test 4',name: "English exam", date: '01/01/2023', time: "11:00 AM", isPaid: false, Status: false),
    Exam(number: 'Test 5',name: "Foreign language exam", date: '01/01/2023', time: "3:00 PM", isPaid: true, Status: true),
    Exam(number: 'Test 6',name: "Math exam", date: '01/01/2023', time: "10:00 AM", isPaid: true, Status: true),
    Exam(number: 'Test 7',name: "Science exam", date: '01/01/2023', time: "2:00 PM", isPaid: false, Status: false),
    Exam(number: 'Test 8',name: "History exam", date: '01/01/2023', time: "9:00 AM", isPaid: true, Status: true),
    Exam(number: 'Test 9',name: "English exam", date: '01/01/2023', time: "11:00 AM", isPaid: false, Status: true),
    Exam(number: 'Test 10',name: "Foreign language exam", date: '01/01/2023', time: "3:00 PM", isPaid: true, Status: false),
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
