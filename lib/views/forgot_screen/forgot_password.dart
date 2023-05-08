import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:national_digital_notes_new/utils/constants/ColorValues.dart';
import 'package:national_digital_notes_new/views/dashboard_screen/controller_home_view.dart';
import 'package:national_digital_notes_new/views/dashboard_screen/Home_view.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/constants/api_service.dart';
import '../../utils/global_widgets/snackbar.dart';
import '../login_screen/login_view.dart';
import '../verification_screen/verification_views.dart';

class forgot_password_controller extends GetxController{
  RxBool on = false.obs; // our observable

  RxString email = ''.obs;
  RxString pass = ''.obs;

  var obscureNewPass = true.obs;
  TextEditingController emailController = TextEditingController();



  @override
  void onInit() {

    super.onInit();
  }
  Validation(){
    if(emailController.text.isEmpty){
      snackbar("Please enter your email.");
    }else{
      forgot_password();
    }

  }
  RxBool isLoading=false.obs;





  forgot_password() async {
    try {
      isLoading(true);
      var response = await ApiService()
          .forgot_password(emailController.text);
      print({'$response'});

      if (response['success'] == true) {

        snackbar(response['message'].toString());

        emailController.clear();

        SharedPreferences prefs = await SharedPreferences.getInstance();

        //Get.to( VerificationCodeRoute(otp:response['otp']));
        Get.to( LoginView());

      } else if (response['success'] == false) {
        snackbar(response['message'].toString());
      }

    } finally {
      isLoading(false);


    }
  }

}