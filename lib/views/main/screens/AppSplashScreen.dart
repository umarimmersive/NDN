// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/utils/constants/my_local_service.dart';
import 'package:national_digital_notes_new/views/pre_login_screen/pre_login_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/global_widgets/globle_var.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../dashboard_screen/Home_view.dart';
import '../utils/AppColors.dart';

class AppSplashScreen extends StatefulWidget {
  static String tag = '/ProkitSplashScreen';

  const AppSplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? scaleController;
  Animation<double>? scaleAnimation;

  bool _a = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;
  bool secondAnim = false;

  Color boxColor = Colors.transparent;

  @override
  void initState() {
    print('----------------------------------------call splash');
    super.initState();
    init();
  }



  void init() async {
    Timer(const Duration(milliseconds: 800), () {
      setState(() {
        boxColor = Colors.blue;
        _a = true;
      });
    });
    Timer(const Duration(milliseconds: 1700), () {
      setState(() {
        boxColor = context.scaffoldBackgroundColor;
        _c = true;
      });
    });
    Timer(const Duration(milliseconds: 1900), () {
      setState(() {
        _e = true;
      });
    });
    Timer(const Duration(milliseconds: 3400), () {
      secondAnim = true;

      scaleController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      )..forward();
      scaleAnimation =
          Tween<double>(begin: 0.0, end: 12).animate(scaleController!);

      setState(() {
        // boxColor = Colors.blue;
        _d = true;
      });
    });
    Timer(const Duration(milliseconds: 4200), () {
      secondAnim = true;
      setState(() {});
      navigateUser();
      //Get.to(const PreLoginScreen());
    });
  }

  void navigateUser() async {
    sharedPreference = await SharedPreferences.getInstance();
    if(my_local_service.isLoggedIn()){
      Get.to(DashboardView());
    }else{
      Get.to( PreLoginScreen());
    }

  }

  @override
  void dispose() {
    scaleController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 900 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                      ? h / 2.5
                      : 20,
              width: 20,
            ),
            AnimatedContainer(
              duration: Duration(seconds: _c ? 2 : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? h
                  : _c
                      ? 150
                      : 35,
              width: _d
                  ? w
                  : _c
                      ? 150
                      : 35,
              decoration: BoxDecoration(
                  color: boxColor,
                  //shape: _c? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: _d
                      ? const BorderRadius.only()
                      : BorderRadius.circular(30)),
              child: secondAnim
                  ? Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                            color: appSplashSecondaryColor,
                            shape: BoxShape.circle),
                        child: AnimatedBuilder(
                          animation: scaleAnimation!,
                          builder: (c, child) => Transform.scale(
                            scale: scaleAnimation!.value,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: appSplashSecondaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: _e
                          ? SizedBox(
                              child: Image.asset(
                                  'assets/android_logo/NDN Logo (1).png'))
                          : const SizedBox(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
