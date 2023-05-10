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
        title: const Text('TestListView'),
        centerTitle: true,
      ),
      body: Obx(() => Column(
        children: [
          Expanded(
            flex: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Test Series 1',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
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
