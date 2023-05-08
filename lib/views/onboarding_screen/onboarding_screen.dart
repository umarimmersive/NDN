import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../pre_login_screen/pre_login_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  int currentPageIndex = 0;
  final introKey = GlobalKey<IntroductionScreenState>();

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                currentPageIndex = value;
              });
            },
            children: [
              SizedBox(
                child: Image.asset(
                  'assets/onboarding-images/Frame 1.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                child: Image.asset(
                  'assets/onboarding-images/Frame 3.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                child: Image.asset(
                  'assets/onboarding-images/Frame 2.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ]),
        Positioned(
          bottom: 10,
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Get.to( PreLoginScreen());
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                DotsIndicator(
                  dotsCount: 3,
                  position: double.parse(currentPageIndex.toString()),
                  decorator: DotsDecorator(
                    color: Colors.white,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                if (currentPageIndex != 2)
                  if (currentPageIndex != 2)
                    IconButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print('Current Page Index :: $currentPageIndex');
                          }
                          setState(() {
                            if (currentPageIndex < 2) {
                              currentPageIndex++;
                            }
                            pageController.animateToPage(currentPageIndex,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.slowMiddle);
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        )),
                if (currentPageIndex == 2)
                  TextButton(
                      onPressed: () {
                        Get.to( PreLoginScreen());
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
