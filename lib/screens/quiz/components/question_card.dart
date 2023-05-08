import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/question_controller.dart';
import '../../../models/Questions.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key,
    // it means we have to pass this
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());
    return Card(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              question.question,
          style: TextStyle(
              color: Colors.black,
                fontSize: 16
               ),
            ),
            const SizedBox(height: kDefaultPadding / 2),
            ...List.generate(
              question.options.length,
              (index) => Option(
                index: index,
                text: question.options[index],
                press: () => controller.checkAns(question, index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
