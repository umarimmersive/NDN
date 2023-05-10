import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/routes/app_pages.dart';
import '../controllers/Pre_onlineTest_instruction2_controller.dart';
import 'BottomBarWithButton.dart';

class Pre_onlineTest_instruction2_view extends GetView<Pre_onlineTest_instruction2_controller> {
  const Pre_onlineTest_instruction2_view({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomBarWithButton(
          buttonText: "Attemt Test",
          onPressed: () {
            Get.toNamed(Routes.TEST);
            // Do something when button is pressed
          },
        ),
      appBar: AppBar(
        title: const Text('Test Name-Instruction2'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
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
                      Text('100 Question(s)',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),

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
                      Text('2 hours',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),

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
                      Text('200 Marks',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),

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
              borderRadius: BorderRadius.circular(0.0),
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

                        ),


                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pre Test Series 2023 FTD',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

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
                                      child: Text('100 Questions',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
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
                                      child: Text('200 Marks',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
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
                      Expanded(child: Text('By accessing the content of Mock Test Master (hereafter referred to as website) you have to agree to the terms and conditions set out herein and also accept our Privacy Policy.',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),

                    ],
                  ),

                ],
              ),
            ),
          ),

        ],

      )

    );

  }
}
