import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/dashboard_screen/Home_view.dart';
import '../../constants.dart';
import '../../controllers/question_controller.dart';
import '../../views/dashboard/views/dashboard_view.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 4)).then((value) {
      Get.offAll(DashboardView());
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    QuestionController qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const Spacer(flex: 3),
              Text(
                "Score",
                style:TextStyle(
                  color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold
                ),
              ),
              const Spacer(),
              Text(
                "${qnController.numOfCorrect_Ans * 10}/${qnController.questions.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kSecondaryColor),
              ),
              const Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
