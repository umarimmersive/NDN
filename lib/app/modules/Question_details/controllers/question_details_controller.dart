import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../db.dart';

class QuestionDetailsController extends GetxController {
  //TODO: Implement QuestionDetailsController
  final int columnCount = 5;
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

  ///local sql lite
  final markReview = 0.obs;
  final answer = 0.obs;
  final Notanswer = 0.obs;
  final MarkAndAnswer = 0.obs;






  @override
  void onInit() async{
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
    isLoading.value=true;
    print('total_number_of_question---------------${total_number_of_question}');

    Database? db = await SqliteService.instance.database;
    // raw query
    List<Map> result = await db!.rawQuery('SELECT * FROM Questions WHERE type=${seriesId.value.toString()}');
    // print the results
    result.forEach((row) => print("row------------------------$row"));


    if(result.isEmpty){
      //await Get_Qustion1();
    }else{
      await  refreshNotes();
      print('------------------------------------- old sart');
    }
    super.onInit();
  }

  List<dynamic> questions_one = [].obs;

  final isLoading=false.obs;
  refreshNotes() async {
    final data = await SqliteService.getItems();
    questions_one = data;

    for(int i =0;i<questions_one.length;i++){
      if(questions_one[i].markforreview=='1'){
        markReview.value=i+1;
      }
    }

    for(int i =0;i<questions_one.length;i++){
      if(questions_one[i].user_answer.toString().isEmpty){
        Notanswer.value=i+1;
        print('not answer -----${Notanswer.value}');
      }
    }

    for(int i =0;i<questions_one.length;i++){
      if(questions_one[i].user_answer.toString().isNotEmpty){
        answer.value=i+1;
      }
    }

    for(int i =0;i<questions_one.length;i++){
      if(questions_one[i].user_answer.toString().isNotEmpty && questions_one[i].markforreview.toString()!='0'){
        MarkAndAnswer.value=i+1;
      }
    }



    print('markReview---------------${markReview.value}');


    isLoading.value=false;
    update();
    print('questions_one--------------------------$questions_one');

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
