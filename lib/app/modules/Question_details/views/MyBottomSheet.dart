import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/routes/app_pages.dart';
import '../../Test/controllers/TestController.dart';
import '../controllers/question_details_controller.dart';

class MyBottomSheet extends StatefulWidget {
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  final List<bool> checkedOptions = [false, false, false];
  final QuestionDetailsController controller = Get.find();
  final TestController controller1 = Get.find();


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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Submit Test',
                      style: TextStyle(fontSize: 20),
                    ),
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
            Divider(
              height: 1,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
              child: Text(
                'Are you sure you want to end this time?',
                style: TextStyle(fontSize: 16),
              ),
            ),


           /* Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          radius: 16,
                          child: Icon(
                            Icons.access_time_outlined,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),

                        SizedBox(
                          width: 10,
                        ),
                        Text('Time Remaining',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                      ],),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('01:00:00',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                      ],),
                  )

                ],
              ),
            ),
*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.,
                children: [
                  Expanded(
                    flex: 1,
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
                        Text('${controller.total_number_of_question.value}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
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
                    flex: 1,
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
                        Text('Right Answer',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                      ],),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${controller.answer.value}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
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
                          width: 10,
                        ),
                        Text('Marked for Review',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
                      ],),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${controller.markReview.value}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300, color: Colors.black,)),
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




            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async{

                   await controller1.Submit_exam(remenning_time: '',questions_one: controller1.questions_one);

                   controller.markReview.value=0;
                   controller.answer.value=0;
                   controller.Notanswer.value=0;
                   controller.MarkAndAnswer.value=0;
                   controller.questions_one.clear();
                   print('--------------------------clear done all');

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0,right:40 ),
                    child: Text('Submit Test'),
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
