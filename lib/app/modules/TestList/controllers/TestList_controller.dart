import 'package:get/get.dart';

import '../../../../models/Test_list_model.dart';
import '../../../../models/getExamList.dart';
import '../../../../utils/constants/api_service.dart';
import '../../../../utils/global_widgets/globle_var.dart';
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
  final cochingId = ''.obs;
  final examId = ''.obs;
  final testId = ''.obs;
  final title = ''.obs;
  @override
  void onInit() {
    cochingId.value=Get.parameters['cochingId'].toString();
    examId.value=Get.parameters['examId'].toString();
    testId.value=Get.parameters['testId'].toString();
    title.value=Get.parameters['title'].toString();
    Get_test_list();
   /* "cochingId":controller.cochingId.toString(),
    "examId":controller.exam_id.toString(),*/
    super.onInit();
  }

  final isLoading1=false.obs;
  final Test_list  = <Test_list_model>[].obs;


  Future Get_test_list() async {
    try {
      isLoading1(true);
      var response = await ApiService().gettestSeriesList(id: userData!.userId,coaching_id: cochingId,test_id: testId);
      print({'get exam list----------------------------$response'});
      if (response['success'] == true) {

        List dataList = response['data'].toList();
        Test_list.value = dataList.map((json) => Test_list_model.fromJson(json)).toList();


      } else if (response['success'] == false) {
        isLoading1(false);
      }
    } finally {
      isLoading1(false);

    }
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
