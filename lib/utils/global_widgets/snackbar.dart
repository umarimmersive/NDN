
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

snackbar(msg){
  return Get.snackbar(msg, '',
    duration: Duration(seconds: 1),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.blue,
    padding: EdgeInsets.symmetric(
        vertical: 5,horizontal: 5
    ),
    barBlur: 0,
    colorText: Colors.white,
    maxWidth: double.infinity,
    snackStyle: SnackStyle.GROUNDED,
    borderRadius: 10,);
}