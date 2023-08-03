import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/constants/ColorValues.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../models/Test_list_model.dart';
import '../../../../models/getExamList.dart';
import '../../../../utils/constants/api_service.dart';
import '../../../../utils/global_widgets/globle_var.dart';
import '../views/Exam_model.dart';

class TestList_Controller extends GetxController {
  //TODO: Implement OnlineTestSeriesController
  static const platform = MethodChannel('samples.flutter.dev/battery');

  final count = 0.obs;
  final cochingId = ''.obs;
  final examId = ''.obs;
  final testId = ''.obs;
  final title = ''.obs;
  final total_amount = ''.obs;
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
        total_amount.value=response['total_amount'].toString();
        Test_list.value = dataList.map((json) => Test_list_model.fromJson(json)).toList();


      } else if (response['success'] == false) {
        isLoading1(false);
      }
    } finally {
      isLoading1(false);

    }
  }

  Future Purchase_course({transaction_id,payment_status,series_id}) async {
    try {
      isLoading1(true);
      var response = await ApiService().Buy_course(transaction_id: transaction_id,payment_status: payment_status,series_id: series_id);
      print({'get exam list----------------------------$response'});
      if (response['success'] == true) {
        Fluttertoast.showToast(
            msg: 'Test Series Purchase Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.lightBlue,
            textColor: Colors.white,
            fontSize: 16.0
        );


      } else if (response['success'] == false) {
        isLoading1(false);
      }
    } finally {
      isLoading1(false);

    }
  }

  void incrementCounter({price}) async{

    final List<Object?> result = await platform.invokeMethod('callSabPaisaSdk',[userData!.name,"",userData!.emailId,userData!.phoneNumber,price]);

    String txnStatus = result[0].toString();
    String txnId = result[1].toString();
    if(txnStatus.toString()=="SUCCESS"){

    await  Purchase_course(series_id: testId.value,payment_status: txnStatus.toString(),transaction_id: txnId.toString());
     // controller.PlaceOrder(transaction_id: txnId,item_price: price,item_type: controller.Type.value,payment_status: txnStatus.toString());
    }else{
      Fluttertoast.showToast(
          msg: txnStatus,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
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
