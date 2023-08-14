import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../db.dart';
import '../../../../utils/constants/api_service.dart';
import '../../../../utils/global_widgets/globle_var.dart';
import '../../../../utils/routes/app_pages.dart';

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



  final title_appbaar = 'Questions Summary'.obs;

  ///local sql lite
  final markReview = 0.obs;
  final answer = 0.obs;
  final Notanswer = 0.obs;
  final MarkAndAnswer = 0.obs;
  final test_id = ''.obs;
  final exam_title = ''.obs;
  final Series_name = ''.obs;





  List<dynamic> questions_one = [].obs;





  @override
  void onInit() async{
    print('----------------------call on init');
    cochingId.value=Get.parameters['cochingId'].toString();
    exam_title.value=Get.parameters['exam_title'].toString();
    test_id.value=Get.parameters['test_id'].toString();
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
    Series_name.value=Get.parameters['Series_name'].toString();



    await onInit_Test();

    super.onInit();
  }
  final isLoading=false.obs;
   onInit_Test() async {
    isLoading.value=true;
    questions_one.clear();

    Database? db = await SqliteService.instance.database;
    List<Map> result = await db!.rawQuery('SELECT * FROM Questions WHERE type=${seriesId.value.toString()}');

    result.forEach((row) => print("row------------------------$row"));
    questions_one.addAll(result);

    if(result.isEmpty){
      print('------------------not call ');
      isLoading.value=false;
      await  refreshNotes();
    }else{
      print('------------call now');
      await  refreshNotes();
    }
  }




  refreshNotes() async {


    for(int i =0;i<questions_one.length;i++){
      if(questions_one[i]['markforreview'].toString()=="1"){
        markReview.value=markReview.value+1;
        print('markReview----------------------${markReview.value}');
      }
    }

    for(int j =0;j<questions_one.length;j++){
      print('-------xcmnzxcnxdn');
      print('user_answer-------${questions_one[j]['user_answer']}');
      if(questions_one[j]['user_answer'].toString()=="null"){
        Notanswer.value=Notanswer.value+1;
        print('Notanswer----------------------${Notanswer.value}');
      }
    }

    for(int i =0;i<questions_one.length;i++){
      if(questions_one[i]['user_answer'].toString()!="null"){
        answer.value=answer.value+1;
        print('answer----------------------${answer.value}');
      }
    }

    for(int i =0;i<questions_one.length;i++){
      if(questions_one[i]['user_answer'].toString()!="null" && questions_one[i]['markforreview'].toString()=="1"){
        MarkAndAnswer.value=MarkAndAnswer.value+1;
        print('MarkAndAnswer----------------------${MarkAndAnswer.value}');
      }
    }



    print('markReview---------------${markReview.value}');


    isLoading.value=false;
    update();
    print('questions_one--------------------------$questions_one');

  }



  final final_questions_one = [];

 /* refreshNotes1() async {
    final_questions_one.clear();
    Database? db = await SqliteService.instance.database;
    List<Map> result = await db!.rawQuery('SELECT * FROM Questions WHERE type=${seriesId.value.toString()}');
    final_questions_one.addAll(result);
    isLoading(false);
  }*/

  Future Submit_exam({questions_one,remenning_time,test_id,exam_title,Series_name}) async {
    try {
     // await refreshNotes1();
      isLoading(true);
      var response = await ApiService().Test_Submit(questions_one: questions_one,Token: userData!.userId.toString(),total_time:duration.toString(),negative_marks: negative_marking_number,right_marks: marking_number ,series_id: seriesId);
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
        print('exam_title-----------------$exam_title');

        var data={
          'tital': title.toString(),
          'test_id':seriesId.toString(),
          'test_id_start':test_id.toString(),
          'skip_answer':skip_answer.toString(),
          'wrong_answer':wrong_answer.toString(),
          'right_answer':right_answer.toString(),
          'total_question':total_question.toString(),
          'total_time':total_time.toString(),
          'total_score':total_score.toString(),
          'test_total_score':test_total_score.toString(),
          'accuracy':accuracy.toString(),
          'accuracy2':accuracy2.toString(),
          'subject_name':subject_name.toString(),
          'exam_title':exam_title.toString(),
          'Series_name':Series_name.toString()
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


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  @override
  void dispose() {
    Get.delete<QuestionDetailsController>();
    super.dispose();
  }



  void increment() => count.value++;
}
