import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/routes/app_pages.dart';
import '../controllers/Pre_onlineTest_instruction_controller.dart';
import 'BottomBarWithButton.dart';

class Pre_onlineTest_instruction_view extends GetView<Pre_onlineTest_instruction_controller> {
  const Pre_onlineTest_instruction_view({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomBarWithButton(
          buttonText: "Next",
          onPressed: () {
            Get.toNamed(Routes.PRE_ONLINETEST_INSTRUCTION2);
            // Do something when button is pressed
          },
        ),
      appBar: AppBar(
        title: const Text('Test Name-Instruction'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
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
                        Text('General Instruction',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        //Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 9,
            child:  Padding(
              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
              child: Text(
                "Guidelines and instructions for the Candidates for Online Examination "
                    "Online examination is being conducted for evaluating the students’ performance for August"
                "– 2020 Term-End Examination (TEE) for various courses."
                    "It is an Online Examination system, fully computerized, user friendly having advanced"
                  "security features making it fair, transparent and standardized."
                    "The term end examination will be conducted in an online proctored mode. Candidate can"
                  "take the test from the safe and secure environment of his/her home, with a"
              "desktop/laptop/smartphone (with a webcam) and an internet connection (un-interrupted"
              " internet speed is desirable)."
              ),
            ),


          )

        ],

      )

    );

  }
}
