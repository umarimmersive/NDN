import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/inshort/inshort.dart';

import '../../constants.dart';
import '../../controllers/question_controller.dart';
import 'components/progress_bar.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuestionController questionController = Get.put(QuestionController());
  QuestionController controller = Get.put(QuestionController());

  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterRight = ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft = ConfettiController(duration: const Duration(seconds: 10));
    _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter = ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }


  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }


  @override
  Widget build(BuildContext context) {
   // QuestionController controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
              /*Get.offAll(InShort());*/
            }),
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                Spacer(),
          TextButton(child: Text("SKIP",style: TextStyle(color: Colors.white,fontSize: 15),),onPressed: (){
            controller.nextQuestion();
          },),
        ],),
        // Fluttter show the back button automatically
        backgroundColor: Colors.blue,
        elevation: 0,

      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Stack(children: [
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: MediaQuery.of(context).size.height/10,),
             Container(
               child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ProgressBar(),
            ),
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
                        fontSize: 14
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
                itemBuilder: (context, index) =>
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              questionController.questions[index].question,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16
                              ),
                            ),
                            const SizedBox(height: kDefaultPadding / 2),
                            ...List.generate(
                              questionController.questions[index].options.length,
                                  (i) => GetBuilder<QuestionController>(
                                      init: QuestionController(),
                                      builder: (qnController) {
                                        Color getTheRightColor() {
                                          if (qnController.isAnswered) {
                                            if (i == qnController.correctAns) {
                                              return kGreenColor;
                                            } else if (i == qnController.selectedAns &&
                                                qnController.selectedAns != qnController.correctAns) {
                                              return kRedColor;
                                            }
                                          }
                                          return kGrayColor;
                                        }

                                        IconData getTheRightIcon() {
                                          return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
                                        }

                                        return InkWell(
                                          onTap: ()  {
                                            controller.checkAns(questionController.questions[index], i);

                                            print('cureect ans=============${questionController.questions[index].answer}');
                                            print('${questionController.selectedAns}');

                                            if(questionController.questions[index].answer == questionController.selectedAns){
                                              _controllerCenter.play();
                                              Future.delayed(Duration(seconds: 1)).then((value) {
                                                _controllerCenter.stop();
                                              });
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(top: kDefaultPadding),
                                            padding: const EdgeInsets.all(kDefaultPadding),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: getTheRightColor()),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "${i + 1}. ${questionController.questions[index].options[i].toString()}",
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black
                                                  ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 26,
                                                  width: 26,
                                                  decoration: BoxDecoration(
                                                    color: getTheRightColor() == kGrayColor
                                                        ? Colors.transparent
                                                        : getTheRightColor(),
                                                    borderRadius: BorderRadius.circular(50),
                                                    border: Border.all(color: getTheRightColor()),
                                                  ),
                                                  child: getTheRightColor() == kGrayColor
                                                      ? null
                                                      : Icon(getTheRightIcon(), size: 16),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      })
                            ),
                          ],
                        ),
                      ),
                    )
                //questionController.questions[index]
              //index: index,
                //                             text: ,
                //                             press: () => controller.checkAns(question, index),
            ),)
          ],
        ),
          Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop:
            true, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
            createParticlePath: drawStar, // define a custom shape/path.
          ),
        ),
         ]),
      ),
    );
  }
}
