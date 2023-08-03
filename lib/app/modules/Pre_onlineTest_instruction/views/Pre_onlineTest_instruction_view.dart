import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
            var data={
              'cochingId':controller.cochingId.value.toString(),
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
            /*var data={
              'seriesId':controller.seriesId.toString()
            };*/
            Get.offAndToNamed(Routes.PRE_ONLINETEST_INSTRUCTION2,parameters: data);
            // Do something when button is pressed
          },
        ),
      appBar: AppBar(
        title:  Text('${controller.title.value +', '+ controller.subject_name.value}',style: TextStyle(fontSize: 16)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 5),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('General Instructions',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        //Text('Result',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                    child:
                    Html(
                      data: '${controller.instruction.value}',
                      extensions: [
                        TagExtension(
                          tagsToExtend: {"flutter"},
                          child: const FlutterLogo(),
                        ),
                      ],
                      style: {
                        "p.fancy": Style(
                          textAlign: TextAlign.start,
                          padding: HtmlPaddings.all(0),
                          //padding:  EdgeInsets.all(16),
                          backgroundColor: Colors.grey,
                          //margin: Margins(left: Margin(50, Unit.px), right: Margin.auto()),
                          width: Width(300, Unit.px),
                          fontWeight: FontWeight.bold,
                        ),
                      },
                    )

                    /*Html(
                      data: '${controller.instruction.value.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ')}',
                    )*/
                    /*Text(
                      '${controller.instruction.value.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ')}'
                    ),*/
                  ),

                ],
              ),
            ),
          )

        ],

      )

    );

  }
}
