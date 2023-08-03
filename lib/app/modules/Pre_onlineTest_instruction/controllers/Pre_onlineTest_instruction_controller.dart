import 'dart:convert';

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../db.dart';
import '../../../../models/Questions_model.dart';
import '../../../../utils/constants/api_service.dart';
import '../../../../utils/global_widgets/globle_var.dart';

class Pre_onlineTest_instruction_controller extends GetxController {
  //TODO: Implement OnlineTestSeriesController
  final List<String> examTestSeriesData = [
    'Test Series 1: English',
    'Test Series 2: Mathematics',
    'Test Series 3: General Knowledge',
    'Test Series 4: Reasoning',
    'Test Series 5: Science',
  ];
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
  final duration2 = ''.obs;
  @override
  void onInit() async{

    cochingId.value=Get.parameters['cochingId'].toString();
    print('cochingId------instruction---------${cochingId.value}');
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

    print('time----------------------------------------$time');
    print('duration----------------------------------------$duration');
    print('total_number_of_question----------------------------------------$total_number_of_question');
    print('marking_number----------------------------------------$marking_number');
    print('seriesId.value----------------------------------------${seriesId.value}');


    Database? db = await SqliteService.instance.database;
    // raw query
    List<Map> result = await db!.rawQuery('SELECT * FROM Questions WHERE type=${seriesId.value.toString()}');
    // print the results
    result.forEach((row) => print("row------------------------$row"));


    if(result.isEmpty){
      await Get_Qustion1();
    }else{
      //await  refreshNotes();
      print('------------------------------------- old sart');
    }
    super.onInit();
  }


  final  token= ''.obs;
  final  Test_question = [].obs;
  final isLoading=false.obs;

  Future Get_Qustion1() async {
    Test_question.value.clear();
    try {
      isLoading(true);
      var response = await ApiService().get_Questions_list(series_id: seriesId,user_Id: userData!.userId);

      print({'response==================================$response'});

      if (response['success'] == true) {
        Test_question.value = response['data'].toList();
        var data;
        for(int i=0; i<Test_question.value.length;i++){

          print('answer_index_hindi-----------${Test_question[i]['answer_index_hindi']}');

          data = Questions_model(
              id: Test_question[i]['id'],answerIndex: Test_question[i]['answer_index'].toString(),
              markforreview: '0',
              options: jsonEncode(Test_question[i]['options']),
              question: Test_question[i]['question'],user_answer: 'null',type: seriesId.value.toString(),
              question_hindi: Test_question[i]['question_hindi'].toString(),
              options_hindi: jsonEncode(Test_question[i]['options_hindi']??''),
              answer_index_hindi: jsonEncode(Test_question[i]['answer_index_hindi']??''),
              option_image: jsonEncode(Test_question[i]['option_image']??''),
              is_question_image: Test_question[i]['is_question_image'].toString()??'',
              question_image: Test_question[i]['question_image'].toString() ?? '',
              is_option_image: Test_question[i]['is_option_image'].toString() ?? '',
          );

          print('option_image------${jsonEncode(Test_question[i]['option_image']??'')}');
          print('options------${jsonEncode(Test_question[i]['options']??'')}');
          print('data------------------------${data}');
          await SqliteService.createItem(data);


        }


        // sqliteService= SqliteService();

       /* SqliteService.initizateDb().whenComplete(() async {
          print('init-------ini-----');
          await refreshNotes();
          // setState(() {});
        });*/
        update();
        isLoading(false);

      } else if (response['success'] == false) {

        /* final databasePath = await getDatabasesPath();
        print('databasePath-------$databasePath');
       await SqliteService.deleteDatabase(databasePath);*/
        isLoading(false);
      }
    } finally {
      update();
      isLoading(false);

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
