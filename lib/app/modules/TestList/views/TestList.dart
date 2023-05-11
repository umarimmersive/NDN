import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/routes/app_pages.dart';
import '../controllers/TestList_controller.dart';
import 'ExamCard.dart';

class TestListView extends GetView<TestList_Controller> {
  const TestListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test List'),
        centerTitle: false,
      ),
      body: Obx(() => Column(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              elevation: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Test Series 1',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                              color: Colors.lightBlue,
                              width: 100,
                              height: 40,
                              child: Center(child: Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)))),
                        ),


                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 00.0,right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //Text('Test Series 1',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                              color: Colors.lightBlue,
                              width: 160,
                              height: 40,
                              child: Center(child: Text('Buy All Course',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white)))),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 8,
            child:  ListView.builder(
              itemCount: controller.exams.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: (){
                      Get.toNamed(Routes.PRE_ONLINETEST_INSTRUCTION);
                    },
                    child: ExamCard(exam: controller.exams[index]));
              },
            ),
          ),

        ],
      ))
    );
  }
}
