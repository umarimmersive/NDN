import 'package:get/get.dart';

class Pre_onlineTest_instruction2_controller extends GetxController {
  //TODO: Implement OnlineTestSeriesController

  final check1 = false.obs;
  final count = 0.obs;
  final seriesId = ''.obs;
  final instruction = ''.obs;
  final time = ''.obs;
  final subject_name = ''.obs;
  final payment_type = ''.obs;
  final negative_marking = ''.obs;
  final negative_marking_number = ''.obs;
  final total_number_of_question = ''.obs;
  final passing_value = ''.obs;
  final title = ''.obs;
  final show_result = ''.obs;
  final duration = ''.obs;
  final date = ''.obs;
  final marking_number = ''.obs;
  final payment_amount = ''.obs;
  final total_mark = ''.obs;
  final cochingId = ''.obs;
  final duration2 = ''.obs;
  @override
  void onInit() {
    cochingId.value=Get.parameters['cochingId'].toString();
    print('cochingId------instruction2--------${cochingId.value}');
    seriesId.value=Get.parameters['seriesId'].toString();
    instruction.value=Get.parameters['instruction'].toString();
    time.value=Get.parameters['time'].toString();
    passing_value.value=Get.parameters['passing_value'].toString();
    total_number_of_question.value=Get.parameters['total_number_of_question'].toString();
    negative_marking_number.value=Get.parameters['negative_marking_number'].toString();
    negative_marking.value=Get.parameters['negative_marking'].toString();
    payment_type.value=Get.parameters['payment_type'].toString();
    payment_type.value=Get.parameters['payment_type'].toString();
    subject_name.value=Get.parameters['subject_name'].toString();
    title.value=Get.parameters['title'].toString();
    show_result.value=Get.parameters['show_result'].toString();
    duration.value=Get.parameters['duration'].toString();
    date.value=Get.parameters['date'].toString();
    marking_number.value=Get.parameters['marking_number'].toString();
    payment_amount.value=Get.parameters['payment_amount'].toString();
    total_mark.value=Get.parameters['total_mark'].toString();
    duration2.value=Get.parameters['duration2'].toString();



    print('--------------${seriesId.value}');

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
