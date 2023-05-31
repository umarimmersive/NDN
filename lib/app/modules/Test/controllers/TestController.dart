import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/models/Questions_model.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:national_digital_notes_new/utils/global_widgets/snackbar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../db.dart';
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





     print('time----------------------------------------$time');
     print('duration----------------------------------------$duration');
     print('total_number_of_question----------------------------------------$total_number_of_question');
     print('marking_number----------------------------------------$marking_number');
     print('seriesId.value----------------------------------------${seriesId.value}');

/*
    Database? db = await SqliteService.instance.database;
    // raw query
    List<Map> result = await db!.rawQuery('SELECT * FROM Questions WHERE type=${seriesId.value.toString()}');
    // print the results
    result.forEach((row) => print("row------------------------$row"));


    if(result.isEmpty){
      //await Get_Qustion1();
    }else{
      await refreshNotes();
      print('------------------------------------- old sart');
    }*/

   // Future.delayed(Duration(seconds: 1)).then((value) => countDownController.start());
    if(count.value==0){
      refreshNotes();
    }else{
      print('---------------------exammmmm');
    }
    super.onInit();
  }

  List questions_one=[];
  final marklist=[].obs;

  refreshNotes() async {
    questions_one.clear();
    count.value=1;

    Database? db = await SqliteService.instance.database;
    List<Map> result = await db!.rawQuery('SELECT * FROM Questions WHERE type=${seriesId.value.toString()}');

    questions_one.addAll(result);
    marklist.clear();
    for(int i=0;i<questions_one.length;i++){
      marklist.add(false);
    }


    result.forEach((row) => print("row------------------------${row['User_answer']}"));


    isLoading(false);
    update();


  }




  final CurruntQ = 0.obs;
  final Question_Id = ''.obs;
  // All items
  late int selectedAnswer;
  int get selectedAns => selectedAnswer;

  // for more about obs please check documentation
  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int numOfCorrect_Ans = 0;
  int get numOfCorrectAns => numOfCorrect_Ans;

  final PageController pageController = PageController();

  Future<void> checkAns({questions,selectedIndex,userAnwer,markforreview}) async {

    var UpdateQustion= Questions_model(
      question: questions['question'].toString(),
      options:  questions['options'],
      answerIndex: questions['answerIndex'].toString(),
      id: questions['id'],
      user_answer: userAnwer.isEmpty? selectedIndex.toString() : userAnwer.toString(),
      type: seriesId.toString(),
      question_hindi: questions['question_hindi'].toString(),
      options_hindi: questions['options_hindi'].toString(),
      markforreview: markforreview.toString(),
    );


    await  SqliteService.updatedata(UpdateQustion);
    await  refreshNotes();

    update();
  }

  final MarkLoading=false.obs;


  void nextQuestion() {
    if (_questionNumber.value != questions_one.length) {
      pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.ease);
      update();
    }else {

    }
  }


  Future Submit_exam({questions_one,remenning_time}) async {
    try {
      isLoading(true);
      var response = await ApiService().Test_Submit(questions_one: questions_one,Token: userData!.userId.toString(),total_time:duration.toString(),negative_marks: negative_marking_number,right_marks: marking_number ,series_id: seriesId);
       print('response---------${response['data']}');

      if (response['success'] == true) {


        print('----------------------------${jsonEncode(questions_one)}');


        SqliteService.deleteItem(seriesId.toString());

        var skip_answer=response['data']['skip_answer'].toString();
        var wrong_answer=response['data']['wrong_answer'].toString();
        var right_answer=response['data']['right_answer'].toString();
        var total_question=response['data']['total_question'].toString();
        var total_time=response['data']['total_time'].toString();
        var total_score=response['data']['total_score'].toString();
        var test_total_score=response['data']['test_total_score'].toString();
        var accuracy=response['data']['accuracy'].toString();

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
        };

        Get.offAndToNamed(Routes.TEST_RESULT,parameters: data);
       // Get.offAndToNamed(Routes.SUBMIT_TEST_SCREEN,parameters: data);

      } else if (response['success'] == false) {

        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }


 // final isLoading=false.obs;
  //Report_option_model
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
        //List dataList = response['data'].toList();
       /* Report_option_list.value = dataList.map((json) => Report_option_model.fromJson(json)).toList();

        for(int i=0;i<Report_option_list.length;i++){
          value.add(false);
        }*/

       // snackbar('Report Sucessfully');
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
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void onClose() {

    super.onClose();
  }

  void increment() => count.value++;
}
