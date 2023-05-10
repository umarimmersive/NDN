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
        centerTitle: true,
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
            child:  Text(
              'data'
            ),


          )

        ],

      )

    );

  }
}
