import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
class TestResultController extends GetxController {
  //TODO: Implement TestResultController
  bool isActiveDownloadPDF = false;
  String filepath = "";
  Uint8List? capturedImage_local;
  ScreenshotController screenshotController = ScreenshotController();


  final count = 0.obs;
  final tital = ''.obs;
  final test_id = ''.obs;
  final skip_answer = ''.obs;
  final wrong_answer = ''.obs;
  final right_answer = ''.obs;
  final total_question = ''.obs;
  final total_time = ''.obs;
  final total_score = ''.obs;
  final test_total_score = ''.obs;
  final accuracy = ''.obs;

  /*var data={
    'tital': title.toString(),
    'test_id':seriesId.toString(),
    'skip_answer':skip_answer.toString(),
    'wrong_answer':wrong_answer.toString(),
    'right_answer':right_answer.toString(),
    'total_question':total_question.toString(),
    'total_time':total_time.toString(),
    'total_score':total_score.toString(),
    'test_total_score':test_total_score.toString(),
    'accuracy':accuracy.toString(),
  };*/

  @override
  void onInit() {

    tital.value=Get.parameters['tital'].toString();
    test_id.value=Get.parameters['test_id'].toString();
    skip_answer.value=Get.parameters['skip_answer'].toString();
    wrong_answer.value=Get.parameters['wrong_answer'].toString();
    right_answer.value=Get.parameters['right_answer'].toString();
    total_question.value=Get.parameters['total_question'].toString();
    total_time.value=Get.parameters['total_time'].toString();
    total_score.value=Get.parameters['total_score'].toString();
    test_total_score.value=Get.parameters['test_total_score'].toString();
    accuracy.value=Get.parameters['accuracy'].toString();

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
