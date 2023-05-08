import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSettingsController extends GetxController {
  var isdark = false;

  void changeTheme(state) {
    if (state == true) {
      isdark=true;
      Get.changeTheme(ThemeData.dark());
    } else {
      isdark=false;
      Get.changeTheme(ThemeData.light());
    }
    update();
  }




}
