import 'package:circular_countdown/circular_countdown.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/screens/quiz/quiz_screen.dart';
import 'package:national_digital_notes_new/utils/constants/api_service.dart';
import 'package:national_digital_notes_new/utils/global_widgets/globle_var.dart';
import 'package:national_digital_notes_new/utils/global_widgets/snackbar.dart';

import 'models/Questions.dart';

class AnimatedTimer extends StatefulWidget {
  const AnimatedTimer({Key? key}) : super(key: key);

  @override
  State<AnimatedTimer> createState() => _AnimatedTimerState();
}

class _AnimatedTimerState extends State<AnimatedTimer> {
  final int _duration = 5;
  final CountDownController _controller = CountDownController();
  @override
  void initState() {
     Get_quiz_api(Today_date,Select_language);
    // controller.start();
    // controller.resume();
    Future.delayed(Duration(seconds: 1)).then((value) => _controller.start());
    super.initState();
  }


  final isLoading=false.obs;



  Get_quiz_api( Today_date,Select_language) async {
    try {
      sample_data.clear();
      isLoading(true);
      print({'response==================================$Today_date'});
      print({'response==================================$Select_language'});


      var response = await ApiService().Get_quiz(Today_date, Select_language);
      print({'response==================================$response'});

      if (response['success'] == true) {

        sample_data.addAll(response['data']);

        print("sample_data=========================$sample_data");
        //snackbar(response['message']);



        isLoading(false);
       // update();
      } else if (response['success'] == false) {

        snackbar(response['message']);

        isLoading(false);
      }

    } finally {
      isLoading(false);


    }
  }









  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.black,
        body: Center(
          child: GestureDetector(
            onTap: (){
              _controller.start();
            },
            child: CircularCountDownTimer(
              duration: _duration,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: Colors.grey[300]!,
              ringGradient: null,
              fillColor: Colors.blueAccent[100]!,
              fillGradient: null,
              backgroundColor: Colors.blue[500],
              backgroundGradient: null,
              strokeWidth: 20.0,
              isReverse: true,
              isReverseAnimation: true,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(
                  fontSize: 33.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textFormat: CountdownTextFormat.S,

              isTimerTextShown: true,
              autoStart: false,
              onStart: () {
                debugPrint('Countdown Started');
              },
              onComplete: () {
                debugPrint('Countdown Ended');
                Get.to(QuizScreen());
                },
              onChange: (String timeStamp) {
                debugPrint('Countdown Changed $timeStamp');
              },
            ),
          ),
        ));
  }
}
