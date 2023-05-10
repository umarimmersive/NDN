import 'dart:async';

import 'package:get/get.dart';

import '../views/Question.dart';


class TestController extends GetxController {
  //TODO: Implement OnlineTestSeriesController
  var countdown = 10.obs; // initial value of countdown is 10 seconds
  Timer? _timer;

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        _timer!.cancel();
      }
    });
  }

  void stopCountdown() {
    _timer?.cancel();
  }
  final questions = [
    Question(
      text: "What is the capital of France?",
      options: ["Paris", "London", "Berlin", "Madrid"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "What is the highest mountain in the world?",
      options: ["Mount Everest", "Mount Kilimanjaro", "Mount Fuji", "Mount Rushmore"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "What is the largest country by area?",
      options: ["Russia", "Canada", "China", "United States"],
      correctOptionIndex: 0,
    ),
  ];

  final userAnswers = <int>[].obs;

  void setUserAnswer(int index, int answerIndex) {
    userAnswers[index] = answerIndex;
    update();
  }
  final count = 0.obs;
  @override
  void onInit() {
    startCountdown();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
