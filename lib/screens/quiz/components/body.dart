import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../controllers/question_controller.dart';
import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});



  @override
  Widget build(BuildContext context) {
    // So that we have acccess our controller
    QuestionController questionController = Get.put(QuestionController());
    return Scaffold(

      backgroundColor: Colors.grey.shade200,
     body:         SafeArea(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const Padding(
             padding:
             EdgeInsets.symmetric(horizontal: kDefaultPadding),
             child: ProgressBar(),
           ),
           const SizedBox(height: kDefaultPadding),
           Padding(
             padding:
             const EdgeInsets.symmetric(horizontal: kDefaultPadding),
             child: Obx(
                   () => Text.rich(
                 TextSpan(
                   text:
                   "Question ${questionController.questionNumber.value}/${questionController.questions.length}",

                     style: TextStyle(
                     color: Colors.blue,
                     fontSize: 18
                 ),

                 ),
               ),
             ),
           ),
           const Divider(thickness: 1.5),
           const SizedBox(height: kDefaultPadding),
           Expanded(
             child: PageView.builder(
               // Block swipe to next qn
               physics: const NeverScrollableScrollPhysics(),
               controller: questionController.pageController,
               onPageChanged: questionController.updateTheQnNum,
               itemCount: questionController.questions.length,
               itemBuilder: (context, index) => QuestionCard(
                   question: questionController.questions[index]),
             ),
           ),
         ],
       ),
     )
      ,
    );
  }
}
