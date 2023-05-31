import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/dashboard_screen/controller_home_view.dart';

import '../../../../utils/constants/ColorValues.dart';
import '../../../../utils/global_widgets/textfield_ui.dart';
import '../controllers/TestController.dart';

class MyBottomSheet3 extends StatefulWidget {
  @override
  _MyBottomSheet3State createState() => _MyBottomSheet3State();
}

class _MyBottomSheet3State extends State<MyBottomSheet3> {
  final TestController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            30,
          ),
          topLeft: Radius.circular(
            30,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${controller.title.value+', '+controller.subject_name.value}',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child: Divider(
                height: 1,
                color: Colors.black,
              ),
            ),
            Padding(
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
                      Text('${controller.total_number_of_question.value} Questions',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),

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
                      Text('${controller.duration2.value} Hr',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),

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
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child: Divider(
                height: 1,
                color: Colors.black,
              ),
            ),
            Padding(
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

                 // SizedBox(height: 10,),
                  //

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    // Get.back(result: checkedOptions);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0,right: 40.0),
                    child: Text('Back to test'),
                  ),
                ),
              ],
            ),
          ],

        ),
      ),
    );
  }
}
