import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/routes/app_pages.dart';
import '../controllers/TestController.dart';
import 'MyBottomSheet.dart';
import 'MyBottomSheet2.dart';

class Test_view extends GetView<TestController> {
  const Test_view({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
        //backgroundColor: Colors.redAccent,
        actions: [

          PopupMenuButton(
             icon: Icon(
               Icons.error_outline,
               color: Colors.white,
               size: 24.0,
               semanticLabel: 'Text to announce in accessibility modes',
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
                    Get.toNamed(Routes.QUESTION_DETAILS);

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
      body: SafeArea(
        child:
           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: Column(
                    children: [
                      Column(
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
                                  Text('Test name-',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
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
                      ),
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
                              Text('Q.1',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    color: Colors.green,
                                    height: 20,
                                    width: 20,
                                    child: Center(child: Text('+2',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold))),
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
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Container(
                                      //color: Colors.green,
                                      height: 20,
                                      child: Center(child: Text('00:${controller.countdown.value}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: InkWell(
                                      onTap: (){
                                        Get.bottomSheet(
                                          MyBottomSheet2(),
                                          backgroundColor: Colors.transparent,
                                          isDismissible: false,
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(00),
                                        ),
                                        //color: Colors.green,
                                        height: 20,
                                        width: 20,
                                        child: Center(child: Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.green,
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
                                        Get.bottomSheet(
                                          MyBottomSheet(),
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
              ),
              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            final question = controller.questions[controller.userAnswers.length];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '1.'+question.text,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            );
                          }),
                          SizedBox(height: 16),
                          Obx(() {
                            final question = controller.questions[controller.userAnswers.length];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                question.options.length,
                                    (index) => RadioListTile(
                                  title: Text(question.options[index]),
                                  value: index,
                                  groupValue: controller.userAnswers.length > index ? controller.userAnswers[index] : null,
                                  onChanged: (value) {
                                    controller.setUserAnswer(controller.userAnswers.length, value!);
                                  },
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                controller.userAnswers.length > 0
                    ? () {
                  controller.userAnswers.removeLast();
                }
                    : null;
              },
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed:(){

                    }
                  ),
                  Text(
                    'Prev',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                controller.userAnswers.length < controller.questions.length
                    ? () {
                  controller.userAnswers.add(-1);
                }
                    : null;
              },
              child: Row(
                children: [
                  Text(
                    'Save & Next',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    );
  }

}
