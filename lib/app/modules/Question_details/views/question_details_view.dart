import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:national_digital_notes_new/app/modules/Question_details/views/MyBottomSheet.dart';

import '../../../../utils/routes/app_pages.dart';
import '../../Pre_onlineTest_instruction/views/BottomBarWithButton.dart';
import '../controllers/question_details_controller.dart';

class QuestionDetailsView extends GetView<QuestionDetailsController> {
  const QuestionDetailsView({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        bottomNavigationBar: BottomBarWithButton(
          buttonText: "Submit Test",
          onPressed: () {
            Get.bottomSheet(
              MyBottomSheet(),
              backgroundColor: Colors.transparent,
              isDismissible: false,
            );
            // Do something when button is pressed
          },
        ),
      appBar: AppBar(
        title: const Text('Back to Questions'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4 ,
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  elevation: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Question: 100',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                            //Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                              Icon(
                                Icons.bookmark_added,
                                color: Colors.lightBlue,
                                size: 20.0,
                              ),
                              SizedBox(
                                width: 05,
                              ),
                              Text('Section Intructions',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold, color: Colors.lightBlue,)),
                            ],)

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 00),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Button_red(1)
                                  ),
                                SizedBox(
                                  width: 05,
                                ),
                                Text('Not Answer',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300, color: Colors.lightBlue,)),
                              ],),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                              Padding(
                              padding: const EdgeInsets.all(10.0),
                                child: Button_green(12)
                            ),
                                SizedBox(
                                  width: 05,
                                ),
                                Text('Answer',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300, color: Colors.lightBlue,)),
                              ],),
                            )

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 00),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(children: [
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Button_purpal(12)
                                ),
                                SizedBox(
                                  width: 05,
                                ),
                                Text('Marked for Review',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300, color: Colors.lightBlue,)),
                              ],),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(children: [
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Button_box(1)
                                ),
                                SizedBox(
                                  width: 05,
                                ),
                                Text('Not Visited',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300, color: Colors.lightBlue,)),
                              ],),
                            )

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(children: [
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Button_red(1)
                                ),
                                SizedBox(
                                  width: 05,
                                ),
                                Text('Answer and Marked for Review',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300, color: Colors.lightBlue,)),
                              ],),
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

          Expanded(
            flex: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  elevation: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(child: Text('Back to Questions')),
                      ),

                      Divider(
                        height: 1,
                        color: Colors.black,
                      ),

                      Container(
                        height: MediaQuery.of(context).size.height/2.2,
                        child: new GridView.builder(

                          itemCount: 10,
                          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (orientation == Orientation.portrait) ? 5 : 3,),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Button_green(index)
                            );
                          },
                        ),
                      )
                     /* Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 16,
                          child: Text('1'),
                        ),
                      )*/
                    ],
                  ),
                ),

              ],
            ),
          ),

        ],

      )
    );
  }
  Widget Button_red(int index){
    return Container(
      height: 30,
      width: 30,
      color: Colors.red,
      child: Center(child: Text('$index',style: TextStyle(color: Colors.white))),
    );
  }
  Widget Button_green(int index){
    return Container(
      height: 30,
      width: 30,
      color: Colors.green,
      child: Center(child: Text('$index',style: TextStyle(color: Colors.white))),
    );
  }
  Widget Button_purpal(int index){
    return Container(
      height: 30,
      width: 30,
      color: Colors.deepPurple,
      child: Center(child: Text('$index',style: TextStyle(color: Colors.white))),
    );
  }

  Widget Button_box(int index){
    return Container(
      decoration: BoxDecoration(
        //color: const Color(0xff7c94b6),
        border: Border.all(
          width: 1,
        ),
        borderRadius: BorderRadius.circular(00),
      ),
      height: 30,
      width: 30,
      //color: Colors.deepPurple,
      child: Center(child: Text('$index',style: TextStyle(color: Colors.black))),
    );
  }

}
