import 'package:get/get.dart';
import 'package:national_digital_notes_new/app/modules/Test_result_list/controllers/Result.dart';

import '../../../../models/Test_list_model.dart';
import '../../../../models/Test_result_list_model.dart';
import '../../../../utils/constants/api_service.dart';
import '../../../../utils/global_widgets/globle_var.dart';

class TestResultListController extends GetxController {
  //TODO: Implement TestResultListController

  List<Result> results = [
    Result(test: 'Test 1', obtained: '90%', rank: '1st', solution: 'A'),
    Result(test: 'Test 2', obtained: '75%', rank: '2nd', solution: 'B'),
    Result(test: 'Test 3', obtained: '82%', rank: '3rd', solution: 'C'),
  ];
  final count = 0.obs;
  @override
  void onInit() {
    Get_test_result_list();
    super.onInit();
  }
  final isLoading1=false.obs;
  final Test_list  = <Test_result_list_model>[].obs;


  Future Get_test_result_list() async {
    try {
      isLoading1(true);
      var response = await ApiService().Test_Result_List(userData!.userId);
      print({'get test result list----------------------------$response'});
      if (response['success'] == true) {

        List dataList = response['data'].toList();
        Test_list.value = dataList.map((json) => Test_result_list_model.fromJson(json)).toList();


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



