import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../db.dart';
import '../../../../models/Questions_model.dart';
import '../../../../models/Report_option_model.dart';
import '../../../../utils/constants/ColorValues.dart';
import '../../../../utils/constants/api_service.dart';
import '../../../../utils/global_widgets/globle_var.dart';
import '../../../../utils/global_widgets/snackbar.dart';
import '../../Question_details/controllers/question_details_controller.dart';
import '../controllers/TestController.dart';
import 'MyBottomSheet.dart';
import 'MyBottomSheet3.dart';
import 'MyBottomSheet4.dart';

class Test_view extends StatefulWidget {
   Test_view({Key? key}) : super(key: key);


   @override
   _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<Test_view> {



  //TODO: Implement OnlineTestSeriesController
  var countdown = 10.obs; // initial value of countdown is 10 seconds
  Timer? _timer;
  DateTime? currentBackPressTime;
  TextEditingController text=TextEditingController();

  final QuestionNumber=''.obs;
  final TestController Controller = Get.find();
 /* final QuestionDetailsController Q_details_Controller = Get.find();*/


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
  void initState() {
    Controller.onInit();
    cochingId.value=Get.parameters['cochingId'].toString();
    print('test------------cfsdasfasdas--${cochingId.value}');
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
    fetchQuizzes(currentQuestionIndex.value);



    // TODO: implement initState
    super.initState();
  }


  //final questions_one=[];
  final Mark=[].obs;
  final questions_one = <Questions_model>[].obs;

  final currentQuestionIndex = 0.obs;
  final currentQuestion_number = 1.obs;
  var currentQuestion;

  void showPrevQuestion() {
    if (currentQuestionIndex.value>0) {
      currentQuestionIndex-1;
      currentQuestion_number-1;


      /*setState(() {

      });*/
      currentQuestion = questions_one[currentQuestionIndex.value];
      fetchQuizzes(currentQuestionIndex.value);
    } else {
      // _showResultScreen();
    }
  }

  void showNextQuestion() {
    if (currentQuestionIndex.value < questions_one.length-1) {

      currentQuestionIndex+1;
      currentQuestion_number+1;

     /* setState(() {

      });*/
      currentQuestion = questions_one[currentQuestionIndex.value];
      fetchQuizzes(currentQuestionIndex.value);
    } else {

      // _showResultScreen();
    }
  }
  refreshNotes() async {
    Database? db = await SqliteService.instance.database;
    List<Map> result = await db!.rawQuery('SELECT * FROM Questions WHERE type=${seriesId.value.toString()}');
    final_questions_one.addAll(result);
    isLoading(false);
  }
  fetchQuizzes(currentQuestionIndex) async {
    questions_one.value = await SqliteService.instance.getAllQuizzes(seriesId.value);
    print('currentQuestionIndex-------------------${currentQuestionIndex}');
    currentQuestion = questions_one[currentQuestionIndex];
    print('--------------${questions_one.value}');
    setState(() {

    });
  }


  final CurruntQ = 0.obs;
  final Question_Id = ''.obs;

  Future<void> checkAns({questions,selectedIndex,userAnwer,markforreview}) async {

    var UpdateQustion= Questions_model(
      question: questions.question.toString(),
      options:  questions.options,
      answerIndex: questions.answerIndex.toString(),
      id: questions.id,
      user_answer:show.value==false ? userAnwer.isEmpty? selectedIndex.toString() : userAnwer.toString():userAnwer.toString(),
      type: seriesId.toString(),
      question_hindi: questions.question_hindi.toString(),
      options_hindi: questions.options_hindi.toString(),
      option_image: questions.option_image.toString(),
      question_image: questions.question_image.toString(),
      is_option_image: questions.is_option_image.toString(),
      is_question_image: questions.is_question_image.toString(),
      markforreview: markforreview.toString(),
    );


    await  SqliteService.updatedata(UpdateQustion);
    //await  refreshNotes();
    await fetchQuizzes(currentQuestionIndex.value);

  }

  final MarkLoading=false.obs;
  final isLastQuestion1=false.obs;

  bool isLastQuestion(int questionId) {
    // Assuming you have a list of questions in the 'quizzes' variable
    // Replace it with the actual list of questions you have.
    if (questions_one.isEmpty) {
      return false;
    }

    final lastQuestion = questions_one.last;
    return lastQuestion.id == questionId;
  }




  final final_questions_one = [];

  /* refreshNotes() async {
    Database? db = await SqliteService.instance.database;
    List<Map> result = await db!.rawQuery('SELECT * FROM Questions WHERE type=${seriesId.value.toString()}');
    final_questions_one.addAll(result);
    isLoading(false);
  }*/


  Future Submit_exam({questions_one,remenning_time}) async {

   await refreshNotes();


    try {
      isLoading(true);
      var response = await ApiService().Test_Submit(questions_one: final_questions_one,Token: userData!.userId.toString(),total_time:duration.toString(),negative_marks: negative_marking_number,right_marks: marking_number ,series_id: seriesId);
      print('response-------------${response['data']}');

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

      /*  Q_details_Controller.markReview.value=0;
        Q_details_Controller.Notanswer.value=0;
        Q_details_Controller.answer.value=0;
        Q_details_Controller.MarkAndAnswer.value=0;*/

        Get.offAndToNamed(Routes.TEST_RESULT,parameters: data);
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














  DateTime? backButtonPressedTime;

   Future<bool> _onWillPop(BuildContext context) async {
     DateTime currentTime = DateTime.now();

     // If backButtonPressedTime is null or if the difference between currentTime
     // and backButtonPressedTime is greater than 2 seconds, then reset the backButtonPressedTime.
     if (backButtonPressedTime == null ||
         currentTime.difference(backButtonPressedTime!) > Duration(seconds: 2)) {
       backButtonPressedTime = currentTime;
      /* ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Double-tap back button to exit.')),
       );*/
       Get.bottomSheet(
         MyBottomSheet4(),
         backgroundColor: Colors.transparent,
         isDismissible: false,
       );


       return false;
     }
    // controller.Submit_exam(questions_one: controller.questions_one,remenning_time: controller.Remenning_time.value);

     Get.back();

     // If the difference is less than 2 seconds, exit the app.
     return false;
   }


  Color getTheRightColor(i) {
    if(i.toString() == currentQuestion.user_answer.toString()){

      return  ColorValues.kGreenColor;
    }
    return ColorValues.kGrayColor;
  }
  IconData getTheRightIcon() {
    return /*getTheRightColor() == ColorValues.kRedColor ? Icons.close :*/ Icons.done;
  }



  @override
  Widget build(BuildContext context) {

    var ab=[];
    var option_image=[];


    try{

      //  option_image.add(json.decode(controller.questions_one[index]['option_image']));
      print('csd---------------------${json.decode(currentQuestion.option_image.toString())}');


      ab = json.decode(currentQuestion.options.toString());
      option_image = json.decode(currentQuestion.option_image.toString());


    }catch(e){
      print(e);
    }

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child:
         Scaffold(
            appBar: AppBar(
              title:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${subject_name.value}',style: TextStyle(fontSize: 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0,right: 05),
                    child: Icon(
                      Icons.watch_later_outlined,
                      color: Colors.white,
                      size: 20.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),

                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 2.5,left: 00,right: 00),
                      child: Container(
                        child: TimerCountdown(
                          colonsTextStyle: TextStyle(fontSize: 16.0),
                          timeTextStyle:TextStyle(fontSize: 16.0),
                          onEnd: (){
                            Submit_exam(questions_one: questions_one,remenning_time: Remenning_time.value);
                          },
                          spacerWidth: 1,
                          enableDescriptions: false,
                          format: CountDownTimerFormat.hoursMinutesSeconds,
                          endTime: DateTime.now().add(
                              Duration(
                                hours: int.parse(duration2.value.toString().substring(0,2)),
                                minutes: int.parse(duration2.value.toString().substring(3,5)),
                                seconds: 00,
                              )
                          ),
                        ),
                      )
                  ),
                ],)
                ],
              ),
              //backgroundColor: Colors.redAccent,
              actions: [
                InkWell(
                  onTap: (){
                    Get.bottomSheet(
                      MyBottomSheet3(),
                      backgroundColor: Colors.transparent,
                      isDismissible: false,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ),
                ),
                InkWell(
                    onTap: (){
                      var data={
                        'cochingId':cochingId.toString(),
                        'seriesId':seriesId.toString(),
                        'instruction':instruction.toString(),
                        'time':time.toString(),
                        'passing_value':passing_value.toString(),
                        'total_number_of_question':total_number_of_question.toString(),
                        'negative_marking_number':negative_marking_number.toString(),
                        'negative_marking':negative_marking.toString(),
                        'payment_type':payment_type.toString(),
                        'subject_name':subject_name.toString(),
                        'title':title.toString(),
                        'show_result':show_result.toString(),
                        'duration':duration.toString(),
                        'date':date.toString(),
                        'marking_number':marking_number.toString(),
                        'payment_amount':payment_amount.toString(),
                        'total_mark':total_mark.toString(),
                      };

                      Get.toNamed(Routes.QUESTION_DETAILS,parameters: data)!.then((result) async{
                        print('result----${result[0]['backValue']}');

                        currentQuestion_number.value=int.parse(result[0]['backValue'].toString())+1;
                        currentQuestionIndex.value=int.parse(result[0]['backValue'].toString());
                       await fetchQuizzes(int.parse(result[0]['backValue'].toString()));


                       /* controller.pageController.animateToPage(
                          int.parse(result[0]['backValue']),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );*/

                      });


                      // Get.toNamed(Routes.QUESTION_DETAILS,parameters: data);


                    },child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.menu),
                    )),
                // PopupMenuButton(
                //
                //    icon: InkWell(
                //      onTap: (){
                //        Get.bottomSheet(
                //          MyBottomSheet3(),
                //          backgroundColor: Colors.transparent,
                //          isDismissible: false,
                //        );
                //      },
                //      child: Icon(
                //        Icons.info_outline,
                //        color: Colors.white,
                //        size: 24.0,
                //        semanticLabel: 'Text to announce in accessibility modes',
                //      ),
                //    ),
                //   // add icon, by default "3 dot" icon
                //   // icon: Icon(Icons.book)
                //     itemBuilder: (context){
                //       return [
                //
                //       ];
                //     },
                //     onSelected:(value){
                //       if(value == 0){
                //         print("My account menu is selected.");
                //       }else if(value == 1){
                //         print("Settings menu is selected.");
                //       }else if(value == 2){
                //         print("Logout menu is selected.");
                //       }
                //     }
                // ),
                // PopupMenuButton(
                //   // add icon, by default "3 dot" icon
                //     icon: InkWell(
                //         onTap: (){
                //           var data={
                //             'cochingId':controller.cochingId.toString(),
                //             'seriesId':controller.seriesId.toString(),
                //             'instruction':controller.instruction.toString(),
                //             'time':controller.time.toString(),
                //             'passing_value':controller.passing_value.toString(),
                //             'total_number_of_question':controller.total_number_of_question.toString(),
                //             'negative_marking_number':controller.negative_marking_number.toString(),
                //             'negative_marking':controller.negative_marking.toString(),
                //             'payment_type':controller.payment_type.toString(),
                //             'subject_name':controller.subject_name.toString(),
                //             'title':controller.title.toString(),
                //             'show_result':controller.show_result.toString(),
                //             'duration':controller.duration.toString(),
                //             'date':controller.date.toString(),
                //             'marking_number':controller.marking_number.toString(),
                //             'payment_amount':controller.payment_amount.toString(),
                //             'total_mark':controller.total_mark.toString(),
                //           };
                //
                //           Get.toNamed(Routes.QUESTION_DETAILS,parameters: data)!.then((result) {
                //             print('result----${result[0]['backValue']}');
                //             controller.pageController.animateToPage(
                //               int.parse(result[0]['backValue']),
                //               duration: const Duration(milliseconds: 500),
                //               curve: Curves.easeInOut,
                //             );
                //
                //           });
                //
                //
                //          // Get.toNamed(Routes.QUESTION_DETAILS,parameters: data);
                //
                //       /*Get.bottomSheet(
                //         MyBottomSheet(),
                //         backgroundColor: Colors.transparent,
                //         isDismissible: false,
                //       );*/
                //     },child: Icon(Icons.menu)),
                //     itemBuilder: (context){
                //       return [
                //
                //       ];
                //     },
                //     onSelected:(value){
                //
                //     }
                // ),
              ],
            ),
            body:
    Obx((){
    if(isLoading.isTrue){
    return Center(child: CupertinoActivityIndicator());
    }else{
      if(questions_one.isEmpty){
        return Center(child: Text('No Data Found'));
      }else{
       return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 9,
                child:
                SingleChildScrollView(
                  child: Column(children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                        margin: EdgeInsets.only(left: 12, right: 12),
                        child:

                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 05,horizontal: 06),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [

                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Q. ${currentQuestion_number.value}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                color: Colors.green,
                                                height: 20,
                                                width: 20,
                                                child: Center(child: Text('+${marking_number.value}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold))),
                                              ),



                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0),
                                                child: InkWell(
                                                  onTap: (){


                                                    if(currentQuestion.markforreview.toString()=='0'){
                                                      // controller.questions[index]['markforreview']='1';
                                                      print("user_answer == if condition");
                                                      // controller.Mark.value[index]=true;
                                                      checkAns(
                                                          questions: currentQuestion,
                                                          userAnwer: currentQuestion.user_answer.toString(),
                                                          markforreview: '1'
                                                      );
                                                      print("user answe ========  on eye true  =  ${currentQuestion.user_answer.toString()}");

                                                    }else{
                                                      // controller.Mark.value[index]=false;
                                                      // controller.questions[index]['markforreview']='0';
                                                      print("user_answer == else condition");
                                                      checkAns(
                                                          questions: currentQuestion,
                                                          userAnwer: currentQuestion.user_answer.toString(),
                                                          markforreview: '0'
                                                      );
                                                    }


                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: currentQuestion.markforreview.toString()=="1"?Colors.red:Colors.blue,
                                                        width: 1,
                                                      ),
                                                      borderRadius: BorderRadius.circular(00),

                                                    ),
                                                    //color: Colors.green,
                                                    height: 20,
                                                    width: 20,
                                                    child: Center(child: Icon(
                                                      Icons.remove_red_eye,
                                                      color: currentQuestion.markforreview.toString()=="1"?Colors.red:Colors.blue,
                                                      size: 16.0,
                                                      semanticLabel: 'Text to announce in accessibility modes',
                                                    ),),
                                                  ),
                                                ),
                                              ),




                                              Padding(
                                                padding: const EdgeInsets.only(left: 10.0,right: 00.0),
                                                child: InkWell(
                                                  onTap: (){
                                                    // controller.Question_Id.value;
                                                    Get.bottomSheet(
                                                      MyBottomSheet(id: currentQuestion.id),
                                                      backgroundColor: Colors.transparent,
                                                      isDismissible: false,
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    child: Center(
                                                      child:  Icon(
                                                        Icons.more_vert_outlined,
                                                        color: Colors.black,
                                                        size: 20.0,
                                                        semanticLabel: 'Text to announce in accessibility modes',
                                                      ),),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )


                                          //Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                                        ],
                                      ),

                                    ),
                                  ),

                                ],
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            Padding(
                              padding:  EdgeInsets.only(
                                  left: 15, right: 10),
                              child:

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  currentQuestion.question.toString().isNotEmpty?
                                  Text(
                                    currentQuestion.question.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ):
                                  Container(),

                                  currentQuestion.question_hindi.toString().isNotEmpty?
                                  Text(
                                    currentQuestion.question_hindi.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ):
                                  Container(),

                                  currentQuestion.question_image.toString().isNotEmpty?
                                  CachedNetworkImage(
                                      imageUrl:
                                      currentQuestion.question_image.toString()
                                  ):
                                  Container()



                                ],
                              ),
                            ),
                            if(currentQuestion.is_option_image.toString()=="0")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: ab.asMap().entries.map(
                                      (entry) {
                                    final index = entry.key;
                                    final option = entry.value;

                                    return  InkWell(
                                      onTap: ()  async {

                                        if(currentQuestion.user_answer.toString().isEmpty){
                                          HapticFeedback.selectionClick();

                                          checkAns(questions: currentQuestion,
                                              selectedIndex:  index ,
                                              userAnwer: '',
                                              markforreview: currentQuestion.markforreview.toString()
                                          );

                                        }else{
                                          HapticFeedback.selectionClick();
                                          checkAns(questions: currentQuestion,
                                              selectedIndex:  index ,
                                              userAnwer: '',
                                              markforreview: currentQuestion.markforreview.toString()
                                          );
                                        }

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(top: ColorValues.kDefaultPadding),
                                          padding: const EdgeInsets.only(left: 10.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: getTheRightColor(index)),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  color: getTheRightColor(index) == ColorValues.kGrayColor
                                                      ? Colors.transparent
                                                      : getTheRightColor(index),
                                                  borderRadius: BorderRadius.circular(50),
                                                  border: Border.all(color: getTheRightColor(index)),
                                                ),
                                                child: getTheRightColor(index) == ColorValues.kGrayColor
                                                    ? null
                                                    : Icon(getTheRightIcon(), size: 16),
                                              ),


                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      /* for(int i=0;i<ab.length;i++)
                                                              options_hindi.toString().isNotEmpty?
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                                                                child: Text(
                                                                  "${ab[i].toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ')}",
                                                                  overflow: TextOverflow.ellipsis,
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      color: Colors.black
                                                                  ),
                                                                ),
                                                                //child: HtmlWidget('${ab[i].toString()}'),
                                                              ):
                                                              Container(),*/


                                                      option.toString().isNotEmpty?
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                        child: Text(
                                                          "${option.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ')}",
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 5,
                                                          style: TextStyle(
                                                              color: Colors.black
                                                          ),
                                                        ),
                                                        //child: HtmlWidget('${ab[i].toString()}'),
                                                      ):
                                                      Container(),





                                                    ],),
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),



                            if(currentQuestion.is_option_image.toString()=="1")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: option_image.asMap().entries.map(
                                      (entry) {
                                    final index = entry.key;
                                    final option = entry.value;

                                    return  InkWell(
                                      onTap: ()  async {

                                        if(currentQuestion.user_answer.toString().isEmpty){
                                          HapticFeedback.selectionClick();
                                          checkAns(
                                              questions: currentQuestion,
                                              selectedIndex:  index ,
                                              userAnwer: '',
                                              markforreview: currentQuestion.markforreview.toString()
                                          );

                                        }else{
                                          HapticFeedback.selectionClick();
                                          checkAns(
                                              questions: currentQuestion,
                                              selectedIndex:  index ,
                                              userAnwer: '',
                                              markforreview: currentQuestion.markforreview.toString()
                                          );
                                        }

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(top: ColorValues.kDefaultPadding),
                                          padding: const EdgeInsets.only(left: 10.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: getTheRightColor(index)),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                  color: getTheRightColor(index) == ColorValues.kGrayColor
                                                      ? Colors.transparent
                                                      : getTheRightColor(index),
                                                  borderRadius: BorderRadius.circular(50),
                                                  border: Border.all(color: getTheRightColor(index)),
                                                ),
                                                child: getTheRightColor(index) == ColorValues.kGrayColor
                                                    ? null
                                                    : Icon(getTheRightIcon(), size: 16),
                                              ),


                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [

                                                      option.toString().isNotEmpty?
                                                      Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                          child:
                                                          Image.network(option,height: 50,width: 50,)

                                                      ):
                                                      Container(),

                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10.0),
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            showImageDialog(context,option);
                                                          },
                                                          child: Icon(
                                                            Icons.remove_red_eye,
                                                            color: Colors.black26,
                                                            size: 20.0,
                                                          ),
                                                        ),
                                                      ),



                                                    ],),
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),




                          ],
                        ),


                      ),
                    )

                  ],),
                )


              /* PageView.builder(
                        key: key,
                        onPageChanged: (value) {
                          print('value------------------${value}');
                          controller.CurruntQ.value= value;
                        },
                        controller: controller.pageController,
                        reverse: false,
                        itemCount: controller.questions_one.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext, index) {


                          controller.is_index.value=index;
                          controller.isLastQuestion1.value = controller.isLastQuestion(int.parse(controller.questions_one[index].id.toString()));

                          print('index-------------------------${controller.is_index.value}');
                          var ab=[];
                          var option_image=[];
                          var options_hindi=[];

                          try{

                            //  option_image.add(json.decode(controller.questions_one[index]['option_image']));
                            print('csd---------------------${json.decode(controller.questions_one[index].option_image.toString())}');


                            ab = json.decode(controller.questions_one[index].options.toString());
                            option_image = json.decode(controller.questions_one[index].option_image.toString());
                            options_hindi = json.decode(controller.questions_one[index].options_hindi.toString());
                            print('${index}--------------------------$ab');
                            print('option_image--------------------------$option_image');
                            print("user ans----------------------------${controller.questions_one[index].user_answer.toString()}");

                          }catch(e){
                            print(e);
                          }

                          return ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15))),
                                  margin: EdgeInsets.only(left: 12, right: 12),
                                  child:

                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 05,horizontal: 06),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [

                                            Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              elevation: 5,
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Obx(()=>
                                                   Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Q. ${index+1}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            color: Colors.green,
                                                            height: 20,
                                                            width: 20,
                                                            child: Center(child: Text('+${controller.marking_number.value}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold))),
                                                          ),



                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20.0),
                                                            child: InkWell(
                                                              onTap: (){

                                                                // print('mark------${controller.questions_one[index]['markforreview']}');
                                                                // controller.MarkForReview(questions: controller.questions_one[index],MarkForReview: '1',userAnwer: controller.questions_one[index]['user_answer'].toString(),);
                                                                controller.show.value = true;

                                                                if(controller.questions_one[index].markforreview.toString()=='0'&&controller.Mark.value[index]==false){
                                                                  // controller.questions[index]['markforreview']='1';
                                                                  print("user_answer == if condition");
                                                                  controller.Mark.value[index]=true;
                                                                  controller.checkAns(
                                                                      questions: controller.questions_one[index],
                                                                      userAnwer: controller.questions_one[index].user_answer.toString(),
                                                                      markforreview: '1'
                                                                  );
                                                                  print("user answe ========  on eye true  =  ${controller.questions_one[index].user_answer.toString()}");

                                                                }else{
                                                                  controller.Mark.value[index]=false;
                                                                  // controller.questions[index]['markforreview']='0';
                                                                  print("user_answer == else condition");
                                                                  controller.checkAns(
                                                                      questions: controller.questions_one[index],
                                                                      userAnwer: controller.questions_one[index].user_answer.toString(),
                                                                      markforreview: '0'
                                                                  );
                                                                }


                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                    color: controller.questions_one[index].markforreview.toString()=="1"||controller.Mark.value[index]==true?Colors.red:Colors.blue,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(00),

                                                                ),
                                                                //color: Colors.green,
                                                                height: 20,
                                                                width: 20,
                                                                child: Center(child: Icon(
                                                                  Icons.remove_red_eye,
                                                                  color: controller.questions_one[index].markforreview.toString()=="1"||controller.Mark.value[index]==true?Colors.red:Colors.blue,
                                                                  size: 16.0,
                                                                  semanticLabel: 'Text to announce in accessibility modes',
                                                                ),),
                                                              ),
                                                            ),
                                                          ),




                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 10.0,right: 00.0),
                                                            child: InkWell(
                                                              onTap: (){
                                                                // controller.Question_Id.value;
                                                                Get.bottomSheet(
                                                                  MyBottomSheet(id: controller.questions_one[index].id),
                                                                  backgroundColor: Colors.transparent,
                                                                  isDismissible: false,
                                                                );
                                                              },
                                                              child: Container(
                                                                height: 20,
                                                                child: Center(
                                                                  child:  Icon(
                                                                    Icons.more_vert_outlined,
                                                                    color: Colors.black,
                                                                    size: 20.0,
                                                                    semanticLabel: 'Text to announce in accessibility modes',
                                                                  ),),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )


                                                      //Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),

                                      Padding(
                                        padding:  EdgeInsets.only(
                                            left: 15, right: 10),
                                        child:

                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            controller.questions_one[index].question.toString().isNotEmpty?
                                            Text(
                                              controller.questions_one[index].question.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ):
                                            Container(),

                                            controller.questions_one[index].question_hindi.toString().isNotEmpty?
                                            Text(
                                              controller.questions_one[index].question_hindi.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ):
                                            Container(),

                                            controller.questions_one[index].question_image.toString().isNotEmpty?
                                            CachedNetworkImage(
                                                imageUrl:
                                                controller.questions_one[index].question_image.toString()
                                            ):
                                            Container()



                                          ],
                                        ),
                                      ),

                                      if(controller.questions_one[index].is_option_image.toString()=="0")
                                        ...List.generate(
                                            ab.length,
                                                (i) => GetBuilder<TestController>(
                                                init: TestController(),
                                                builder: (qnController) {
                                                  Color getTheRightColor() {


                                                    print('i--------------${i.toString()}');
                                                    print('user_answer--------------${qnController.questions_one[index].user_answer.toString()}');

                                                    if(i.toString() == qnController.questions_one[index].user_answer.toString()){
                                                      print('cooloreeeeeee------------$index');
                                                      return  ColorValues.kGreenColor;
                                                    }


                                                    return ColorValues.kGrayColor;
                                                  }

                                                  IconData getTheRightIcon() {
                                                    return *//*getTheRightColor() == ColorValues.kRedColor ? Icons.close :*//* Icons.done;
                                                  }

                                                  return InkWell(
                                                    onTap: ()  async {
                                                      controller.show.value = false;
                                                      if(controller.questions_one[index].user_answer.toString().isEmpty){
                                                        HapticFeedback.selectionClick();

                                                        controller.checkAns(questions: controller.questions_one[index],
                                                            selectedIndex:  i ,
                                                            userAnwer: '',
                                                            markforreview: controller.questions_one[index].markforreview.toString()
                                                        );

                                                      }else{
                                                        HapticFeedback.selectionClick();
                                                        controller.checkAns(questions: controller.questions_one[index],
                                                            selectedIndex:  i ,
                                                            userAnwer: '',
                                                            markforreview: controller.questions_one[index].markforreview.toString()
                                                        );
                                                      }

                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        margin: const EdgeInsets.only(top: ColorValues.kDefaultPadding),
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: getTheRightColor()),
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration: BoxDecoration(
                                                                color: getTheRightColor() == ColorValues.kGrayColor
                                                                    ? Colors.transparent
                                                                    : getTheRightColor(),
                                                                borderRadius: BorderRadius.circular(50),
                                                                border: Border.all(color: getTheRightColor()),
                                                              ),
                                                              child: getTheRightColor() == ColorValues.kGrayColor
                                                                  ? null
                                                                  : Icon(getTheRightIcon(), size: 16),
                                                            ),


                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 10.0),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    ab[i].toString().isNotEmpty?
                                                                    Padding(
                                                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                                      child: Text(
                                                                        "${ab[i].toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ')}",
                                                                        overflow: TextOverflow.ellipsis,
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                            color: Colors.black
                                                                        ),
                                                                      ),
                                                                      //child: HtmlWidget('${ab[i].toString()}'),
                                                                    ):
                                                                    Container(),

                                                                    options_hindi[i].toString().isNotEmpty?
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                                                                      child: Text(
                                                                        "${options_hindi[i].toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ')}",
                                                                        overflow: TextOverflow.ellipsis,
                                                                        maxLines: 2,
                                                                        style: TextStyle(
                                                                            color: Colors.black
                                                                        ),
                                                                      ),
                                                                      //child: HtmlWidget('${ab[i].toString()}'),
                                                                    ):
                                                                    Container()



                                                                  ],),
                                                              ),
                                                            )

                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                        ),


                                      if(controller.questions_one[index].is_option_image.toString()=="1")
                                        ...List.generate(
                                            option_image.length,
                                                (i) => GetBuilder<TestController>(
                                                init: TestController(),
                                                builder: (qnController) {
                                                  Color getTheRightColor() {


                                                    print('i--------------${i.toString()}');
                                                    print('user_answer--------------${qnController.questions_one[index].user_answer.toString()}');

                                                    if(i.toString() == qnController.questions_one[index].user_answer.toString()){
                                                      print('cooloreeeeeee------------$index');
                                                      return  ColorValues.kGreenColor;
                                                    }


                                                    return ColorValues.kGrayColor;
                                                  }

                                                  IconData getTheRightIcon() {
                                                    return *//*getTheRightColor() == ColorValues.kRedColor ? Icons.close :*//* Icons.done;
                                                  }

                                                  return InkWell(
                                                    onTap: ()  async {
                                                      controller.show.value= false;
                                                      if(controller.questions_one[index].user_answer.toString().isEmpty){
                                                        HapticFeedback.selectionClick();
                                                        controller.checkAns(
                                                            questions: controller.questions_one[index],
                                                            selectedIndex:  i ,
                                                            userAnwer: '',
                                                            markforreview: controller.questions_one[index].markforreview.toString()
                                                        );

                                                      }else{
                                                        HapticFeedback.selectionClick();
                                                        controller.checkAns(
                                                            questions: controller.questions_one[index],
                                                            selectedIndex:  i ,
                                                            userAnwer: '',
                                                            markforreview: controller.questions_one[index].markforreview.toString()
                                                        );
                                                      }

                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        margin: const EdgeInsets.only(top: ColorValues.kDefaultPadding),
                                                        padding: const EdgeInsets.only(left: 10.0),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: getTheRightColor()),
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration: BoxDecoration(
                                                                color: getTheRightColor() == ColorValues.kGrayColor
                                                                    ? Colors.transparent
                                                                    : getTheRightColor(),
                                                                borderRadius: BorderRadius.circular(50),
                                                                border: Border.all(color: getTheRightColor()),
                                                              ),
                                                              child: getTheRightColor() == ColorValues.kGrayColor
                                                                  ? null
                                                                  : Icon(getTheRightIcon(), size: 16),
                                                            ),


                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 10.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [

                                                                    option_image[i].toString().isNotEmpty?
                                                                    Padding(
                                                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                                                        child:
                                                                        Image.network(option_image[i],height: 50,width: 50,)
                                                                      *//*  Text(
                                                                            "${ab[i].toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ')}",
                                                                            overflow: TextOverflow.ellipsis,
                                                                            maxLines: 2,
                                                                            style: TextStyle(
                                                                                color: Colors.black
                                                                            ),
                                                                          ),*//*
                                                                      //child: HtmlWidget('${ab[i].toString()}'),
                                                                    ):
                                                                    Container(),

                                                                    Padding(
                                                                      padding: const EdgeInsets.only(right: 10.0),
                                                                      child: GestureDetector(
                                                                        onTap: (){
                                                                          showImageDialog(context,option_image[i]);
                                                                        },
                                                                        child: Icon(
                                                                          Icons.remove_red_eye,
                                                                          color: Colors.black26,
                                                                          size: 20.0,
                                                                        ),
                                                                      ),
                                                                    ),



                                                                  ],),
                                                              ),
                                                            )

                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                        ),


                                    ],
                                  ),


                                ),
                              )
                            ],
                          );
                        }),*/
            ),
            Expanded(
              flex: 1,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  InkWell(
                    onTap: (){
                      print('-------------------------------nnagative');
                      showPrevQuestion();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(Icons.arrow_back),
                        ),
                        Text(
                          'Prev',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),


                  if(currentQuestionIndex.value==questions_one.length-1)
                    InkWell(
                      onTap: (){
                        var data={
                          'cochingId':cochingId.toString(),
                          'seriesId':seriesId.toString(),
                          'instruction':instruction.toString(),
                          'time':time.toString(),
                          'passing_value':passing_value.toString(),
                          'total_number_of_question':total_number_of_question.toString(),
                          'negative_marking_number':negative_marking_number.toString(),
                          'negative_marking':negative_marking.toString(),
                          'payment_type':payment_type.toString(),
                          'subject_name':subject_name.toString(),
                          'title':title.toString(),
                          'show_result':show_result.toString(),
                          'duration':duration.toString(),
                          'date':date.toString(),
                          'marking_number':marking_number.toString(),
                          'payment_amount':payment_amount.toString(),
                          'total_mark':total_mark.toString(),
                        };
                        Get.toNamed(Routes.QUESTION_DETAILS,parameters: data)!.then((result) async{
                          print('result----${result[0]['backValue']}');

                          currentQuestion_number.value=int.parse(result[0]['backValue'].toString())+1;
                          currentQuestionIndex.value=int.parse(result[0]['backValue'].toString());
                          await fetchQuizzes(int.parse(result[0]['backValue'].toString()));


                          /* controller.pageController.animateToPage(
                          int.parse(result[0]['backValue']),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );*/

                        });
                        //Submit_exam(questions_one: questions_one,remenning_time: '');
                      },
                      child: Row(
                        children: [
                          Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ),

                  if(currentQuestionIndex.value!=questions_one.length-1)
                    InkWell(
                      onTap: (){
                        print('------------ controller.isLastQuestion1.valu=--------------${ isLastQuestion1.value}');
                        showNextQuestion();
                      },
                      child: Row(
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ),



                ],
              ),




            ),
          ],
        );
      }


    }

    })



    )
        );





  }
   void showImageDialog(BuildContext context,IMAGE) {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           title: Text(''),
           content: CachedNetworkImage(
               imageUrl:IMAGE), // Replace with your image URL
           actions: [
             TextButton(
               child: Text('Close'),
               onPressed: () {
                 Navigator.of(context).pop();
               },
             ),
           ],
         );
       },
     );
   }

}
