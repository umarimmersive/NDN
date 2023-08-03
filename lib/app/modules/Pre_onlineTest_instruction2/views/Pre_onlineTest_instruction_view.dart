import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/global_widgets/snackbar.dart';
import 'package:vibration/vibration.dart';

import '../../../../utils/routes/app_pages.dart';
import '../controllers/Pre_onlineTest_instruction2_controller.dart';
import 'BottomBarWithButton.dart';

class Pre_onlineTest_instruction2_view extends GetView<Pre_onlineTest_instruction2_controller> {
  const Pre_onlineTest_instruction2_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomBarWithButton(
          buttonText: "Attempt Test",
          onPressed: () {
            if(controller.check1.isTrue){

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
                'duration2':controller.duration2.toString(),
              };
              Vibration.vibrate(duration: 1000);
              Get.offAndToNamed(Routes.TEST,parameters: data);
            }else{
              snackbar('Please Select Term And Condition');
            }

            // Do something when button is pressed
          },
        ),
      appBar: AppBar(
        title:  Text('${controller.title.value +', '+ controller.subject_name.value}',style: TextStyle(fontSize: 16)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 06.0,vertical: 10),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Column(
                      children: [
                        Icon(
                          Icons.help,
                          color: Colors.black,
                          size: 20.0,
                          semanticLabel: '',
                        ),
                        Text('${controller.total_number_of_question} Questions',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),

                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.black,
                          size: 20.0,
                          semanticLabel: '',
                        ),
                        Text('${controller.duration2} Hr',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),

                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 20.0,
                          semanticLabel: '',
                        ),
                        Text('${controller.total_mark.value} Marks',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),

                      ],
                    )
                    //
                    // Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(08.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('Test Sections',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          CircleAvatar(
                            child: Text('1'),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${controller.title.value+', '+controller.subject_name.value}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.help,
                                        color: Colors.black,
                                        size: 20.0,
                                        semanticLabel: '',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Text('${controller.total_number_of_question.value} Questions',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.black,
                                        size: 20.0,
                                        semanticLabel: '',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Text('${controller.total_mark.value} Marks',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),


                          // Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    SizedBox(height: 10,),
                    Divider(
                      height: 1,
                      color: Colors.black,
                    ),

                    SizedBox(height: 10,),
                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(()=>
                           Checkbox(
                              //only check box
                              value: controller.check1.value, //unchecked
                              onChanged: (bool? value){
                                //value returned when checkbox is clicked
                                /* setState(() {

                                      });*/
                                controller.check1.value = value!;

                              }
                          ),
                        ),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text('By accessing the content of Mock Test Master (here after referred to as website) you have to agree to the terms and conditions set out here in and also accept our Privacy Policy.',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300)),
                        )),

                      ],
                    ),

                  ],
                ),
              ),
            ),

          ],

        ),
      )

    );

  }
}
