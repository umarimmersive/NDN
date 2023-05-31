import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import 'package:get/get.dart';
import 'package:national_digital_notes_new/constants.dart';
import 'package:national_digital_notes_new/models/Questions_model.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import '../../../../constants.dart';
import '../../../../constants.dart';
import '../../../../utils/constants/ColorValues.dart';
import '../controllers/TestController.dart';
import 'MyBottomSheet.dart';
import 'MyBottomSheet2.dart';
import 'MyBottomSheet3.dart';
import 'MyBottomSheet4.dart';

class Test_view extends GetView<TestController> {
   Test_view({Key? key}) : super(key: key);
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
     controller.Submit_exam(questions_one: controller.questions_one,remenning_time: controller.Remenning_time.value);


     // If the difference is less than 2 seconds, exit the app.
     return false;
   }

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      /*onWillPop: ()async{

        if(Navigator.of(context).canPop()) {
          Get.bottomSheet(
            MyBottomSheet4(),
            backgroundColor: Colors.transparent,
            isDismissible: false,
          );
          return false;
        }else if(controller.currentBackPressTime == null ||    now.difference(controller.currentBackPressTime!) > Duration(seconds: 2)){
          print('--------------');
          Get.toNamed(Routes.TEST_RESULT);
          return true;
        }
        return true;
      },*/



     /* onWillPop: () async (){
      Get.bottomSheet(
        MyBottomSheet2(),
        backgroundColor: Colors.transparent,
        isDismissible: false,
      );*/

      child: Scaffold(
        appBar: AppBar(
          title:  Text('${controller.subject_name.value}',style: TextStyle(fontSize: 16)),

          //backgroundColor: Colors.redAccent,
          actions: [
            PopupMenuButton(

               icon: InkWell(
                 onTap: (){
                   Get.bottomSheet(
                     MyBottomSheet3(),
                     backgroundColor: Colors.transparent,
                     isDismissible: false,
                   );
                 },
                 child: Icon(
                   Icons.info_outline,
                   color: Colors.white,
                   size: 24.0,
                   semanticLabel: 'Text to announce in accessibility modes',
                 ),
               ),
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
                itemBuilder: (context){
                  return [

                  ];
                },
                onSelected:(value){
                  if(value == 0){
                    print("My account menu is selected.");
                  }else if(value == 1){
                    print("Settings menu is selected.");
                  }else if(value == 2){
                    print("Logout menu is selected.");
                  }
                }
            ),
            PopupMenuButton(
              // add icon, by default "3 dot" icon
                icon: InkWell(
                    onTap: (){
                      var data={
                        'cochingId':controller.cochingId.toString(),
                        'seriesId':controller.seriesId.toString(),
                        'instruction':controller.instruction.toString(),
                        'time':controller.time.toString(),
                        'passing_value':controller.passing_value.toString(),
                        'total_number_of_question':controller.total_number_of_question.toString(),
                        'negative_marking_number':controller.negative_marking_number.toString(),
                        'negative_marking':controller.negative_marking.toString(),
                        'payment_type':controller.payment_type.toString(),
                        'subject_name':controller.subject_name.toString(),
                        'title':controller.title.toString(),
                        'show_result':controller.show_result.toString(),
                        'duration':controller.duration.toString(),
                        'date':controller.date.toString(),
                        'marking_number':controller.marking_number.toString(),
                        'payment_amount':controller.payment_amount.toString(),
                        'total_mark':controller.total_mark.toString(),
                      };

                      Get.toNamed(Routes.QUESTION_DETAILS,parameters: data)!.then((result) {
                        print('result----${result[0]['backValue']}');
                        controller.pageController.animateToPage(
                          int.parse(result[0]['backValue']),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );

                      });


                     // Get.toNamed(Routes.QUESTION_DETAILS,parameters: data);

                  /*Get.bottomSheet(
                    MyBottomSheet(),
                    backgroundColor: Colors.transparent,
                    isDismissible: false,
                  );*/
                },child: Icon(Icons.menu)),
                itemBuilder: (context){
                  return [

                  ];
                },
                onSelected:(value){

                }
            ),
          ],
        ),
        body: Obx((){
          if(controller.isLoading.isTrue){
            return Center(child: CupertinoActivityIndicator());
          }else{
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Expanded(
                  child: PageView.builder(

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

                        print('truefalse----------${controller.questions_one[index]['markforreview'].toString()=="0"}');
                        // controller.UserAnswer[index].text=controller.questions[index]['user_answer'].toString();
                        var mark=controller.questions_one[index]['markforreview'].toString();
                        var ab=[];
                        var options_hindi=[];
                        try{
                          ab = json.decode(controller.questions_one[index]['options']);
                          options_hindi = json.decode(controller.questions_one[index]['options_hindi']);
                          print('${index}--------------------------$ab');

                          print("user ans----------------------------${controller.questions_one[index]['user_answer']}");

                        }catch(e){
                          print(e);
                        }

                        return ListView(
                          children: [


                            Card(
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
                                        /*Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                      size: 24.0,
                                      semanticLabel: 'Text to announce in accessibility modes',
                                    ),
                                    Text('Pre Test Series',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                    //Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.black,
                                      size: 24.0,
                                      semanticLabel: 'Text to announce in accessibility modes',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),*/
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
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
                                                      padding: const EdgeInsets.only(left: 10.0,right: 05),
                                                      child: Icon(
                                                        Icons.watch_later_outlined,
                                                        color: Colors.black,
                                                        size: 20.0,
                                                        semanticLabel: 'Text to announce in accessibility modes',
                                                      ),

                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 5.0,left: 00,right: 00),
                                                      child: Container(
                                                        width: 80,
                                                        child: TimerCountdown(

                                                          onEnd: (){

                                                            controller.Submit_exam(questions_one: controller.questions_one,remenning_time: controller.Remenning_time.value);
                                                          },
                                                          spacerWidth: 1,
                                                          enableDescriptions: false,
                                                          format: CountDownTimerFormat.hoursMinutesSeconds,
                                                          endTime: DateTime.now().add(
                                                              Duration(
                                                                hours: int.parse(controller.duration2.value.toString().substring(0,2)),
                                                                minutes: int.parse(controller.duration2.value.toString().substring(3,5)),
                                                                seconds: 00,
                                                              )),
                                                        ),
                                                      )
                                                    ),

                                                  /*  controller.MarkLoading.isTrue?
                                                        CupertinoActivityIndicator():*/


                                                       Padding(
                                                        padding: const EdgeInsets.only(left: 20.0),
                                                        child: InkWell(
                                                          onTap: (){

                                                           // print('mark------${controller.questions_one[index]['markforreview']}');
                                                           // controller.MarkForReview(questions: controller.questions_one[index],MarkForReview: '1',userAnwer: controller.questions_one[index]['user_answer'].toString(),);

                                                            if(controller.questions_one[index]['markforreview'].toString()=='0'||controller.marklist[index]==false){
                                                              //controller.questions_one[index]['markforreview']='1';
                                                              print('----------------------------------0000000000000000');
                                                              controller.marklist[index]=true;
                                                              controller.checkAns(questions: controller.questions_one[index],userAnwer: controller.questions_one[index]['user_answer'].toString(),markforreview: '1');
                                                            }else{
                                                              controller.marklist[index]=false;
                                                              //controller.questions_one[index]['markforreview']='0';
                                                              print('----------------------------------11111111111111');
                                                              controller.checkAns(questions: controller.questions_one[index],userAnwer: controller.questions_one[index]['user_answer'].toString(),markforreview: '0');
                                                            }


                                                          /*  Get.bottomSheet(
                                                              MyBottomSheet2(),
                                                              backgroundColor: Colors.transparent,
                                                              isDismissible: false,
                                                            );*/
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                color: Colors.blue,
                                                                width: 1,
                                                              ),
                                                              borderRadius: BorderRadius.circular(00),

                                                            ),
                                                            //color: Colors.green,
                                                            height: 20,
                                                            width: 20,
                                                            child: Center(child: Icon(
                                                              Icons.remove_red_eye,
                                                              color: controller.questions_one[index]['markforreview'].toString()=='1'||controller.marklist[index]==false?Colors.blue:Colors.white,
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
                                                            MyBottomSheet(id: controller.questions_one[index]['id']),
                                                            backgroundColor: Colors.transparent,
                                                            isDismissible: false,
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 20,
                                                          child: Center(child: Icon(
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
                                        controller.questions_one[index]['question'].toString().isNotEmpty?
                                             Text(
                                          controller.questions_one[index]['question'].toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ):
                                            Container(),

                                        controller.questions_one[index]['question_hindi'].toString().isNotEmpty?
                                           Text(
                                          controller.questions_one[index]['question_hindi'].toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' '),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ):
                                            Container()

                                      ],
                                    ),

                                  ),


                                  ...List.generate(
                                      ab.length,
                                          (i) => GetBuilder<TestController>(
                                          init: TestController(),
                                          builder: (qnController) {
                                            Color getTheRightColor() {


                                              print('i--------------${i.toString()}');
                                              print('user_answer--------------${qnController.questions_one[index]['user_answer'].toString()}');

                                              if(i.toString() == qnController.questions_one[index]['user_answer'].toString()){
                                                print('cooloreeeeeee------------$index');
                                                return  ColorValues.kGreenColor;
                                              }


                                              return ColorValues.kGrayColor;
                                            }

                                            IconData getTheRightIcon() {
                                              return /*getTheRightColor() == ColorValues.kRedColor ? Icons.close :*/ Icons.done;
                                            }

                                            return InkWell(
                                              onTap: ()  async {
                                                if(controller.questions_one[index]['user_answer'].toString().isEmpty){
                                                  HapticFeedback.selectionClick();
                                                  controller.checkAns(questions: controller.questions_one[index],selectedIndex:  i ,userAnwer: '');

                                                }else{
                                                  HapticFeedback.selectionClick();
                                                  controller.checkAns(questions: controller.questions_one[index],selectedIndex:  i ,userAnwer: '');
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


                                ],
                              ),


                            )
                          ],
                        );
                      }),
                )
              ],
            );
          }
        }

        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  controller.pageController.previousPage(
                      duration: Duration(microseconds: 500),
                      curve: Curves.easeIn);
                },
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed:(){
                        controller.pageController.previousPage(
                            duration: Duration(microseconds: 300),
                            curve: Curves.easeIn);
                      }
                    ),
                    Text(
                      'Prev',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  controller.nextQuestion();
                  /*controller.userAnswers.length < controller.questions.length
                      ? () {
                    controller.userAnswers.add(-1);
                  }
                      : null;*/
                },
                child: Row(
                  children: [
                    Text(
                      'Save & Next',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: (){

                      }
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
