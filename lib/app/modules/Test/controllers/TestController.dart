import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/models/Questions_model.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:national_digital_notes_new/utils/global_widgets/snackbar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vibration/vibration.dart';

import '../../../../db.dart';
import '../../../../models/Question_db_nodel.dart';
import '../../../../models/Report_option_model.dart';
import '../../../../utils/constants/api_service.dart';
import '../../../../utils/routes/app_pages.dart';
import '../views/Question.dart';


class TestController extends GetxController {

  //TODO: Implement OnlineTestSeriesController
  var countdown = 10.obs; // initial value of countdown is 10 seconds
  Timer? _timer;
  DateTime? currentBackPressTime;
  TextEditingController text=TextEditingController();

  final QuestionNumber=''.obs;



  final isLoading=false.obs;



  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        _timer!.cancel();
      }
    });
  }

  void stopCountdown() {
    _timer?.cancel();
  }


  final userAnswers = <int>[].obs;

  void setUserAnswer(int index, int answerIndex) {
    userAnswers[index] = answerIndex;
  }

  final count = 0.obs;

  final Total_time_available = ''.obs;
  late SqliteService sqliteService;


  final seriesId = ''.obs;
  final isLastIndex = false.obs;
  final show = false.obs;
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
  final selectValue = ''.obs;
  final Remenning_time = ''.obs;
  final backValue = ''.obs;
  final duration2 = ''.obs;
  final static_mark_of_review = '0'.obs;
  final is_index = 0.obs;

  void toggleCheckbox(String value) {
    selectValue.value = value;
  }



  @override
  void onInit() async{

    cochingId.value=Get.parameters['cochingId'].toString();
    print('test--------------${cochingId.value}');
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



    startCountdown();
    Get_Report_option();
    isLoading.value=true;



    if(count.value==0){
      fetchQuizzes();
      //refreshNotes();
    }else{
      print('---------------------exammmmm');
    }
    super.onInit();
  }

  //final questions_one=[];
  final Mark=[].obs;
  final questions_one = <Questions_model>[].obs;

  final currentQuestionIndex = 0.obs;
  var  currentQuestion;






   fetchQuizzes() async {
    questions_one.value = await SqliteService.instance.getAllQuizzes(seriesId.value);
    Mark.clear();
    for(int i=0;i<questions_one.length;i++){
      Mark.add(false);
    }
    currentQuestion = questions_one[currentQuestionIndex.value];

    update();
    print('--------------${questions_one.value}');
  }





  final MarkLoading=false.obs;
  final isLastQuestion1=false.obs;






  final final_questions_one = [];

  refreshNotes() async {
    final_questions_one.clear();
    Database? db = await SqliteService.instance.database;
    List<Map> result = await db!.rawQuery('SELECT * FROM Questions WHERE type=${seriesId.value.toString()}');
    final_questions_one.addAll(result);
    isLoading(false);
  }

  Future Submit_exam({questions_one,remenning_time}) async {
    try {
       await refreshNotes();
       isLoading(true);
      var response = await ApiService().Test_Submit(questions_one: final_questions_one,Token: userData!.userId.toString(),total_time:duration.toString(),negative_marks: negative_marking_number,right_marks: marking_number ,series_id: seriesId);
       print('response---------${response['data']}');

      if (response['success'] == true) {

        SqliteService.deleteItem(seriesId.toString());

        var skip_answer=response['data']['skip_answer'].toString();
        var wrong_answer=response['data']['wrong_answer'].toString();
        var right_answer=response['data']['right_answer'].toString();
        var total_question=response['data']['total_question'].toString();
        var total_time=response['data']['total_time'].toString();
        var total_score=response['data']['total_score'].toString();
        var test_total_score=response['data']['test_total_score'].toString();
        var accuracy=response['data']['accuracy'].toString();
        var accuracy2=response['data']['accuracy2'].toString();

        print('skip_answer----------------+$skip_answer');
        print('wrong_answer----------------+$wrong_answer');
        print('right_answer----------------+$right_answer');
        print('total_question----------------+$total_question');
        print('total_time----------------+$total_time');
        print('total_score----------------+$total_score');
        print('test_total_score----------------+$test_total_score');
        print('accuracy-----------------$accuracy');

        var data={
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
          'accuracy2':accuracy2.toString(),
          'subject_name':subject_name.toString()
        };

        Get.toNamed(Routes.TEST_RESULT,parameters: data);
       // Get.offAndToNamed(Routes.SUBMIT_TEST_SCREEN,parameters: data);

      } else if (response['success'] == false) {

        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

  final Report_option_list  = <Report_option_model>[].obs;
  final value=[].obs;


  Get_Report_option() async {

    try {
      isLoading(true);
      var response = await ApiService().Report_option(cochingId.value.toString());
      print({'----------------$response'});

      if (response['success'] == true) {
        List dataList = response['data'].toList();
        Report_option_list.value = dataList.map((json) => Report_option_model.fromJson(json)).toList();

        for(int i=0;i<Report_option_list.length;i++){
          value.add(false);
        }


        isLoading(false);
      } else if (response['success'] == false) {

      }

    } finally {
      isLoading(false);


    }
  }


  final isLoading2=false.obs;

  post_Report({question_id,report_option_id}) async {
    //print("======================${widget.coursesId}");
    try {

      isLoading2(true);
      var response = await ApiService().Report_send(coaching_id: cochingId.value,explanation: text.text.toString(),question_id: question_id, report_option_id: report_option_id,user_id:userData!.userId );
      print({'----------------$response'});

      if (response['success'] == true) {

        snackbar('${response['message']}');
        text.clear();



        isLoading2(false);
      } else if (response['success'] == false) {
        snackbar('${response['message']}');
      }

    } finally {
      isLoading2(false);


    }
  }



  @override
  void onReady() {
    super.onReady();
  }
  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
