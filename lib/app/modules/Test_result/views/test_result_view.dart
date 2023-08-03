import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/constants/ColorValues.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Pre_onlineTest_instruction/views/BottomBarWithButton.dart';
import '../controllers/test_result_controller.dart';

class TestResultView extends GetView<TestResultController> {
  const TestResultView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Get.offAndToNamed(Routes.DESHBOARD);
         return true;
      },
      child: Obx(()=>
         Scaffold(
            bottomNavigationBar: BottomBarWithButton(
              buttonText: "View Solution",
              onPressed: () {

                Get.toNamed(Routes.TEST_RESULT_LIST);
                // Do something when button is pressed
              },
            ),
          appBar: AppBar(
            title:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${controller.tital.value}'),
                Text('${controller.subject_name.value}',style: TextStyle(fontSize: 14)),
              ],
            ),
            centerTitle: false,
          ),
          body:  Column(
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 06.0,vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text('Score',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                //Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                                SizedBox(
                                  height: MediaQuery.of(context).size.height/60,
                                ),
                                Text('${controller.total_score.value}',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height/80,
                                ),
                                Text('OUT OF ${controller.total_question.value}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),

                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                  child: new LinearPercentIndicator(
                                    width: MediaQuery.of(context).size.width -  80,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 2000,
                                    percent: double.parse(controller.accuracy.value.toString()),
                                    //center: Text("${controller.accuracy.value}%",style: TextStyle(color: Colors.white)),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.lightBlue,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.lightBlue,
                                      radius: 10,
                                      child: Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                        size: 14.0,
                                      ),
                                    ),

                                    SizedBox(
                                      width: 05,
                                    ),
                                    Text('${controller.total_time.value} Min',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                  ],),

                                SizedBox(
                                  height: MediaQuery.of(context).size.height/30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: Text(
                                      '${controller.accuracy2.value}% ACCURACY',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.lightBlue,
                                              radius: 16,
                                              child: Icon(
                                                Icons.question_mark,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            ),

                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('Total Questions',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                          ],),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('${controller.total_question.value}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                          ],),
                                      )

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.green,
                                              radius: 16,
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('Correct Answer',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                          ],),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('${controller.right_answer.value}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                          ],),
                                      )

                                    ],
                                  ),
                                ),
                                /* Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.,
                              children: [
                                Expanded(
                                  flex: 2 ,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.deepPurple,
                                        radius: 16,
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                      ),

                                      SizedBox(
                                        width: 05,
                                      ),
                                      Text('Marked for Review',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                    ],),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('0',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                    ],),
                                )

                              ],
                            ),
                          ),*/

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 16,
                                              child: Icon(
                                                Icons.cancel_presentation_outlined,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            ),

                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('Incorrect Answers',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                          ],),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('${controller.wrong_answer.value}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                          ],),
                                      )

                                    ],
                                  ),
                                ),

                               /* Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.orangeAccent,
                                              radius: 16,
                                              child: Icon(
                                                Icons.ac_unit,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            ),

                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('Partially Corrent Answers',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                          ],),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('00',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                          ],),
                                      )

                                    ],
                                  ),
                                ),*/

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              radius: 16,
                                              child: Icon(
                                                Icons.error_outline,
                                                color: Colors.white,
                                                size: 24.0,
                                              ),
                                            ),

                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('Unattempted Question',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                          ],),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('${controller.skip_answer.value}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                                          ],),
                                      )

                                    ],
                                  ),
                                ),



                                /*  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Explanation',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
              ),*/




                                /* Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(

                                onPressed: () {

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40.0,right:40 ),
                                  child: Text('Share on Whatsapp'),
                                ),
                              ),
                            ],
                          ),*/

                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
                                  child: InkWell(
                                    onTap: (){
                                      print('-------');
                                      var whatsappUrl = "https://wa.me/?text=Hey buddy, try this super cool new app!";
                                      // "whatsapp:";
                                      // "whatsapp://send?phone=8575785855";
                                      try {
                                        launch(whatsappUrl);
                                      } catch (e) {
                                        //To handle error and display error message
                                      }
                                      //shareFile();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:  Colors.green,
                                        borderRadius: BorderRadius.circular(08),
                                      ),
                                      // color: Colors.green,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 40,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset('assets/icons/whatsapp.png',height: 20,width: 20,),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Share on Whatsapp',
                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            ],

          )
        ),
      ),
    );
  }

}
